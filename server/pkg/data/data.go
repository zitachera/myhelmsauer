package data

import (
	"errors"
	"fmt"

	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/proclient"
	"gorm.io/gorm"
)

var db *gorm.DB

const MyHelmsauerGroup = "myh"


// StoreCredentials stores given credentials in the database or returns an error
func StoreCredentials(c Session) error {
	fmt.Println(c)
	return db.Exec("insert into Credential (Token, User, Password, Portal) values (?,?,?,?)",
		c.AuthToken,
		c.User,
		c.Password,
		c.Gruppe,
	).Error
}

// StoreSubAccountToken stores given access token for given user in the database or returns an error
func StoreSubAccountToken(token, account string) error {
	return db.Exec("insert into Credential (Token, User, Password, Portal) values (?,?,?,?)",
		token,
		account,
		"",
		MyHelmsauerGroup,
	).Error
}

// LoadCredentials loads the credentials for given token.
func LoadCredentials(token string) (Session, error) {
	var c Session
	c.AuthToken = token
	rows, err := db.Raw("select User, Password, Portal from Credential where Token = ?", token).Rows()
	if err != nil {
		return Session{}, err
	}
	defer rows.Close()
	if !rows.Next() {
		return Session{}, errors.New("unknown login token")
	}
	if err := rows.Scan(&c.User, &c.Password, &c.Gruppe); err != nil {
		return Session{}, err
	}
	if err := rows.Close(); err != nil {
		return Session{}, err
	}
	if c.Gruppe == MyHelmsauerGroup {
		return LoadSubaccount(token, c.User)
	}

	return c, nil
}

// LoadSubaccount returns a sub account with the given name or an error.
func LoadSubaccount(token, subAccountName string) (Session, error) {
	if subAccountName == "" {
		return Session{}, errors.New("subAccountName cannot be empty")
	}
	var c Session
	c.AuthToken = token
	rows, err := db.Raw("select Passhash, MainUser, MainPassword, Portal from SubAccount where Name = ?", subAccountName).Rows()
	if err != nil {
		return Session{}, fmt.Errorf("failed to query SubAccount: %w", err)
	}
	defer rows.Close()
	if !rows.Next() {
		return Session{}, errors.New("unknown user")
	}
	c.SubAccount = subAccountName
	if err := rows.Scan(&c.PasswordHash, &c.User, &c.Password, &c.Gruppe); err != nil {
		return Session{}, err
	}
	if err := rows.Close(); err != nil {
		return Session{}, err
	}
	vertragIds, err := LoadVertragIds(subAccountName)

	if err != nil {
		return Session{}, err
	}
	c.VertragIds = map[string]struct{}{}
	for _, id := range vertragIds {
		c.VertragIds[id] = struct{}{}
	}
	return c, nil
}

type Credential struct {
	Id           int    `gorm:"primaryKey;autoIncrement"`
	Token        string `gorm:"not null;index"`
	User         string `gorm:"not null"`
	Password     string `gorm:"not null"`
	Portal       string `gorm:"not null"`
	CreationDate string `gorm:"not null;default:current_timestamp"`
}

type SubAccount struct {
	Name         string `gorm:"primaryKey"`
	Passhash     string `gorm:"not null"`
	MainUser     string `gorm:"not null"`
	MainPassword string `gorm:"not null"`
	Portal       string `gorm:"not null"`
	CreationDate string `gorm:"not null;default:current_timestamp"`
}

type Vertrag struct {
	Id             int    `gorm:"primaryKey;autoIncrement"`
	SubAccountName string `gorm:"not null;index"`
	VertragId      string `gorm:"not null"`
	CreationDate   string `gorm:"not null;default:current_timestamp"`
}

// UpdateCredentials updates given credentials in the database.
// It updates all subaccounts and removes other stored credentials for this account.
func UpdateCredentials(c Session) error {
	if err := db.Exec("update Credential set Password=? where Token=? and User=? and Portal=?",
		c.Password,
		c.AuthToken,
		c.User,
		c.Gruppe).Error; err != nil {
		return err
	}
	fmt.Println(c.Password,
		c.AuthToken,
		c.User,
		c.Gruppe,
	)
	if err := db.Exec("update SubAccount set MainPassword=? where MainUser=? and Portal=?",
		c.Password,
		c.User,
		c.Gruppe,
	).Error; err != nil {
		return err
	}
	if err := db.Exec("delete from Credential where User=? and Token<>? and Portal=?",
		c.User,
		c.AuthToken,
		c.Gruppe,
	).Error; err != nil {
		return err
	}
	return nil
}

// UpdateSubCredentials updates given credentials for the subaccount in the database.
// It removes other stored credentials for this subaccount.
func UpdateSubCredentials(c Session) error {
	if err := db.Exec("update SubAccount set Passhash=? where Name=?",
		c.PasswordHash,
		c.SubAccount,
		c.Gruppe,
	).Error; err != nil {
		return err
	}
	if err := db.Exec("delete from Credential where User=? and Token<>? and Portal=?",
		c.SubAccount,
		c.AuthToken,
		c.Gruppe,
	).Error; err != nil {
		return err
	}
	return nil
}

// LoadVertragIds returns a slice of the vertrag ids of the user with given account name or an error.
func LoadVertragIds(subAccountName string) ([]string, error) {
	ids := make([]string, 0, 8)
	if err := db.
		Raw("select VertragId from Vertrag where SubAccountName = ?", subAccountName).
		Scan(&ids).
		Error; err != nil {
		return nil, err
	}
	return ids, nil
}

// UniqueLogins returns the number of unique logins.
func UniqueLogins() (int, error) {
	var n int
	if err := db.
		Raw("select count (*) from (select distinct User, Portal from Credential)").
		Scan(&n).
		Error; err != nil {
		return 0, err
	}
	return n, nil
}

// UniqueLoginsByPortal returns the number of unique logins.
func UniqueLoginsByPortal() (map[string]int, error) {
	rows, err := db.Raw("select count (*), Portal from (select distinct User, Portal from Credential) GROUP BY Portal").Rows()
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	res := make(map[string]int)
	for rows.Next() {
		var n int
		var portal string
		if err := rows.Scan(&n, &portal); err != nil {
			return nil, err
		}
		fullname := proclient.PortalName(portal)
		res[fullname] += n
	}
	return res, nil
}
