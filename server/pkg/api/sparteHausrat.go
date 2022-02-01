package api

var sparteHaurat = sparte{
	SpartenID: "Hausrat",
	AufnahmeKategorien: []meldeFeld{

		{
			Label: "Schadentag",
			Kind:  dateKind,
		},
		{
			Label:        "Versicherungsort",
			Beschreibung: "Bitte geben Sie den Ort, an dem der Schaden aufgetreten ist, an!",
			Kind:         sectionKind,
		},
		{
			Label:        "Adresse",
			Beschreibung: "Bitte geben Sie die Adresse des Versicherungsorts an!",
			Kind:         locationKind,
		},
		{
			ID:           "Adresse2",
			Label:        "Adress\u00ADdetails",
			Kind:         textfieldKind,
			Beschreibung: "Gebäudeteile bzw. Raum",
		},

		{
			Label:        "Schadenhergang/-ursache",
			Kind:         sectionKind,
			Beschreibung: "",
		},
		{
			ID:           "Schadenhergang",
			Label:        "Beschreibung",
			Kind:         multilineKind,
			Beschreibung: "",
		},
		{
			ID:           "Schadenhöhe",
			Label:        "Schaden\u00ADhöhe",
			Kind:         textfieldKind,
			Beschreibung: "Ungefähre Schadenhöhe",
		},
		{
			ID:           "fotos",
			Label:        "Foto",
			Kind:         imagesKind,
			Beschreibung: "Fotos des Schadens",
			Max:          4,
			Min:          0,
		},

		{
			Label:        "Polizei",
			Kind:         sectionKind,
			Beschreibung: "Bei Einbruch, Vandalismus oder Diebstahl benötigen wir die von Ihnen gegebenen Informationen bzgl. Ihrer Meldung bei der zuständigen Polizeibehörde.",
		},
		{
			ID:           "Dienststelle",
			Label:        "Dienst\u00ADstelle",
			Kind:         textfieldKind,
			Beschreibung: "",
		},
		{
			ID:           "Tagebuchnummer",
			Label:        "Tagebuch\u00ADnummer",
			Kind:         textfieldKind,
			Beschreibung: "",
		},
		{
			Label:        "Bankdaten",
			Beschreibung: "Bitte geben Sie Ihre Bankdaten zur Regulierung an!",
			Kind:         sectionKind,
		},
		{
			ID:    "kontoinhaber",
			Label: "Konto\u00ADinhaber",
			Kind:  textfieldKind,
		},
		{
			ID:    "IBAN",
			Label: "IBAN",
			Kind:  textfieldKind,
		},
		{
			ID:    "BeitragKonto",
			Label: "Regulierung ist zugunsten des Kontos erwünscht, von dem die Beiträge eingezogen werden",
			Kind:  choiceKind,
		},
	},
}
