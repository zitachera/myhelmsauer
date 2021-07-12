package api

import (
	"context"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/hashicorp/go-version"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/data"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/proclient"
)

type URLParameter string

const (
	AdressID   URLParameter = "adressID"
	DokumentID URLParameter = "dokumentID"
)

func (p URLParameter) From(r *http.Request) string {
	return chi.URLParam(r, string(p))
}

type ctxKey int

const (
	proclientKey ctxKey = iota
)

func (s *Server) CredentialChecker(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		c, err := data.LoadCredentials(r.Header.Get("authorization"))
		if err != nil {
			handleError(w, err.Error(), http.StatusUnauthorized)
			return
		}
		clientVersion := r.Header.Get("client-version")
		if clientVersion != "" {
			cv, err := version.NewSemver(clientVersion)
			if err != nil {
				handleError(w, err.Error(), http.StatusBadRequest)
				return
			}
			if cv.LessThan(s.MinClientVersion) {
				handleError(w, "Client Version "+s.MinClientVersion.String()+" required", http.StatusUpgradeRequired)
				return
			}
		}

		ctx := context.WithValue(r.Context(), proclientKey, c)
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}

func getClientFromRequest(r *http.Request) proclient.Client {
	return getClient(r.Context())
}

func getClient(ctx context.Context) proclient.Client {
	return ctx.Value(proclientKey).(proclient.Client)
}
