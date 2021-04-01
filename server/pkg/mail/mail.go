package mail

import (
	"bytes"
	"crypto/tls"
	"time"

	mail "github.com/xhit/go-simple-mail/v2"
)

// Meldung ist eine Schadensmeldung von einem Versicherten.
type Meldung struct {
	User string

	Titel          string // Schadensmeldung von {{.User}}
	Vertrag        string // Name (id)
	Zeitpunkt      string
	Schadenhergang string
	Ort            string
	Latitude       string
	Longitude      string
	Aufnahmen      map[string][]uint8
}

// Send sends a mail to Helmsauer.
func Send(meldung Meldung) error {
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

	email := mail.NewMSG()
	email.SetFrom("Schadenmeldung <no-reply-schadenmeldung@helmsauer-gruppe.de>").
		AddTo("jan-erik.keller@helmsauer-gruppe.de").
		SetSubject("New Go Email")

	var htmlBody bytes.Buffer
	if err := bodyTemplate.Execute(&htmlBody, meldung); err != nil {
		return err
	}

	email.SetBody(mail.TextHTML, htmlBody.String())

	email.AddInline("Gopher.png", "Gopher.png")

	return email.Send(smtpClient)
}
