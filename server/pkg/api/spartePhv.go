package api

var spartePhv = sparte{
	SpartenID: "PHV",
	AufnahmeKategorien: []meldeFeld{
		{
			Label:        "Kontaktdaten des Geschädigten",
			Kind:         sectionKind,
			Beschreibung: "",
		},
		{
			ID:           "vorname",
			Label:        "Vor\u00ADname",
			Kind:         textfieldKind,
			Beschreibung: "",
		},
		{
			ID:           "nachname",
			Label:        "Nach\u00ADname",
			Kind:         textfieldKind,
			Beschreibung: "",
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
			ID:           "geschädigterAnschrift",
			Label:        "Anschrift",
			Kind:         textfieldKind,
			Beschreibung: "",
		},
		{
			Label:        "Schaden",
			Kind:         sectionKind,
			Beschreibung: "",
		},
		{
			ID:           "schaden",
			Label:        "Schaden\u00ADbild",
			Kind:         imagesKind,
			Beschreibung: "Was ist kaputt gegangen?",
			Max:          3,
			Min:          0,
		},
		{
			ID:           "rechnung",
			Label:        "Anschaffungs- / Reparatur\u00ADrechnung",
			Kind:         imagesKind,
			Beschreibung: "Kennzeichen des Unfallgegners",
			Max:          1,
			Min:          0,
		},
		{
			ID:           "wert",
			Label:        "Ungefährer Wert",
			Kind:         textfieldKind,
			Beschreibung: "Falls Rechnung nicht vorhanden",
		},
	},
}
