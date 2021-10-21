package api

import (
	"encoding/json"
	"fmt"
	"html/template"
	"net/http"
	"sort"
	"strings"
	"time"

	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/auth"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/mail"
)

func PostVorgang(recipients []string) http.HandlerFunc {
	bodyTemplate := template.Must(template.New("body").Parse(`<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<style>
<style>
    html,
    body,
    table,
    tbody,
    tr,
    td,
    div,
    p,
    ul,
    ol,
    li,
    h1,
    h2,
    h3,
    h4,
    h5,
    h6 {
        margin: 0;
        padding: 0;
    }

    body {
        margin: 0;
        padding: 0;
        -ms-text-size-adjust: 100%;
        -webkit-text-size-adjust: 100%;
    }

    h1,
    h2,
    h3,
    h4,
    h5,
    h6 {
        font-family: Arial;
    }

    h1 {
        font-size: 28px;
        line-height: 32px;
        padding-top: 10px;
        padding-bottom: 24px;
    }

    h2 {
        font-size: 24px;
        line-height: 28px;
        padding-top: 10px;
        padding-bottom: 20px;
    }

    h3 {
        font-size: 20px;
        line-height: 24px;
        padding-top: 10px;
        padding-bottom: 16px;
    }

    p {
        font-size: 16px;
        line-height: 20px;
        font-family: Georgia, Arial, sans-serif;
    }

    @media all and (max-width: 599px) {
        .container600 {
            width: 100%;
        }
    }
    blockquote {
        font-size: 16px;
        line-height: 20px;
        font-family: Georgia, Arial, sans-serif;
        font-style: italic;
        padding:20px 40px 20px 20px;
        margin:30px 0;
        border:0px none;
        border-left: 16px solid #7d7d7d;
        color:inherit;
    }

    ul {
        margin-left: 20px;
        margin-top: 10px;
        margin-bottom: 10px;
    }

    ol {
        margin-left: 20px;
        margin-top: 10px;
        margin-bottom: 10px;
    }

    li {
        font-size: 16px;
        line-height: 20px;
        font-family: Georgia, Arial, sans-serif;
    }

    a {
        color:#bf2424;
        text-decoration:none;
    }
    a:link, a:hover, a:visited {
        color:#bf2424;
        text-decoration:none;
    }
</style>
</head>
<body>
<h1>{{.Titel}}</h1>
<p>
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
<h2>Schadenhergang</h2>
{{if .Schadenhergang}}
<blockquote>
{{.Schadenhergang}}
</blockquote>
{{else}}
<p>Keine Schadensbeschreibung</p>
{{end}}
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
{{end}}
</body>

</html>`))

	type data struct {
		Titel               string
		Versicherungsnummer string
		Sparte              string
		Risiko              string
		Gesellschaft        string
		Zeitpunkt           string
		Schadenhergang      string
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

		MailRecipients []string
	}
	return func(w http.ResponseWriter, r *http.Request) {
		c := auth.GetClientFromRequest(r)

		var m meldung
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

		kats := meldeFelderForSparte(vertrag.SpartenID).AufnahmeKategorien

		categories := make([]string, 0, len(m.Aufnahmen))

		for cat := range m.Aufnahmen {
			categories = append(categories, cat)
		}

		email := mail.New("Schadenmeldung von " + c.Gruppe + " / " + c.User)

		sort.Strings(categories)
		for _, cat := range categories {
			for i, data := range m.Aufnahmen[cat] {
				mime := http.DetectContentType(data)
				ext := "bin"
				if strings.HasPrefix(mime, "image/") {
					ext = strings.Split(mime, "/")[1]
				}
				name := fmt.Sprintf("%s %d.%s", spartenLabel(cat, kats), i+1, ext)
				email.AddAttachmentData(data, name, mime)
			}
		}

		fields := map[string]string{}
		if m.Felder != nil {
			for key, field := range m.Felder {
				fields[spartenLabel(key, kats)] = field
			}
		}

		z, err := time.Parse("2006-01-02T15:04:05.000", m.Zeitpunkt)

		if err != nil {
			handleError(w, err.Error(), http.StatusBadRequest)
			return
		}

		if err := email.Send(recipients, bodyTemplate,

			data{
				Versicherungsnummer: vertrag.Nr,
				Sparte:              vertrag.SpartenName,
				Risiko:              vertrag.Risiko,
				Gesellschaft:        vertrag.Gesellschaft,
				Schadenhergang:      m.Schadenhergang,
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
