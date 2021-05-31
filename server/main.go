package main

import (
	"log"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"

	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api"
)

func main() {
	r := chi.NewRouter()

	r.Use(
		middleware.Recoverer,
		middleware.Logger,
		middleware.Timeout(time.Minute),
	)

	r.Route("/api/v1", func(r chi.Router) {
		r.Post("/login", api.Login)

		r = r.With(
			api.CredentialChecker,
		)
		r.Route("/verträge", func(r chi.Router) {
			r.Get("/", api.Vertraege)
		})
		r.Route("/adressen", func(r chi.Router) {
			r.Get(string("/{"+api.AdressID+"}/dokumente/{"+api.DokumentID+"}"), api.Dokument)
		})
		r.Post("/vorgänge", api.Melden)

		// legacy
		r.Get("/vertraege", api.Vertraege)
		r.Post("/melden", api.Melden)
	})

	log.Fatal(http.ListenAndServe(":8080", r))
}
