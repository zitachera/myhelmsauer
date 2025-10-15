package api

import (
	"context"
	"fmt"
	"net/http"
	"net/url"
	"strings"

	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/auth"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/handle"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/sparte"
)

func Verträge(ctx context.Context) ([]vertrag, error) {
	c := auth.GetClient(ctx)

	vs, err := c.GetVertraege()
	if err != nil {
		return nil, err
	}

	vertraege := make([]vertrag, len(vs))

	sub := c.Gruppe == "myh"

	for i, v := range vs {
		if sub {
			vertraege[i] = vertrag{
				ID:             v.ID,
				Status:         "nicht sichtbar",
				SpartenName:    v.SpartenName,
				Risiko:         v.Risiko,
				Beitrag:        "nicht sichtbar",
				Gesellschaft:   v.Gesellschaft,
				Vertragsnummer: "nicht sichtbar",
				Ablauf:         "nicht sichtbar",
				Sparte:         sparte.ByProClientID(v.SpartenID),
				Dokumente:      []dokument{},
			}
			continue
		}
		doks := make([]dokument, 0, len(v.Dokumente))
		for _, d := range v.Dokumente {
			if d.Deleted || !d.Online {
				continue
			}
			doks = append(doks, dokument{
				Endpoint: "/adressen/" + url.PathEscape(v.AdresseID) + "/dokumente/" + url.PathEscape(d.ID),
				Titel:    d.Titel,
			})
		}
		vertraege[i] = vertrag{
			ID:             v.ID,
			Status:         strings.ToLower(v.Status),
			SpartenName:    v.SpartenName,
			Risiko:         v.Risiko,
			Beitrag:        v.NettotJahrebeitrag,
			Gesellschaft:   v.Gesellschaft,
			Vertragsnummer: v.Nr,
			Ablauf:         v.Ablauf,
			Sparte:         sparte.ByProClientID(v.SpartenID),
			Dokumente:      doks,
		}
	}

	return vertraege, nil
}

// Dokument bietet ein ProCLient Dokument direkt zum Download an.
func Dokument(w http.ResponseWriter, r *http.Request) {
	c := auth.GetClientFromRequest(r)

	_, body, err := c.GetDokument(AdressID.From(r), DokumentID.From(r))
	if err != nil {
		handleError(w, err.Error(), http.StatusInternalServerError)
		return
	}
    if r.Method == http.MethodOptions {
        w.WriteHeader(http.StatusNoContent)
        return
    }

	_, err = w.Write(body)

	if err != nil {
		handleError(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

const (
	AdressID   handle.URLParameter = "adressID"
	DokumentID handle.URLParameter = "dokumentID"
)

func handleError(w http.ResponseWriter, error string, code int) {
	fmt.Println(code, error)
	http.Error(w, error, code)
}

type vertrag struct {
	ID             string `json:"id"`
	SpartenName    string `json:"sparte"`
	Gesellschaft   string `json:"gesellschaft"`
	Vertragsnummer string `json:"vertragsnummer"`
	Ablauf         string `json:"ablauf"`
	Status         string `json:"status"`
	Beitrag        string `json:"beitrag"`
	Risiko         string `json:"risiko"`
	sparte.Sparte
	Dokumente []dokument `json:"dokumente"`
}

type dokument struct {
	Endpoint string `json:"endpoint"`
	Titel    string `json:"titel"`
}
