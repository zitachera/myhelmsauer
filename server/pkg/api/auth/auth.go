package auth

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5/middleware"
	"github.com/google/uuid"
	"github.com/hashicorp/go-version"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/data"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/proclient"
)

type ctxKey int

const (
	proclientKey ctxKey = iota
)

func CredentialChecker(minClientVersion *version.Version) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			c, err := data.LoadCredentials(r.Header.Get("authorization"))
			if err != nil {
				handleError(w, err.Error(), http.StatusUnauthorized)
				return
			}

			reqID := middleware.GetReqID(r.Context())
			log.Printf("%s user %s %s", reqID, c.Gruppe, c.User)

			clientVersion := r.Header.Get("client-version")
			if clientVersion != "" {
				cv, err := version.NewSemver(clientVersion)
				if err != nil {
					handleError(w, err.Error(), http.StatusBadRequest)
					return
				}
				if cv.LessThan(minClientVersion) {
					handleError(w, "Client Version "+minClientVersion.String()+" required", http.StatusUpgradeRequired)
					return
				}
			}

			ctx := context.WithValue(r.Context(), proclientKey, c)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

// GetClientFromRequest returns the ProClient of the middleware CredentialChecker.
func GetClientFromRequest(r *http.Request) proclient.Client {
	return GetClient(r.Context())
}

// GetClient returns the ProClient of the middleware CredentialChecker.
func GetClient(ctx context.Context) proclient.Client {
	return ctx.Value(proclientKey).(proclient.Client)
}

type requestLogin struct {
	User     string `json:"user"`
	Password string `json:"password"`
	Gruppe   string `json:"gruppe"`
}

func Login() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var l requestLogin
		if err := json.NewDecoder(r.Body).Decode(&l); err != nil {
			handleError(w, err.Error(), http.StatusBadRequest)
			return
		}

		client := proclient.Client{
			User:     l.User,
			Password: l.Password,
			Gruppe:   l.Gruppe,
		}

		msg, ok, err := client.Login()
		if err != nil {
			handleError(w, err.Error(), http.StatusInternalServerError)
			return
		}
		if !ok {
			handleError(w, msg, http.StatusForbidden)
			return
		}

		token := uuid.New().String()

		data.StoreCredentials(token, client)

		if err := json.NewEncoder(w).Encode(map[string]interface{}{
			"token": token,
		}); err != nil {
			handleError(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
}

func handleError(w http.ResponseWriter, error string, code int) {
	fmt.Println(code, error)
	http.Error(w, error, code)
}
