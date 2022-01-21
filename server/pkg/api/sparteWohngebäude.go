package api

var sparteWohngebäude = sparte{
	SpartenID: "Hausrat",
	AufnahmeKategorien: []meldeFeld{

		{
			Label: "Schadentag",
			Kind:  dateKind,
		},
		{
			Label:        "Schadenort",
			Beschreibung: "Bitte geben Sie den Ort, an dem der Schaden aufgetreten ist, an!",
			Kind:         sectionKind,
		},
		{
			Label:        "Adresse",
			Beschreibung: "Bitte geben Sie die Adresse des Schadenorts an!",
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
			Beschreibung: "Bei Einbruch, Vandalismus oder Diebstahl können Sie Informationen der Polizei angeben.",
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
	},
}
