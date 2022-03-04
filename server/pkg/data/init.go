package data

import (
	"database/sql"
	"strings"
)

func init() {
	var err error
	db, err = sql.Open("sqlite3", "file:database.db")
	if err != nil {
		panic(err)
	}
	mustExec("create table if not exists Credential (Id integer primary key not null, " +
		"Token            text not null unique," +
		"User             text not null," +
		"Password         text not null," +
		"Portal           text not null," +
		"CreationDate     text not null default current_timestamp)")
	mustRecreateIndex("Credential", "Token")

	mustExec("create table if not exists SubAccount (Name text primary key not null," +
		"Passhash         text not null," +
		"MainUser         text not null," +
		"MainPassword     text not null," +
		"Portal           text not null," +
		"CreationDate     text not null default current_timestamp)")
	mustRecreateIndex("SubAccount", "Name")

	mustExec("create table if not exists Vertrag (Id integer primary key not null, " +
		"SubAccountName   text not null," +
		"VertragId        text not null," +
		"CreationDate     text not null default current_timestamp)")
	mustRecreateIndex("Vertrag", "SubAccountName")

}

func mustExec(query string, args ...any) sql.Result {
	result, err := db.Exec(query, args...)
	if err != nil {
		panic(err)
	}
	return result
}

func mustRecreateIndex(table string, fields ...string) {
	name := table + "_" + strings.Join(fields, "_")
	mustExec("drop index if exists " + name)
	mustExec("create index " + name + " on " + table + " (" + strings.Join(fields, ",") + ")")
}
