package proclient

import "log"

// Login

// Get Verträge (via address)

type login struct {
	Status  string `xml:"Status"`
	Message string `xml:"Message"`
}

// Login returns true if the user can be authorized
func (c Client) Login() (string, bool, error) {
	if c.User == "Mocked" {
		if c.Password != "MockMe90403" {
			return "Ungültiges Passwort", false, nil
		}
		return "", true, nil
	}
	var login login
	if err := c.request("Login", &login); err != nil {
		return "", false, err
	}
	log.Println(login, login.Message, login.Status)
	return login.Message, login.Status == "Success", nil
}
