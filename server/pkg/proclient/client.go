package proclient

import (
	"encoding/xml"
	"io"
	"net/http"
	"net/url"
)

// Client is a client for the ProClient API.
type Client struct {
	User       string
	Password   string
	Gruppe     string
	SubAccount string
	// PasswordHash is a hash of the SubAccount accounts password
	PasswordHash string
	VertragIds   map[string]struct{}
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

	resp, err := http.PostForm(c.url(), values)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}

	return xml.Unmarshal(body, res)

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
	}
}

func (c Client) PortalName() string {
	switch c.Gruppe {
	default:
		fallthrough
	case "hk":
		return "Helmsauer Assekuranzmakler AG"
	case "jade":
		return "Dr. Schmidt & Erdsiek Versicherungsmakler"
	case "sue":
		return "Dr. Schmidt & Erdsiek (Ex-Jade)"
	case "bbg":
		return "Dr. Schmidt & Erdsiek (Ex-Berenberg-Gossler)"
	case "detmer":
		fallthrough
	case "aewz":
		return "Ärzte Wirtschaftszentrum Köln"
	case "hp":
		return "Helmsauer und Preuß GmbH"
	}
}

func (c Client) hasAccessToVertrag(id string) bool {
	if c.VertragIds == nil {
		return true
	}
	_, in := c.VertragIds[id]
	return in
}
