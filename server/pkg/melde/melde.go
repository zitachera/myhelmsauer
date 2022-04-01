package melde

type Template struct {
	ID     string `json:"id"`
	Name   string `json:"name"`
	Felder []Feld `json:"felder"`
}

func (t *Template) FieldLabel(id string) string {
	prefix := ""
	for _, kat := range t.Felder {
		if id == kat.ID {
			return prefix + kat.Label
		}
		if kat.Kind == sectionKind {
			prefix = kat.Label + " "
		}
	}
	return id
}

type Feld struct {
	ID           string `json:"id"`
	Label        string `json:"label"`
	Kind         string `json:"kind"`
	Beschreibung string `json:"beschreibung"`
	Max          int    `json:"max"`
	Min          int    `json:"min"`
}

func (f Feld) WithBeschreibung(s string) Feld {
	f.Beschreibung = s
	return f
}

func (f Feld) WithMax(i int) Feld {
	f.Max = i
	return f
}

func (f Feld) WithMin(i int) Feld {
	f.Min = i
	return f
}

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

func Textfield(id, label string) Feld {
	return Feld{Kind: textfieldKind, ID: id, Label: label}
}

func Multiline(id, label string) Feld {
	return Feld{Kind: multilineKind, ID: id, Label: label}
}

func Section(label string) Feld {
	return Feld{Kind: sectionKind, Label: label}
}

func Images(id, label string) Feld {
	return Feld{Kind: imagesKind, ID: id, Label: label}
}

func Choice(id, label string) Feld {
	return Feld{Kind: choiceKind, ID: id, Label: label}
}

func Time(label string) Feld {
	return Feld{Kind: timeKind, Label: label}
}

func Date(label string) Feld {
	return Feld{Kind: dateKind, Label: label}
}

func Location(label string) Feld {
	return Feld{Kind: locationKind, Label: label}
}
