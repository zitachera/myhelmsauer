package api

func aufnahmeKategorienForSparte(sparte string) []vertragAufnahmeKategorie {
	switch sparte {
	case "SPN200008031656319BP", "SPNAAAAAAAAAA": // Kraftfahrtversicherung
		return []vertragAufnahmeKategorie{
			{
				ID:           "ausweisVorderseite",
				Label:        "Ausweis\u00ADvorderseite",
				Beschreibung: "Ausweis\u00ADvorderseite des Unfallgegners",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "ausweisRueckseite",
				Label:        "Ausweis\u00ADrückseite",
				Beschreibung: "Ausweis\u00ADrückseite des Unfallgegners",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "fuehrerscheinVorderseite",
				Label:        "Führerschein\u00ADvorderseite",
				Beschreibung: "Führerschein\u00ADvorderseite des Unfallgegners",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "fuehrerscheinRueckseite",
				Label:        "Führerschein\u00ADrückseite",
				Beschreibung: "Führerschein\u00ADrückseite des Unfallgegners",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "grueneKarte",
				Label:        "Grüne Karte",
				Beschreibung: "Grüne Karte des Unfallgegners",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "gegnerischesKennzeichen",
				Label:        "Kennzeichen",
				Beschreibung: "Kennzeichen des Unfallgegners",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "unfall",
				Label:        "Unfall\u00ADaufnahme",
				Beschreibung: "",
				Max:          3,
				Min:          0,
			},
		}
	}
	return []vertragAufnahmeKategorie{}
}

func spartenLabel(id string, kats []vertragAufnahmeKategorie) string {
	for _, kat := range kats {
		if id == kat.ID {
			return kat.Label
		}
	}
	return id
}
