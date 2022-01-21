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
	case "SPN200008031656319BP",
		"SPNAAAAAAAAAA":
		return sparteKfz

	case "SPN20101222145048KWI",
		"SPN_304xxxxxxxxxxxxx",
		"SPN_304_____________",
		"SPN20080326141601UKQ",
		"SPN20000803170532V4E":
		return spartePhv

	case "SPN_S8E0WVOBK",
		"SPN_603xxxxxxxxxxxxx",
		"SPN_600xxxxxxxxxxxxx",
		"SPN20180524124725WP3",
		"SPN_600_____________",
		"SPN_603_____________",
		"SPN2019020709322766I",
		"SPN200803261616495VN",
		"SPN20000803171130J20":
		return sparteHaurat

	case "SPN_620xxxxxxxxxxxxx",
		"SPN_620_____________",
		"SPN20080326161808V1N",
		"SPN20201230160122CAH",
		"SPN20201230181537ZMZ",
		"SPN20201230181537ZMU",
		"SPN_622_____________",
		"SPN201807131308300VT",
		"SPN_622xxxxxxxxxxxxx",
		"SPN20130122125650198",
		"SPN_S8E0WMGB4":
		return sparteWohngebäude
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
