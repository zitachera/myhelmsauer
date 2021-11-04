package api

import (
	"encoding/json"
	"html/template"
	"net/http"
	"sort"

	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/auth"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/mail"
)

func PostForeignVertrag(recipients []string) http.HandlerFunc {
	bodyTemplate := template.Must(template.New("body").Parse(`<p>
{{.KundeAnrede}} {{.KundeTitel}} {{.KundeName}} {{.KundeName2}} {{.KundeName3}} <br/>
{{.KundeStrasse}} {{.KundeHausnr}} <br/>
{{.KundePlz}} {{.KundeOrt}} {{.KundeLandkz}} <br/>
</p>

<p>
Der Kunde {{.KundeName}} hat
</p>

`))

	type data struct {
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
		Files map[string][][]uint8 `json:"files"`
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
			handleError(w, err.Error(), http.StatusInternalServerError)
			return
		}
		if len(adressen) == 0 {
			handleError(w, "Keine Adresse mit Account "+c.Gruppe+"/"+c.User, http.StatusBadRequest)
			return
		}

		fileNames := make([]string, 0, len(m.Files))

		for cat := range m.Files {
			fileNames = append(fileNames, cat)
		}

		email := mail.New()

		sort.Strings(fileNames)
		for _, name := range fileNames {
			for _, data := range m.Files[name] {
				mime := http.DetectContentType(data)
				email.AddAttachmentData(data, name, mime)
			}
		}

		if err := email.Send("Schadenmeldung von "+c.Gruppe+" / "+c.User, recipients, bodyTemplate,

			data{
				KundeAnrede:  adressen[0].KundeAnrede,
				KundeTitel:   adressen[0].KundeTitel,
				KundeName:    adressen[0].KundeName,
				KundeName2:   adressen[0].KundeName2,
				KundeName3:   adressen[0].KundeName3,
				KundeStrasse: adressen[0].KundeStrasse,
				KundeHausnr:  adressen[0].KundeHausnr,
				KundePlz:     adressen[0].KundePlz,
				KundeOrt:     adressen[0].KundeOrt,
				KundeLandkz:  adressen[0].KundeLandkz,
			}); err != nil {
			handleError(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
}
