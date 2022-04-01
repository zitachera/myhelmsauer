package api

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"strings"

	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/auth"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/handle"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/data"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/sparte"
)

func Vertraege(w http.ResponseWriter, r *http.Request) {
	c := auth.GetClientFromRequest(r)

	vs, err := c.GetVertraege()
	if err != nil {
		handleError(w, err.Error(), http.StatusInternalServerError)
		return
	}

	vertraege := make([]vertrag, len(vs))

	for i, v := range vs {
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

	if err := json.NewEncoder(w).Encode(vertraege); err != nil {
		handleError(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

// Dokument bietet ein ProCLient Dokument direkt zum Download an.
func Dokument(w http.ResponseWriter, r *http.Request) {
	c := auth.GetClientFromRequest(r)

	contentType, body, err := c.GetDokument(AdressID.From(r), DokumentID.From(r))
	if err != nil {
		handleError(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", contentType)

	_, err = w.Write(body)

	if err != nil {
		handleError(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func Stats(w http.ResponseWriter, r *http.Request) {
	n, err := data.UniqueLogins()
	if err != nil {
		handleError(w, err.Error(), http.StatusInternalServerError)
		return
	}

	if err := json.NewEncoder(w).Encode(struct {
		UniqueLogins int
	}{
		UniqueLogins: n,
	}); err != nil {
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
