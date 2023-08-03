package sparte

import "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/melde"

var spartePhv = Sparte{
	SpartenID: "PHV",
	MeldeTemplates: []melde.Template{
		schadenTemplate(

			melde.Section("Kontaktdaten des Geschädigten"),

			melde.Textfield("vorname", "Vor\u00ADname"),

			melde.Textfield("nachname", "Nach\u00ADname"),

			melde.Textfield("telefonnummer", "Telefon\u00ADnummer"),

			melde.Textfield("e-mail", "E-Mail"),

			melde.Textfield("geschädigterAnschrift", "Anschrift"),

			melde.Section("Schaden"),

			melde.Images("schaden", "Schaden\u00ADbild").
				WithBeschreibung("Was ist kaputt gegangen?").
				WithMax(3),

			melde.Images("rechnung", "Anschaffungs- / Reparatur\u00ADrechnung").
				WithBeschreibung("Kennzeichen des Unfallgegners").
				WithMax(1),

			melde.Textfield("wert", "Ungefährer Wert").
				WithBeschreibung("Falls Rechnung nicht vorhanden"),

			melde.Date("Datum"),

			melde.Time("Uhrzeit"),

			melde.Location("Schadenort").
				WithBeschreibung("Bitte geben Sie den Ort des Schadens an!"),

			melde.Multiline("hergang", "Schadenhergang"),
		),
	},
}
