package api

const (
	imagesKind    = "images"
	textfieldKind = "textfield"
	multilineKind = "multiline"
	sectionKind   = "section"
	choiceKind    = "choice"
	timeKind      = "time"
	dateKind      = "date"
	locationKind  = "location"
)

func meldeFelderForSparte(proClientSparte string) sparte {
	switch proClientSparte {
	case "SPN200008031656319BP", "SPNAAAAAAAAAA": // Kraftfahrtversicherung
		return sparteKfz

	case "SPN20101222145048KWI", "SPN_304xxxxxxxxxxxxx", "SPN_304_____________", "SPN20080326141601UKQ", "SPN20000803170532V4E": // Haft PHV
		return spartePhv
	}
	return sparte{SpartenID: "unknown", AufnahmeKategorien: []meldeFeld{}}
}

func spartenLabel(id string, kats []meldeFeld) string {
	prefix := ""
	for _, kat := range kats {
		if id == kat.ID {
			return prefix + kat.Label
		}
		if kat.Kind == sectionKind {
			prefix = kat.Label + " "
		}
	}
	return id
}
