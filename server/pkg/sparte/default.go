package sparte

import "gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/melde"

var sparteDefault = Sparte{
	SpartenID: "default",
	MeldeTemplates: []melde.Template{
		schadenTemplate(

			melde.Section("Schadenbeschreibung"),

			melde.Images("schaden", "Schaden\u00ADbild").
				WithBeschreibung("Was ist passiert?").
				WithMax(3),

			melde.Date("Datum"),

			melde.Time("Uhrzeit"),

			melde.Multiline("hergang", "Schadenhergang"),
		),
	},
}
