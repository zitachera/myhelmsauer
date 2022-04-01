package sparte

import "gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/melde"

// Sparte beinhaltet alle Meldetemplates für eine Sparte.
type Sparte struct {
	SpartenID      string           `json:"spartenID"`
	MeldeTemplates []melde.Template `json:"meldeTemplates"`
}

// MeldeTemplate returns the template with the given ID.
func (sp Sparte) MeldeTemplate(id string) (melde.Template, bool) {
	for _, t := range sp.MeldeTemplates {
		if t.ID == id {
			return t, true
		}
	}
	return melde.Template{}, false
}

// ByProClientID returns the Sparte with the given ProClient SpartenID.
func ByProClientID(proClientSparte string) Sparte {
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
	return Sparte{SpartenID: "unknown", MeldeTemplates: []melde.Template{}}
}
