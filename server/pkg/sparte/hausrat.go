package sparte

import "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/melde"

var sparteHaurat = Sparte{
	SpartenID: "Hausrat",
	MeldeTemplates: []melde.Template{
		schadenTemplate(

			melde.Date("Schadentag"),

			melde.Section("Schadenort").
				WithBeschreibung("Bitte geben Sie den Ort, an dem der Schaden aufgetreten ist, an!"),

			melde.Location("Adresse").
				WithBeschreibung("Bitte geben Sie die Adresse des Versicherungsorts an!"),

			melde.Textfield("Adresse2", "Adress\u00ADdetails").
				WithBeschreibung("Gebäudeteile bzw. Raum"),

			melde.Section("Schadenhergang/-ursache"),

			melde.Multiline("Schadenhergang", "Beschreibung"),

			melde.Textfield("Schadenhöhe", "Schaden\u00ADhöhe").
				WithBeschreibung("Ungefähre Schadenhöhe"),

			melde.Images("fotos", "Foto").
				WithBeschreibung("Fotos des Schadens").
				WithMax(4),

			melde.Section("Polizei").
				WithBeschreibung("Bei Einbruch, Vandalismus oder Diebstahl benötigen wir die von Ihnen gegebenen Informationen bzgl. Ihrer Meldung bei der zuständigen Polizeibehörde."),

			melde.Textfield("Dienststelle", "Dienst\u00ADstelle"),

			melde.Textfield("Tagebuchnummer", "Tagebuch\u00ADnummer"),

			melde.Section("Bankdaten").
				WithBeschreibung("Bitte geben Sie Ihre Bankdaten zur Regulierung an."),

			melde.Textfield("kontoinhaber", "Konto\u00ADinhaber"),

			melde.Textfield("IBAN", "IBAN"),

			melde.Choice("BeitragKonto", "Regulierung ist zugunsten des Kontos erwünscht, von dem die Beiträge eingezogen werden"),
		),
		wertsachenTemplate(

			melde.Images("fotos", "Foto").
				WithBeschreibung("Fotos des Wertgegenstands").
				WithMax(4),

			melde.Multiline("beschreibung", "Beschreibung"),

			melde.Textfield("wert", "Wert").
				WithBeschreibung("Ungefährer Wert in Euro"),
		),
	},
}
