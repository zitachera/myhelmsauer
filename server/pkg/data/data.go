package data

import (
	"database/sql"
	"errors"

	// import sqlite driver
	_ "github.com/mattn/go-sqlite3"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/proclient"
)

var db *sql.DB

const MyHelmsauerGroup = "myh"

// StoreCredentials stores given credentials in the database or returns an error
func StoreCredentials(token string, c proclient.Client) error {
	_, err := db.Exec("insert into Credential (Token, User, Password, Portal) values (?,?,?,?)",
		token,
		c.User,
		c.Password,
		c.Gruppe)
	return err
}

// StoreSubAccountToken stores given access token for given user in the database or returns an error
func StoreSubAccountToken(token, account string) error {
	_, err := db.Exec("insert into Credential (Token, User, Password, Portal) values (?,?,?,?)",
		token,
		account,
		"",
		MyHelmsauerGroup)
	return err
}

// LoadCredentials loads the credentials for given token.
func LoadCredentials(token string) (proclient.Client, error) {
	var c proclient.Client
	rows, err := db.Query("select User, Password, Portal from Credential where Token = ?", token)
	if err != nil {
		return proclient.Client{}, err
	}
	defer rows.Close()
	if !rows.Next() {
		return proclient.Client{}, errors.New("unknown login token")
	}
	if err := rows.Scan(&c.User, &c.Password, &c.Gruppe); err != nil {
		return proclient.Client{}, err
	}
	if err := rows.Close(); err != nil {
		return proclient.Client{}, err
	}
	if c.Gruppe == MyHelmsauerGroup {
		return LoadSubaccount(c.User)
	}

	return c, nil
}

// LoadSubaccount returns a sub account with the given name or an error.
func LoadSubaccount(subAccountName string) (client proclient.Client, err error) {
	var c proclient.Client
	rows, err := db.Query("select Passhash, MainUser, MainPassword, Portal from SubAccount where Name = ?", subAccountName)
	if err != nil {
		return proclient.Client{}, err
	}
	defer rows.Close()
	if !rows.Next() {
		return proclient.Client{}, errors.New("unknown user")
	}
	c.SubAccount = subAccountName
	if err := rows.Scan(&c.PasswordHash, &c.User, &c.Password, &c.Gruppe); err != nil {
		return proclient.Client{}, err
	}
	if err := rows.Close(); err != nil {
		return proclient.Client{}, err
	}
	vertragIds, err := LoadVertragIds(subAccountName)

	if err != nil {
		return proclient.Client{}, err
	}
	c.VertragIds = map[string]struct{}{}
	for _, id := range vertragIds {
		c.VertragIds[id] = struct{}{}
	}
	return c, nil
}

// LoadVertragIds returns a slice of the vertrag ids of the user with given account name or an error.
func LoadVertragIds(subAccountName string) ([]string, error) {
	ids := make([]string, 0, 8)
	rows, err := db.Query("select VertragId from Vertrag where SubAccountName = ?", subAccountName)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var id string
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		ids = append(ids, id)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	return ids, nil
}

// UniqueLogins returns the number of unique logins.
func UniqueLogins() (int, error) {
	var n int
	rows, err := db.Query("select count (*) from (select distinct User, Portal from Credential)")
	if err != nil {
		return 0, err
	}
	defer rows.Close()
	if !rows.Next() {
		return 0, errors.New("unknown login token")
	}
	if err := rows.Scan(&n); err != nil {
		return 0, err
	}
	return n, nil
}
