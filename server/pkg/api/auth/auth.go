package auth

import (
	"context"
	"crypto/md5"
	"encoding/base64"
	"fmt"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5/middleware"
	"github.com/google/uuid"
	"github.com/hashicorp/go-version"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/handle"
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
			log.Printf("[%s] user %s %s", reqID, c.Gruppe, c.User)

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

func AdminTokenChecker() func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			if r.Header.Get("authorization") != "6ac06fc6-285e-4e39-8df8-14d7373fe4a8" {
				handleError(w, "Invalid authorization", http.StatusUnauthorized)
				return
			}
			next.ServeHTTP(w, r)
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
type responseLogin struct {
	Token string `json:"token"`
}

func Login(ctx context.Context, l requestLogin) (responseLogin, error) {
	if l.Gruppe == data.MyHelmsauerGroup {
		return loginMyHelmsauerAccount(l.User, l.Password)
	}

	client := proclient.Client{
		User:     l.User,
		Password: l.Password,
		Gruppe:   l.Gruppe,
	}

	msg, ok, err := client.Login()
	if err != nil {
		return responseLogin{}, err
	}
	if !ok {
		return responseLogin{}, handle.Error{
			Inner:    fmt.Errorf(msg),
			HttpCode: http.StatusForbidden,
		}
	}

	token := uuid.New().String()

	data.StoreCredentials(token, client)

	return responseLogin{
		Token: token,
	}, nil
}

func loginMyHelmsauerAccount(user, pw string) (responseLogin, error) {
	account, err := data.LoadSubaccount(user)
	if err != nil {
		return responseLogin{}, err
	}
	if PassHash(pw) != account.PasswordHash {
		return responseLogin{}, handle.Error{
			Inner:    fmt.Errorf("Ungültiges Passwort"),
			HttpCode: http.StatusForbidden,
		}
	}

	token := uuid.New().String()

	data.StoreSubAccountToken(token, account.SubAccount)

	return responseLogin{
		Token: token,
	}, nil
}

func handleError(w http.ResponseWriter, error string, code int) {
	fmt.Println(code, error)
	http.Error(w, error, code)
}

func PassHash(pw string) string {
	b := md5.Sum([]byte(pw))
	return base64.StdEncoding.EncodeToString(b[:])
}
