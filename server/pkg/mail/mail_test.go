package mail

import (
	"testing"
)

// no-reply-schadenmeldung@helmsauer-gruppe.de
func TestMail(t *testing.T) {
	Send(Meldung{
		Titel:          "Schadenmeldung von GoTest",
		Vertrag:        "Name (id) / Risiko / Versicherer",
		Schadenhergang: "So",
		Ort:            "Ort",
		Latitude:       123456789,
		Longitude:      987654321,
		Zeitpunkt:      "theZeitpunkt",
	})
}
