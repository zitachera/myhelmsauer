package verzeichnis

import (
	"context"
	"strconv"

	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/auth"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/handle"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/data"
)

type Wertgegenstand struct {
	ID int `json:"id"`

	CreationDate string `json:"creationDate"`
	UpdateDate   string `json:"updateDate"`

	Name         string  `json:"name"`
	Beschreibung string  `json:"beschreibung"`
	Wert         float64 `json:"wert"`
	Image        []byte  `json:"image"`
}

func GetVerzeichnis(ctx context.Context) ([]Wertgegenstand, error) {
	c := auth.GetClient(ctx)

	verzeichnis, err := data.LoadVerzeichnis(c.Gruppe, c.User)
	if err != nil {
		return nil, err
	}
	out := make([]Wertgegenstand, len(verzeichnis))
	for i, w := range verzeichnis {
		out[i] = Wertgegenstand{
			ID:           w.ID,
			CreationDate: w.CreationDate,
			UpdateDate:   w.UpdateDate,
			Name:         w.Name,
			Beschreibung: w.Beschreibung,
			Wert:         w.Wert,
			Image:        w.Image,
		}
	}
	return out, nil
}

func PutWertgegenstand(ctx context.Context, wertgegenstand Wertgegenstand) ([]Wertgegenstand, error) {
	c := auth.GetClient(ctx)

	entry := data.Verzeichnis{
		ID: wertgegenstand.ID,

		FirmenGruppe: c.Gruppe,
		UserName:     c.User,

		Name:         wertgegenstand.Name,
		Beschreibung: wertgegenstand.Beschreibung,
		Wert:         wertgegenstand.Wert,
		Image:        wertgegenstand.Image,
	}

	if err := data.SaveWertgegenstand(entry); err != nil {
		return nil, err
	}

	return GetVerzeichnis(ctx)
}

const (
	ID handle.URLParameter = "verzeichnisID"
)

func DeleteWertgegenstand(ctx context.Context) ([]Wertgegenstand, error) {
	c := auth.GetClient(ctx)
	id, err := strconv.Atoi(ID.FromContext(ctx))
	if err != nil {
		return nil, err
	}

	if err := data.DeleteWertgegenstand(id, c.Gruppe, c.User); err != nil {
		return nil, err
	}

	return GetVerzeichnis(ctx)
}
