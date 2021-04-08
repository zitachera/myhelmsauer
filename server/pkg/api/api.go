package api

import (
	"encoding/json"
	"net/http"
	"strings"

	"github.com/google/uuid"

	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/data"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/mail"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/proclient"
)

// add a super basic api

func Melden(w http.ResponseWriter, r *http.Request) {
	c, err := data.LoadCredentials(r.Header.Get("authorization"))
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}

	var m meldung
	if err := json.NewDecoder(r.Body).Decode(&m); err != nil {
		http.Error(w, err.Error(), 500)
		return
	}

	if err := mail.Send(mail.Meldung{
		User:           c.User,
		Schadenhergang: m.Schadenhergang,
		Aufnahmen:      m.Aufnahmen,
	}); err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
}

func Vertraege(w http.ResponseWriter, r *http.Request) {
	c, err := data.LoadCredentials(r.Header.Get("authorization"))
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}

	vs, err := c.GetVertraege()
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}

	vertraege := make([]vertrag, len(vs))

	for i, v := range vs {
		vertraege[i] = vertrag{
			ID:                 v.ID,
			Status:             strings.ToLower(v.Status),
			Sparte:             v.SpartenName,
			Risiko:             v.Risiko,
			Beitrag:            v.NettotJahrebeitrag,
			Gesellschaft:       v.Gesellschaft,
			Vertragsnummer:     v.Nr,
			Ablauf:             v.Ablauf,
			AufnahmeKategorien: aufnahmeKategorienForSparte(v.SpartenID),
		}
	}

	if err := json.NewEncoder(w).Encode(vertraege); err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
}

func Login(w http.ResponseWriter, r *http.Request) {
	var l requestLogin
	if err := json.NewDecoder(r.Body).Decode(&l); err != nil {
		http.Error(w, err.Error(), 500)
		return
	}

	client := proclient.Client{
		User:     l.User,
		Password: l.Password,
		Gruppe:   l.Gruppe,
	}

	msg, ok, err := client.Login()
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	if !ok {
		http.Error(w, msg, 403)
		return
	}

	token := uuid.New().String()

	data.StoreCredentials(token, client)

	if err := json.NewEncoder(w).Encode(map[string]interface{}{
		"token": token,
	}); err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
}

type meldung struct {
	ID             string               `json:"id"`
	Titel          string               `json:"titel"`
	VertragsID     string               `json:"vertragsID"`
	Zeitpunkt      string               `json:"zeitpunkt"`
	Schadenhergang string               `json:"schadenhergang"`
	Ort            string               `json:"ort"`
	Latitude       string               `json:"latitude"`
	Longitude      string               `json:"longitude"`
	Aufnahmen      map[string][][]uint8 `json:"aufnahmen"`
}

type vertrag struct {
	ID                 string                     `json:"id"`
	Sparte             string                     `json:"sparte"`
	Gesellschaft       string                     `json:"gesellschaft"`
	Vertragsnummer     string                     `json:"vertragsnummer"`
	Ablauf             string                     `json:"ablauf"`
	Status             string                     `json:"status"`
	Beitrag            string                     `json:"beitrag"`
	Risiko             string                     `json:"risiko"`
	AufnahmeKategorien []vertragAufnahmeKategorie `json:"aufnahmeKategorien"`
}

type vertragAufnahmeKategorie struct {
	ID           string `json:"id"`
	Label        string `json:"label"`
	Beschreibung string `json:"beschreibung"`
	Max          int    `json:"max"`
	Min          int    `json:"min"`
}

type requestLogin struct {
	User     string `json:"user"`
	Password string `json:"password"`
	Gruppe   string `json:"gruppe"`
}
