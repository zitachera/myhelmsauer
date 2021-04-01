package mail

import "html/template"

var bodyTemplate = template.Must(template.New("body").Parse(`<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<style>
.box {
	background: linear-gradient(to bottom, blue, white);
	border-radius: 10px;
	margin: 20px;
	padding: 10px;
}
</style>
</head>
<body>
<div class="box">
<p>
<h1>Neue Schadensmeldung von {{.User}}</h1>
</p>
<!-- alle bilder -->
<h2>Schadenhergang</h2>
<p>
{{.Schadenhergang}}
</p>
</div>
</body>

</html>`))
