package proclient

import (
	"encoding/xml"
	"io/ioutil"
	"net/http"
	"net/url"
)

// Client is a client for the ProClient API.
type Client struct {
	User     string
	Password string
	Gruppe   string
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

	body, err := ioutil.ReadAll(resp.Body)
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
	case "detmer":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_detmer/CustomerQuery.aspx"
	case "hp":
		return "https://portalinterface.helmsauer-gruppe.de:4448/portalinterface_hp/CustomerQuery.aspx"
	}
}
