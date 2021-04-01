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
}

type vertraegeResponse struct {
	Vertraege []Vertrag `xml:"Ver_View"`
}

type adresseResponse struct {
	Adressen []adresse `xml:"Adr_View"`
}

type adresse struct {
	ID string `xml:"adressid"`
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
		vertraege = append(vertraege, response.Vertraege...)
	}

	return vertraege, nil
}
