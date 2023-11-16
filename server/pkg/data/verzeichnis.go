package data

import "time"

type Verzeichnis struct {
	ID int `gorm:"primaryKey;autoIncrement"`

	FirmenGruppe string `gorm:"not null;index user-id"`
	UserName     string `gorm:"not null;index user-id"`

	CreationDate string `gorm:"not null;<-:create"`
	UpdateDate   string `gorm:"not null"`

	Name         string  `gorm:"not null"`
	Beschreibung string  `gorm:"not null;default:''"`
	Wert         float64 `gorm:"not null"`
	Image        []byte  `gorm:"not null"`
}

func LoadVerzeichnis(gruppe, user string) ([]Verzeichnis, error) {
	var verzeichnis []Verzeichnis
	if err := db.
		Where("FirmenGruppe=?", gruppe).
		Where("UserName=?", user).
		Find(&verzeichnis).
		Error; err != nil {
		return nil, err
	}
	return verzeichnis, nil
}

func DeleteWertgegenstand(id int, gruppe, user string) error {
	return db.
		Where("FirmenGruppe=?", gruppe).
		Where("UserName=?", user).
		Delete(&Verzeichnis{}, id).
		Error
}

func SaveWertgegenstand(g Verzeichnis) error {
	var old Verzeichnis
	if g.ID != 0 {
		if err := db.
			Where("id=?", g.ID).
			Where("FirmenGruppe=?", g.FirmenGruppe).
			Where("UserName=?", g.UserName).
			Find(&old).
			Error; err != nil {
			return err
		}
	} else {
		g.CreationDate = time.Now().Format(time.DateTime)
	}

	g.UpdateDate = time.Now().Format(time.DateTime)
	return db.Save(&g).Error
}
