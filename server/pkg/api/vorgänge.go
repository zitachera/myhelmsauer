package api

import (
	"encoding/json"
	"fmt"
	"html/template"
	"net/http"
	"sort"
	"strings"
	"time"

	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/auth"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/mail"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/sparte"
)

func PostVorgang(recipients []string) http.HandlerFunc {
	bodyTemplate := template.Must(template.New("body").Parse(`<p>
{{.KundeAnrede}} {{.KundeTitel}} {{.KundeName}} {{.KundeName2}} {{.KundeName3}} <br/>
{{.KundeStrasse}} {{.KundeHausnr}} <br/>
{{.KundePlz}} {{.KundeOrt}} {{.KundeLandkz}} <br/>
</p>
<h2>Vertragdetails</h2>
<p>
<table cellspacing="5" cellpadding="5" border="0">

<tr> 	
<td>Versicherungsnummer: </td>
<td>{{.Versicherungsnummer}}</td> 
</tr>

<tr> 	
<td>Sparte: </td>
<td>{{.Sparte}}</td> 
</tr>

<tr> 	
<td>Risiko: </td>
<td>{{.Risiko}}</td> 
</tr>

<tr> 	
<td>Gesellschaft: </td>
<td>{{.Gesellschaft}}</td> 
</tr>

</table> 
</p>

{{- range $caption, $field := .Felder}}
<h2>{{$caption}}</h2>
<blockquote>
{{$field}}
</blockquote>
{{- end}}

<h2>Zeitpunkt</h2>
<blockquote>
{{.Zeitpunkt}}
</blockquote>
<h2>Ort</h2>
<blockquote>
{{.Ort}}
</blockquote>
{{if .Latitude}}
<p>
<a href="http://www.google.com/maps/place/{{.Latitude}},{{.Longitude}}">
Geo-Link
</a>
</p>
{{end}}`))

	type data struct {
		Versicherungsnummer string
		Sparte              string
		Risiko              string
		Gesellschaft        string
		Zeitpunkt           string
		Ort                 string
		Latitude            float64
		Longitude           float64
		Felder              map[string]string

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
		ID         string               `json:"id"`
		VertragsID string               `json:"vertragsID"`
		TemplateID string               `json:"templateID"`
		Zeitpunkt  string               `json:"zeitpunkt"`
		Ort        string               `json:"ort"`
		Latitude   float64              `json:"latitude"`
		Longitude  float64              `json:"longitude"`
		Aufnahmen  map[string][][]uint8 `json:"aufnahmen"`
		Felder     map[string]string    `json:"felder"`
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

		vertrag, err := c.GetVertrag(m.VertragsID)

		if err != nil {
			handleError(w, err.Error(), http.StatusBadRequest)
			return
		}

		template, _ := sparte.ByProClientID(vertrag.SpartenID).MeldeTemplate(m.TemplateID)

		categories := make([]string, 0, len(m.Aufnahmen))

		for cat := range m.Aufnahmen {
			categories = append(categories, cat)
		}

		email := mail.New()

		sort.Strings(categories)
		for _, cat := range categories {
			for i, data := range m.Aufnahmen[cat] {
				mime := http.DetectContentType(data)
				ext := "bin"
				if strings.HasPrefix(mime, "image/") {
					ext = strings.Split(mime, "/")[1]
				}
				name := fmt.Sprintf("%s %d.%s", template.FieldLabel(cat), i+1, ext)
				email.AddAttachmentData(data, name, mime)
			}
		}

		fields := map[string]string{}
		if m.Felder != nil {
			for key, field := range m.Felder {
				fields[template.FieldLabel(key)] = field
			}
		}

		z, err := time.Parse("2006-01-02T15:04:05.000", m.Zeitpunkt)

		if err != nil {
			handleError(w, err.Error(), http.StatusBadRequest)
			return
		}

		if err := email.Send(template.Name+" von "+c.User+" bei "+c.PortalName(), recipients, bodyTemplate,

			data{
				Versicherungsnummer: vertrag.Nr,
				Sparte:              vertrag.SpartenName,
				Risiko:              vertrag.Risiko,
				Gesellschaft:        vertrag.Gesellschaft,
				Ort:                 m.Ort,
				Latitude:            m.Latitude,
				Longitude:           m.Longitude,
				Zeitpunkt:           z.Format("02.01.2006 15:04"),
				Felder:              fields,

				KundeAnrede:  vertrag.KundeAnrede,
				KundeTitel:   vertrag.KundeTitel,
				KundeName:    vertrag.KundeName,
				KundeName2:   vertrag.KundeName2,
				KundeName3:   vertrag.KundeName3,
				KundeStrasse: vertrag.KundeStrasse,
				KundeHausnr:  vertrag.KundeHausnr,
				KundePlz:     vertrag.KundePlz,
				KundeOrt:     vertrag.KundeOrt,
				KundeLandkz:  vertrag.KundeLandkz,
			}); err != nil {
			handleError(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
}
