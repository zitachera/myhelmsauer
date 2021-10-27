package mail

import (
	"bytes"
	"crypto/tls"
	"html/template"
	"time"

	mail "github.com/xhit/go-simple-mail/v2"
)

type Mail struct {
	email *mail.Email
}

func New() *Mail {
	return &Mail{
		email: mail.NewMSG().
			SetFrom("myHelmsauer <no-reply-schadenmeldung@helmsauer-gruppe.de>"),
	}
}

func (m *Mail) AddAttachmentData(data []byte, filename, mimeType string) {
	m.email.AddAttachmentData(data, filename, mimeType)
}

// Send sends a mail to Helmsauer.
func (m *Mail) Send(title string, recipients []string, bodyTemplate *template.Template, content interface{}) error {
	server := mail.NewSMTPClient()

	server.Host = "mail.helmsauer-gruppe.de"
	server.Port = 25
	server.Encryption = mail.EncryptionTLS

	server.KeepAlive = false
	server.ConnectTimeout = 10 * time.Second
	server.SendTimeout = 10 * time.Second
	server.TLSConfig = &tls.Config{InsecureSkipVerify: true}

	smtpClient, err := server.Connect()
	if err != nil {
		return err
	}

	m.email.SetSubject(title)

	for _, receiver := range recipients {
		m.email.AddTo(receiver)
	}

	var htmlBody bytes.Buffer
	htmlBody.WriteString(commonPrefix)
	htmlBody.WriteString("<h1>")
	htmlBody.WriteString(title)
	htmlBody.WriteString("</h1>\n")
	if err := bodyTemplate.Execute(&htmlBody, content); err != nil {
		return err
	}
	htmlBody.WriteString(commonSuffix)

	m.email.SetBody(mail.TextHTML, htmlBody.String())

	return m.email.Send(smtpClient)
}

const commonPrefix = `<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
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
    ul,
    ol {
        margin: 0;
        padding: 0;
    }

    p,
    li,
    h1,
    h2,
    h3,
    h4,
    h5,
    h6 {
        margin: 5px 0 10px 0;
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
`

const commonSuffix = `
</body>
</html>`
