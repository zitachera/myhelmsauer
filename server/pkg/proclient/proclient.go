package proclient

import "errors"

// Vertrag is a ProClient Vertrag.
type Vertrag struct {
	ID                 string `xml:"vertragsid"`
	Status             string `xml:"ver_status"`
	Nr                 string `xml:"ver_vertragsnr"`
	Risiko             string `xml:"ver_risiko"`
	SpartenID          string `xml:"ver_spartenid"`
	SpartenName        string `xml:"spn_name"`
	NettotJahrebeitrag string `xml:"ver_nejahresbetrag"`
	BruttoJahrebeitrag string `xml:"ver_brjahresbetrag"`
	Gesellschaft       string `xml:"cgesname"`
	Ablauf             string `xml:"ver_ablauf"`

	AdresseID    string
	KundeAnrede  string
	KundeTitel   string
	KundeName    string
	KundeName2   string
	KundeName3   string
	KundeStrasse string
	KundeHausnr  string
	KundePlz     string
	KundeOrt     string
	KundeLandkz  string

	Dokumente []Dokument
}

type vertraegeResponse struct {
	Vertraege []Vertrag `xml:"Ver_View"`
}

type adresseResponse struct {
	Adressen []adresse `xml:"Adr_View"`
}

type adresse struct {
	ID string `xml:"adressid"`

	Anrede  string `xml:"ad_anrede"`
	Titel   string `xml:"ad_titel"`
	Name    string `xml:"ad_name"`
	Name2   string `xml:"ad_name2"`
	Name3   string `xml:"ad_name3"`
	Strasse string `xml:"ad_strasse"`
	Hausnr  string `xml:"ad_hausnr"`
	Plz     string `xml:"ad_plz"`
	Ort     string `xml:"ad_ort"`
	Landkz  string `xml:"ad_landkz"`
}

// GetVertraege returns the Verträge from ProClient or an error.
func (c Client) GetVertraege() ([]Vertrag, error) {
	if c.User == "Mocked" {
		if c.Password != "MockMe90403" {
			return nil, errors.New("invalid password")
		}
		return nil, nil
	}
	vertraege := make([]Vertrag, 0, 4)

	var adressen adresseResponse
	if err := c.request("Adressen", &adressen); err != nil {
		return nil, err
	}
	for _, adresse := range adressen.Adressen {
		var response vertraegeResponse
		if err := c.requestByID("Vertraege", "AdressID", adresse.ID, &response); err != nil {
			return nil, err
		}
		for i := range response.Vertraege {
			refineVertragData(&response.Vertraege[i], adresse)
			doks, err := c.getDokumente(adresse.ID, response.Vertraege[i].ID)
			if err != nil {
				return nil, err
			}
			response.Vertraege[i].Dokumente = doks
		}
		vertraege = append(vertraege, response.Vertraege...)
	}

	return vertraege, nil
}

// GetVertrag returns a Vertrag with given id from ProClient or an error.
func (c Client) GetVertrag(id string) (Vertrag, error) {
	var adressen adresseResponse
	if err := c.request("Adressen", &adressen); err != nil {
		return Vertrag{}, err
	}
	for _, adresse := range adressen.Adressen {
		var response vertraegeResponse
		if err := c.requestByID("Vertraege", "AdressID", adresse.ID, &response); err != nil {
			return Vertrag{}, err
		}
		for _, vertrag := range response.Vertraege {
			if vertrag.ID == id {
				refineVertragData(&vertrag, adresse)
				return vertrag, nil
			}
		}
	}

	return Vertrag{}, errors.New("Vertrag " + id + " not found")
}

func refineVertragData(v *Vertrag, a adresse) {
	v.AdresseID = a.ID
	v.KundeAnrede = a.Anrede
	v.KundeTitel = a.Titel
	v.KundeName = a.Name
	v.KundeName2 = a.Name2
	v.KundeName3 = a.Name3
	v.KundeStrasse = a.Strasse
	v.KundeHausnr = a.Hausnr
	v.KundePlz = a.Plz
	v.KundeOrt = a.Ort
	v.KundeLandkz = a.Landkz
}
