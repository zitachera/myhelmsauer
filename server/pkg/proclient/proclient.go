package proclient

import (
	"errors"
	"fmt"
	"net/url"
)

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

	Adresse

	Dokumente []Dokument
}

type Adresse struct {
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
	vertraege := make([]Vertrag, 0, 4)

	adressen, err := c.GetAdressen()
	if err != nil {
		return nil, err
	}
	for _, adresse := range adressen {
		var response vertraegeResponse
		if err := c.requestByID("Vertraege", "AdressID", adresse.AdresseID, &response); err != nil {
			return nil, err
		}
		for _, vertrag := range response.Vertraege {

			if !c.hasAccessToVertrag(vertrag.ID) {
				continue
			}
			vertrag.Adresse = adresse
			doks, err := c.getDokumente(adresse.AdresseID, vertrag.ID)
			if err != nil {
				return nil, err
			}
			vertrag.Dokumente = doks
			vertraege = append(vertraege, vertrag)
		}
	}

	return vertraege, nil
}

// GetAdressen returns the Adressen from ProClient or an error.
func (c Client) GetAdressen() ([]Adresse, error) {
	adressen := make([]Adresse, 0, 4)
	var response adresseResponse
	if err := c.request("Adressen", &response); err != nil {
		return nil, err
	}
	for _, a := range response.Adressen {
		adressen = append(adressen, Adresse{
			AdresseID:    a.ID,
			KundeAnrede:  a.Anrede,
			KundeTitel:   a.Titel,
			KundeName:    a.Name,
			KundeName2:   a.Name2,
			KundeName3:   a.Name3,
			KundeStrasse: a.Strasse,
			KundeHausnr:  a.Hausnr,
			KundePlz:     a.Plz,
			KundeOrt:     a.Ort,
			KundeLandkz:  a.Landkz,
		})
	}

	return adressen, nil
}

// GetVertrag returns a Vertrag with given id from ProClient or an error.
func (c Client) GetVertrag(id string) (Vertrag, error) {
	if c.hasAccessToVertrag(id) {
		adressen, err := c.GetAdressen()
		if err != nil {
			return Vertrag{}, err
		}
		for _, adresse := range adressen {
			var response vertraegeResponse
			if err := c.requestByID("Vertraege", "AdressID", adresse.AdresseID, &response); err != nil {
				return Vertrag{}, err
			}
			for _, vertrag := range response.Vertraege {
				if vertrag.ID == id {
					vertrag.Adresse = adresse
					return vertrag, nil
				}
			}
		}
	}
	return Vertrag{}, errors.New("Vertrag " + id + " not found")
}

// ChangePassword changes the password of the current user or returns an error.
func (c Client) ChangePassword(newPassword string) error {
	var response struct {
		Success bool `xml:"Success"`
	}

	if err := c.postForm(url.Values{
		"Query":       {"SetPassword"},
		"Username":    {c.User},
		"Password":    {c.Password},
		"NewPassword": {newPassword},
	}, &response); err != nil {
		return err
	}
	if !response.Success {
		return fmt.Errorf("failed to change password")
	}
	return nil
}
