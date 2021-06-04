package proclient

import (
	"io/ioutil"
	"net/http"
	"net/url"
)

// Dokument is a ProClient Dokument.
type Dokument struct {
	ID      string `xml:"dokumentid"`
	Titel   string `xml:"dok_title"`
	Deleted bool   `xml:"dok_deleted"`
	Online  bool   `xml:"dok_online"`
}

type dokumentResponse struct {
	Dokumente []Dokument `xml:"Dok_View"`
}

func (c Client) getDokumente(addressID, vertragID string) ([]Dokument, error) {
	var response dokumentResponse
	if err := c.postForm(url.Values{
		"Query":    {"Dokumente"},
		"Username": {c.User},
		"Password": {c.Password},

		"AdressID":   {addressID},
		"VertragsID": {vertragID},
	}, &response); err != nil {
		return nil, err
	}

	return response.Dokumente, nil
}

// GetDokument returns encoding and body of the requested Dokument or an error.
func (c Client) GetDokument(addressID, dokumentID string) (contentType string, body []byte, err error) {
	resp, err := http.PostForm(c.url(), url.Values{
		"Query":    {"Dokument"},
		"Username": {c.User},
		"Password": {c.Password},

		"AdressID":   {addressID},
		"DokumentID": {dokumentID},
		"DokTitle":   {"X"},
	})
	if err != nil {
		return "", nil, err
	}
	defer resp.Body.Close()

	body, err = ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", nil, err
	}
	return resp.Header.Get("Content-Type"), body, nil
}
