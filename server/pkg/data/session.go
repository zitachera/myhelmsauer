package data

import "gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/proclient"

// Session data of an app user.
type Session struct {
	proclient.Client
	// PasswordHash is a hash of the SubAccount accounts password
	PasswordHash string
	AuthToken    string
	SubAccount   string
}
