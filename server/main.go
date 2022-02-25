package main

import (
	"flag"
	"log"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/hashicorp/go-version"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/auth"
)

var testserver = flag.Bool("testserver", false, "Startet den Server mit einer test config.")

func main() {
	flag.Parse()
	r := chi.NewRouter()

	r.Use(
		middleware.RequestID,
		middleware.Logger,
		middleware.Recoverer,
		middleware.Timeout(10*time.Minute),
	)

	r.Route("/api/v1", func(r chi.Router) {
		r.Post("/login", auth.Login())
		r.Post("/remind", auth.PostRemind(mailRecipients(
			"info@helmsauer-gruppe.de",
			"jan-erik.keller@helmsauer-gruppe.de",
			"bastian.helmsauer@helmsauer-gruppe.de",
		)))
		r.Get("/stats", api.Stats)

		r = r.With(
			auth.CredentialChecker(version.Must(version.NewSemver("1.7.2"))),
		)
		r.Route("/verträge", func(r chi.Router) {
			r.Get("/", api.Vertraege)
		})
		r.Route("/fremdverträge", func(r chi.Router) {
			r.Post("/", api.PostForeignVertrag(mailRecipients(
				"info@helmsauer-gruppe.de",
				"jan-erik.keller@helmsauer-gruppe.de",
				"bastian.helmsauer@helmsauer-gruppe.de",
			)))
		})
		r.Route("/adressen", func(r chi.Router) {
			r.Get(string("/{"+api.AdressID+"}/dokumente/{"+api.DokumentID+"}"), api.Dokument)
		})
		r.Post("/vorgänge", api.PostVorgang(mailRecipients(
			"info@helmsauer-gruppe.de",
			"jan-erik.keller@helmsauer-gruppe.de",
			"bastian.helmsauer@helmsauer-gruppe.de",
		)))
		r.Post("/message", api.PostMessage(mailRecipients(
			"info@helmsauer-gruppe.de",
			"jan-erik.keller@helmsauer-gruppe.de",
			"bastian.helmsauer@helmsauer-gruppe.de",
		)))
	})

	log.Fatal(http.ListenAndServe(":8080", r))
}

func mailRecipients(recipients ...string) []string {
	if *testserver {
		return []string{"jan-erik.keller@helmsauer-gruppe.de"}
	}
	return recipients
}
