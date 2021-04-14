package api

func aufnahmeKategorienForSparte(sparte string) []vertragAufnahmeKategorie {
	switch sparte {
	case "SPN2000061308575757O": // TODO remove temporary expample category
		fallthrough
	case "SPNAAAAAAAAAA":
		return []vertragAufnahmeKategorie{
			{
				ID:           "ausweisVorderseite",
				Label:        "Ausweis\u00ADvorderseite",
				Beschreibung: "",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "ausweisRueckseite",
				Label:        "Ausweis\u00ADrückseite",
				Beschreibung: "",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "fuehrerscheinVorderseite",
				Label:        "Führerschein\u00ADvorderseite",
				Beschreibung: "",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "fuehrerscheinRueckseite",
				Label:        "Führerschein\u00ADrückseite",
				Beschreibung: "",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "grueneKarte",
				Label:        "Grüne Karte",
				Beschreibung: "",
				Max:          1,
				Min:          0,
			},
			{
				ID:           "gegnerischesKennzeichen",
				Label:        "Gegnerisches Kennzeichen",
				Beschreibung: "",
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
