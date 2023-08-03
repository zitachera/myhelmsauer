package auth

import (
	"encoding/json"
	"html/template"
	"net/http"

	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/mail"
)

func PostRemind(recipients []string) http.HandlerFunc {
	bodyTemplate := template.Must(template.New("body").Parse(`<p>
Ein Passwort wurde angefordert. Bitte prüfen Sie die Anfrage bevor Sie dem Kunden sein Passwort zusenden.
</p>

<h2>Name</h2>
<blockquote>
{{.Nachname}}, {{.Vorname}}
</blockquote>

<h2>Adresse</h2>
<blockquote>
{{.Adresse}}
</blockquote>`))

	type requestBody struct {
		Nachname string `json:"nachname"`
		Vorname  string `json:"vorname"`
		Adresse  string `json:"adresse"`
	}

	return func(w http.ResponseWriter, r *http.Request) {
		var m requestBody
		if err := json.NewDecoder(r.Body).Decode(&m); err != nil {
			handleError(w, err.Error(), http.StatusBadRequest)
			return
		}

		email := mail.New()

		if err := email.Send("Passwort Anforderung "+m.Nachname+", "+m.Vorname,
			recipients, bodyTemplate, m); err != nil {
			handleError(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
}
