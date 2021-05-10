package mail

import (
	"bytes"
	"crypto/tls"
	"time"

	mail "github.com/xhit/go-simple-mail/v2"
)

// Meldung ist eine Schadensmeldung von einem Versicherten.
type Meldung struct {
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
	Aufnahmen           []Image

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

type Image struct {
	Name string
	Mime string
	Data []uint8
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
		AddTo("udo.roehlich@helmsauer-gruppe.de").
		AddTo("bastian.helmsauer@helmsauer-gruppe.de").
		SetSubject(meldung.Titel)

	var htmlBody bytes.Buffer
	if err := bodyTemplate.Execute(&htmlBody, meldung); err != nil {
		return err
	}

	email.SetBody(mail.TextHTML, htmlBody.String())

	for _, img := range meldung.Aufnahmen {
		email.AddAttachmentData(img.Data, img.Name, img.Mime)
	}

	return email.Send(smtpClient)
}
