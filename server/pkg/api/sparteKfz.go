package api

var sparteKfz = sparte{
	SpartenID: "KFZ",
	AufnahmeKategorien: []meldeFeld{
		{
			Label:        "Unfallgegner",
			Kind:         sectionKind,
			Beschreibung: "",
		},
		{
			ID:           "ausweisVorderseite",
			Label:        "Ausweis\u00ADvorderseite",
			Kind:         imagesKind,
			Beschreibung: "Ausweis\u00ADvorderseite des Unfallgegners",
			Max:          1,
			Min:          0,
		},
		{
			ID:           "ausweisRueckseite",
			Label:        "Ausweis\u00ADrückseite",
			Kind:         imagesKind,
			Beschreibung: "Ausweis\u00ADrückseite des Unfallgegners",
			Max:          1,
			Min:          0,
		},
		{
			ID:           "fuehrerscheinVorderseite",
			Label:        "Führerschein\u00ADvorderseite",
			Kind:         imagesKind,
			Beschreibung: "Führerschein\u00ADvorderseite des Unfallgegners",
			Max:          1,
			Min:          0,
		},
		{
			ID:           "fuehrerscheinRueckseite",
			Label:        "Führerschein\u00ADrückseite",
			Kind:         imagesKind,
			Beschreibung: "Führerschein\u00ADrückseite des Unfallgegners",
			Max:          1,
			Min:          0,
		},

		{
			ID:           "vorname",
			Label:        "Vor\u00ADname",
			Kind:         textfieldKind,
			Beschreibung: "Falls nicht auf Foto erkennbar",
		},
		{
			ID:           "nachname",
			Label:        "Nach\u00ADname",
			Kind:         textfieldKind,
			Beschreibung: "Falls nicht auf Foto erkennbar",
		},
		{
			ID:           "anschrift",
			Label:        "Anschrift",
			Kind:         textfieldKind,
			Beschreibung: "Falls nicht auf Foto erkennbar",
		},
		{
			ID:           "telefonnummer",
			Label:        "Telefon\u00ADnummer",
			Kind:         textfieldKind,
			Beschreibung: "",
		},
		{
			ID:           "e-mail",
			Label:        "E-Mail",
			Kind:         textfieldKind,
			Beschreibung: "",
		},

		{
			ID:           "fahrzeugschein",
			Label:        "Fahrzeug\u00ADschein",
			Kind:         imagesKind,
			Beschreibung: "Fahrzeugschein des Unfallgegners",
			Max:          1,
			Min:          0,
		},
		{
			ID:           "gegnerischesKennzeichen",
			Label:        "Kennzeichen",
			Kind:         imagesKind,
			Beschreibung: "Kennzeichen des Unfallgegners",
			Max:          1,
			Min:          0,
		},
		{
			Label:        "Schaden",
			Kind:         sectionKind,
			Beschreibung: "",
		},
		{
			ID:           "unfall",
			Label:        "Unfall\u00ADfotos",
			Kind:         imagesKind,
			Beschreibung: "",
			Max:          3,
			Min:          0,
		},
		{
			ID:           "polizei",
			Label:        "Polizeiliche Unfall\u00ADaufnahmen",
			Kind:         imagesKind,
			Beschreibung: "Wenn möglich können Fotos der Polizeiliche Unfallaufnahmen hinzugefügt werden.",
			Max:          3,
			Min:          0,
		},
		{
			ID:    "schuldig",
			Label: "Halten sie sich verantwortlich für die Verursachung des Schaden?",
			Kind:  choiceKind,
		},
	},
}
