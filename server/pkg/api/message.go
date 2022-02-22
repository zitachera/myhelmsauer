package api

import (
	"encoding/json"
	"fmt"
	"html/template"
	"net/http"
	"sort"
	"strings"

	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/auth"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/mail"
)

func PostMessage(recipients []string) http.HandlerFunc {
	bodyTemplate := template.Must(template.New("body").Parse(`<p>
{{.KundeAnrede}} {{.KundeTitel}} {{.KundeName}} {{.KundeName2}} {{.KundeName3}} <br/>
{{.KundeStrasse}} {{.KundeHausnr}} <br/>
{{.KundePlz}} {{.KundeOrt}} {{.KundeLandkz}} <br/>


<h2>Text</h2>
<blockquote>
{{.Text}}
</blockquote>
`))

	type data struct {
		Text string

		KundeAnrede  string
		KundeTitel   string
		KundeName    string
		KundeName2   string
		KundeName3   string
		KundeStrasse string
		KundeHausnr  string
		KundePlz     string
		KundeOrt     string
		KundeLandkz  string
	}

	type requestBody struct {
		Text  string             `json:"text"`
		Files map[string][]uint8 `json:"files"`
	}
	return func(w http.ResponseWriter, r *http.Request) {
		c := auth.GetClientFromRequest(r)

		var m requestBody
		if err := json.NewDecoder(r.Body).Decode(&m); err != nil {
			handleError(w, err.Error(), http.StatusBadRequest)
			return
		}

		if c.User == "maxmustermann" && c.Gruppe == "hk" {
			return
		}

		adressen, err := c.GetAdressen()

		if err != nil {
			handleError(w, err.Error(), http.StatusBadRequest)
			return
		}

		if len(adressen) == 0 {
			handleError(w, "Keine Kundenadresse vermerkt", http.StatusBadRequest)
			return
		}

		adresse := adressen[0]

		categories := make([]string, 0, len(m.Files))

		for cat := range m.Files {
			categories = append(categories, cat)
		}

		email := mail.New()

		sort.Strings(categories)
		for _, cat := range categories {
			data := m.Files[cat]
			mime := http.DetectContentType(data)
			ext := "bin"
			if strings.HasPrefix(mime, "image/") {
				ext = strings.Split(mime, "/")[1]
			}
			name := fmt.Sprintf("%s.%s", cat, ext)
			email.AddAttachmentData(data, name, mime)
		}

		if err := email.Send("Nachricht von "+c.User+" bei "+c.PortalName(), recipients, bodyTemplate,

			data{
				Text: m.Text,

				KundeAnrede:  adresse.KundeAnrede,
				KundeTitel:   adresse.KundeTitel,
				KundeName:    adresse.KundeName,
				KundeName2:   adresse.KundeName2,
				KundeName3:   adresse.KundeName3,
				KundeStrasse: adresse.KundeStrasse,
				KundeHausnr:  adresse.KundeHausnr,
				KundePlz:     adresse.KundePlz,
				KundeOrt:     adresse.KundeOrt,
				KundeLandkz:  adresse.KundeLandkz,
			}); err != nil {
			handleError(w, err.Error(), http.StatusBadRequest)
			return
		}
	}
}
