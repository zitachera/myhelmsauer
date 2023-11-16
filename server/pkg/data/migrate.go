package data

import (
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"gorm.io/gorm/schema"
)

func Open(dsn string) error {
	var err error
	db, err = gorm.Open(sqlite.Open(dsn), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{
			SingularTable: true,
			NoLowerCase:   true,
		},
	})
	if err != nil {
		return err
	}

	if err := db.AutoMigrate(
		&Credential{},
		&SubAccount{},
		&Vertrag{},
		&Verzeichnis{},
	); err != nil {
		return err
	}
	return nil
}
