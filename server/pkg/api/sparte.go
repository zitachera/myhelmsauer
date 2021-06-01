package api

const (
	imagesKind    = "images"
	textfieldKind = "textfield"
	sectionKind   = "section"
)

func meldeFelderForSparte(sparte string) []meldeFeld {
	switch sparte {
	case "SPN200008031656319BP", "SPNAAAAAAAAAA": // Kraftfahrtversicherung
		return []meldeFeld{
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
		}
	}
	return []meldeFeld{}
}

func spartenLabel(id string, kats []meldeFeld) string {
	prefix := ""
	for _, kat := range kats {
		if id == kat.ID {
			return prefix + kat.Label
		}
		if kat.Kind == sectionKind {
			prefix = kat.Label
		}
	}
	return id
}
