package mail

import (
	"testing"
)

// no-reply-schadenmeldung@helmsauer-gruppe.de
func TestMail(t *testing.T) {
	Send(Meldung{
		User:           "testuser",
		Schadenhergang: "tada",
	})
}
