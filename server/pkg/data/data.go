package data

import (
	"database/sql"
	"errors"

	// import sqlite driver
	_ "github.com/mattn/go-sqlite3"
	"gitlab.helmsauer2000.local/PaedGroup/customerserver/pkg/proclient"
)

var db *sql.DB

func init() {
	var err error
	db, err = sql.Open("sqlite3", "file:database.db")
	if err != nil {
		panic(err)
	}
	_, err = db.Exec("create table if not exists Credential (Id integer primary key not null, " +
		"Token            text not null unique," +
		"User             text not null," +
		"Password         text not null," +
		"Portal           text not null," +
		"CreationDate     text not null default current_timestamp)")
	if err != nil {
		panic(err)
	}
}

// StoreCredentials stores given credentials in the database or returns an error
func StoreCredentials(token string, c proclient.Client) error {
	_, err := db.Exec("insert into Credential (Token, User, Password, Portal) values (?,?,?,?)",
		token,
		c.User,
		c.Password,
		c.Gruppe)
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
	return c, nil
}
