package main

import (
	"flag"
	"log"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api"
)

var testserver = flag.Bool("testserver", false, "Startet den Server mit einer test config.")

func main() {
	flag.Parse()
	r := chi.NewRouter()

	r.Use(
		middleware.Recoverer,
		middleware.Logger,
		middleware.Timeout(10*time.Minute),
	)

	s := server()

	r.Route("/api/v1", func(r chi.Router) {
		r.Post("/login", s.Login)

		r = r.With(
			api.CredentialChecker,
		)
		r.Route("/verträge", func(r chi.Router) {
			r.Get("/", s.Vertraege)
		})
		r.Route("/adressen", func(r chi.Router) {
			r.Get(string("/{"+api.AdressID+"}/dokumente/{"+api.DokumentID+"}"), s.Dokument)
		})
		r.Post("/vorgänge", s.Melden)

		// legacy
		r.Get("/vertraege", s.Vertraege)
		r.Post("/melden", s.Melden)
	})

	log.Fatal(http.ListenAndServe(":8080", r))
}

func server() api.Server {
	if *testserver {
		return api.Server{
			SchadenmeldungReceiver: []string{
				"jan-erik.keller@helmsauer-gruppe.de",
				"udo.roehlich@helmsauer-gruppe.de",
				"bastian.helmsauer@helmsauer-gruppe.de",
			},
		}
	}

	return api.Server{
		SchadenmeldungReceiver: []string{
			"info@helmsauer-gruppe.de",
			"jan-erik.keller@helmsauer-gruppe.de",
			"bastian.helmsauer@helmsauer-gruppe.de",
		},
	}
}
