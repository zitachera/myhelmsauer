package sparte

import "gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/melde"

var sparteWohngebäude = Sparte{
	SpartenID: "Hausrat",
	MeldeTemplates: []melde.Template{
		schadenTemplate(

			melde.Date("Schadentag"),

			melde.Section("Versicherungsort").
				WithBeschreibung("Bitte geben Sie den Ort, an dem der Schaden aufgetreten ist, an!"),

			melde.Location("Adresse").
				WithBeschreibung("Bitte geben Sie die Adresse des Versicherungsorts an!"),

			melde.Textfield("Adresse2", "Adress\u00ADdetails").
				WithBeschreibung("Gebäudeteile bzw. Raum"),

			melde.Section("Schadenhergang/-ursache").
				WithBeschreibung(""),

			melde.Multiline("Schadenhergang", "Beschreibung").
				WithBeschreibung(""),

			melde.Textfield("Schadenhöhe", "Schaden\u00ADhöhe").
				WithBeschreibung("Ungefähre Schadenhöhe"),

			melde.Images("fotos", "Foto").
				WithBeschreibung("Fotos des Schadens").
				WithMax(4),

			melde.Section("Polizei").
				WithBeschreibung("Bei Einbruch, Vandalismus oder Diebstahl benötigen wir die von Ihnen gegebenen Informationen bzgl. Ihrer Meldung bei der zuständigen Polizeibehörde."),

			melde.Textfield("Dienststelle", "Dienst\u00ADstelle").
				WithBeschreibung(""),

			melde.Textfield("Tagebuchnummer", "Tagebuch\u00ADnummer").
				WithBeschreibung(""),

			melde.Section("Bankdaten").
				WithBeschreibung("Bitte geben Sie Ihre Bankdaten zur Regulierung an."),

			melde.Textfield("kontoinhaber", "Konto\u00ADinhaber"),

			melde.Choice("BeitragKonto", "Regulierung ist zugunsten des Kontos erwünscht, von dem die Beiträge eingezogen werden"),
		),
	},
}
