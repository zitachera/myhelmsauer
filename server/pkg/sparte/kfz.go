package sparte

import "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/melde"

var sparteKfz = Sparte{
	SpartenID: "KFZ",
	MeldeTemplates: []melde.Template{
		schadenTemplate(
			melde.Section("Unfallgegner"),

			melde.Images("ausweisVorderseite", "Ausweis\u00ADvorderseite").
				WithBeschreibung("Ausweis\u00ADvorderseite des Unfallgegners").
				WithMax(1).
				WithMin(0),
			melde.Images("ausweisRueckseite", "Ausweis\u00ADrückseite").
				WithBeschreibung("Ausweis\u00ADrückseite des Unfallgegners").
				WithMax(1).
				WithMin(0),

			melde.Images("fuehrerscheinVorderseite", "Führerschein\u00ADvorderseite").
				WithBeschreibung("Führerschein\u00ADvorderseite des Unfallgegners").
				WithMax(1).
				WithMin(0),

			melde.Images("fuehrerscheinRueckseite", "Führerschein\u00ADrückseite").
				WithBeschreibung("Führerschein\u00ADrückseite des Unfallgegners").
				WithMax(1).
				WithMin(0),

			melde.Textfield("vorname", "Vor\u00ADname").
				WithBeschreibung("Falls nicht auf Foto erkennbar"),

			melde.Textfield("nachname", "Nach\u00ADname").
				WithBeschreibung("Falls nicht auf Foto erkennbar"),

			melde.Textfield("anschrift", "Anschrift").
				WithBeschreibung("Falls nicht auf Foto erkennbar"),

			melde.Textfield("telefonnummer", "Telefon\u00ADnummer"),

			melde.Textfield("e-mail", "E-Mail"),

			melde.Images("fahrzeugschein", "Fahrzeug\u00ADschein").
				WithBeschreibung("Fahrzeugschein des Unfallgegners").
				WithMax(1).
				WithMin(0),

			melde.Images("gegnerischesKennzeichen", "Kennzeichen").
				WithBeschreibung("Kennzeichen des Unfallgegners").
				WithMax(1).
				WithMin(0),

			melde.Section("Schaden"),

			melde.Images("unfall", "Unfall\u00ADfotos").
				WithMax(3).
				WithMin(0),

			melde.Images("polizei", "Polizeiliche Unfall\u00ADaufnahmen").
				WithBeschreibung("Wenn möglich können Fotos der Polizeiliche Unfallaufnahmen hinzugefügt werden.").
				WithMax(3).
				WithMin(0),

			melde.Choice("schuldig", "Halten Sie sich verantwortlich für die Verursachung des Schadens?"),

			melde.Date("Datum"),

			melde.Time("Uhrzeit"),

			melde.Location("Unfallort").
				WithBeschreibung("Bitte geben Sie den Ort des Unfalls an!"),

			melde.Multiline("hergang", "Schadenhergang"),
		),
	},
}
