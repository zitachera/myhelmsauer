package data

import (
	"database/sql"
	"fmt"
)

type User struct {
	Name         string
	Passhash     string
	Mainname     string
	Password     string
	Gruppe       string
	Creationdate string
}

func LoadUsers() ([]User, error) {
	return queryRows("select Name, Passhash, MainUser, MainPassword, Portal, CreationDate from SubAccount",
		scanUser,
	)
}
func scanUser(rows *sql.Rows) (User, error) {
	var user User
	return user, rows.Scan(
		&user.Name,
		&user.Passhash,
		&user.Mainname,
		&user.Password,
		&user.Gruppe,
		&user.Creationdate,
	)
}
func LoadUser(name string) (User, error) {
	return queryRow("select Name, Passhash, MainUser, MainPassword, Portal, CreationDate from SubAccount "+
		"where Name=?",
		scanUser,
		name,
	)
}

func RemoveUser(user string) error {
	_, err := db.Exec("delete from SubAccount where Name=?",
		user,
	)
	if err != nil {
		return err
	}
	_, err = db.Exec("delete from Vertrag where SubAccountName=?",
		user,
	)
	return err
}

func AddUser(name, passhash, mainUser, mainPassword, portal string) error {
	_, err := db.Exec("insert into SubAccount (Name, Passhash, MainUser, MainPassword, Portal) "+
		"values (?,?,?,?,?)",
		name,
		passhash,
		mainUser,
		mainPassword,
		portal,
	)
	return err
}

func UpdateUser(name, passhash, mainUser, mainPassword, portal string) error {
	res, err := db.Exec("update SubAccount set Passhash=?, MainUser=?, MainPassword=?, Portal=? "+
		"where Name=?",
		passhash,
		mainUser,
		mainPassword,
		portal,

		name,
	)
	if err != nil {
		return err
	}
	n, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if n == 0 {
		return fmt.Errorf("no user %s in the system", name)
	}
	return err
}

func RemoveVerträgeFromUser(user string) error {
	_, err := db.Exec("delete from Vertrag where SubAccountName=?",
		user,
	)
	return err
}

func RemoveVertragFromUser(user, vertragId string) error {
	_, err := db.Exec("delete from Vertrag where SubAccountName=? and VertragId=?",
		user,
		vertragId,
	)
	return err
}

func AddVertragToUser(user, vertragId string) error {
	_, err := db.Exec("insert into Vertrag (SubAccountName, VertragId) values (?,?)",
		user,
		vertragId,
	)
	return err
}

type rowScanner[T any] func(*sql.Rows) (T, error)

func queryRows[T any](query string, scan rowScanner[T], args ...any) ([]T, error) {
	ts := make([]T, 0, 8)
	rows, err := db.Query(query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		t, err := scan(rows)
		if err != nil {
			return nil, err
		}
		ts = append(ts, t)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	return ts, nil
}

func queryRow[T any](query string, scan rowScanner[T], args ...any) (T, error) {
	var t T
	rows, err := db.Query(query, args...)
	if err != nil {
		return t, err
	}
	defer rows.Close()

	if !rows.Next() {
		return t, fmt.Errorf("no data found")
	}

	t, err = scan(rows)
	if err != nil {
		return t, err
	}

	if err := rows.Close(); err != nil {
		return t, err
	}
	return t, nil
}
