package proclient

import (
	"crypto/tls"
	"encoding/xml"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strings"
)

// Client is a client for the ProClient API.
type Client struct {
	User       string
	Password   string
	Gruppe     string
	VertragIds map[string]struct{}
}

func (c Client) request(query string, res interface{}) error {
	return c.postForm(url.Values{
		"Query":    {query},
		"Username": {c.User},
		"Password": {c.Password},
	}, res)
}

func (c Client) requestByID(query, entity, id string, res interface{}) error {
	return c.postForm(url.Values{
		"Query":    {query},
		"Username": {c.User},
		"Password": {c.Password},
		entity:     {id},
	}, res)
}

func (c Client) postForm(values url.Values, res interface{}) error {
	// Créer un client HTTP personnalisé qui ignore la vérification SSL pour les domaines Helmsauer
	client := &http.Client{
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{
				InsecureSkipVerify: strings.Contains(c.url(), "helmsauer-gruppe.de"),
			},
		},
	}

	resp, err := client.PostForm(c.url(), values)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}

	// Vérifier si la réponse est vide ou invalide
	if len(body) == 0 {
		return fmt.Errorf("empty response from ProClient")
	}

	// Tenter de parser le XML
	if err := xml.Unmarshal(body, res); err != nil {
		// Log le body pour debug si le parsing échoue
		return fmt.Errorf("XML parsing error: %v, response body: %s", err, string(body))
	}

	return nil

}

func (c Client) url() string {
	switch c.Gruppe {
	default:
		fallthrough
	case "hk":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface/CustomerQuery.aspx"
	case "jade":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_jade/CustomerQuery.aspx"
	case "sue":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_sue/CustomerQuery.aspx"
	case "bbg":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_bbg/CustomerQuery.aspx"
	case "detmer": // der kann weg
		fallthrough
	case "aewz":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_detmer/CustomerQuery.aspx"
	case "hp":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_hp/CustomerQuery.aspx"
	case "idf":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_idf/CustomerQuery.aspx"
	case "ufb":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_ufb/CustomerQuery.aspx"
	case "verri":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_verri/CustomerQuery.aspx"
	}
}

func (c Client) PortalName() string {
	return PortalName(c.Gruppe)
}

func PortalName(gruppe string) string {
	switch gruppe {
	default:
		fallthrough
	case "hk":
		return "Helmsauer & Kollegen"
	case "sue":
		return "Dr. Schmidt & Erdsiek"
	case "jade":
		return "Dr. Schmidt & Erdsiek (Ex-Jade)"
	case "bbg":
		return "Dr. Schmidt & Erdsiek (Ex-Berenberg-Gossler)"
	case "detmer":
		fallthrough
	case "aewz":
		return "AEWZ Ärzte-Wirtschafts-Zentrum"
	case "hp":
		return "Helmsauer & Preuß"
	case "idf":
		return "Ingenieur-Dienst-Finanzberatung"
	case "ufb":
		return "UFB:UMU"
	case "verri":
		return "VerRi"
	}
}

func (c Client) hasAccessToVertrag(id string) bool {
	if c.VertragIds == nil {
		return true
	}
	_, in := c.VertragIds[id]
	return in
}
