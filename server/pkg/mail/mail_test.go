package mail

import (
	"testing"
)

// no-reply-schadenmeldung@helmsauer-gruppe.de
func TestMail(t *testing.T) {
	Send(Meldung{
		Titel:               "Schadenmeldung von GoTest",
		Versicherungsnummer: "<Versicherungsnummer>",
		Sparte:              "<sparte>",
		Risiko:              "<risiko>",
		Gesellschaft:        "<gesellschaft>",
		Schadenhergang:      "So",
		Ort:                 "Ort",
		Latitude:            123456789,
		Longitude:           987654321,
		Zeitpunkt:           "theZeitpunkt",
	})
}
