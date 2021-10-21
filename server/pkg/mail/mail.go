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

func New(title string) *Mail {
	return &Mail{
		email: mail.NewMSG().
			SetFrom("Schadenmeldung <no-reply-schadenmeldung@helmsauer-gruppe.de>").
			SetSubject(title),
	}
}

func (m *Mail) AddAttachmentData(data []byte, filename, mimeType string) {
	m.email.AddAttachmentData(data, filename, mimeType)
}

// Send sends a mail to Helmsauer.
func (m *Mail) Send(recipients []string, bodyTemplate *template.Template, content interface{}) error {
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

	for _, receiver := range recipients {
		m.email.AddTo(receiver)
	}

	var htmlBody bytes.Buffer
	if err := bodyTemplate.Execute(&htmlBody, content); err != nil {
		return err
	}

	m.email.SetBody(mail.TextHTML, htmlBody.String())

	return m.email.Send(smtpClient)
}
