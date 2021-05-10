package mail

import "html/template"

var bodyTemplate = template.Must(template.New("body").Parse(`<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
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
