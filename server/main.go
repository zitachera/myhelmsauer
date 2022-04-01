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
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/admin"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/auth"
	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api/handle"
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
		handle.Post(r, "/login", auth.Login)
		r.Post("/remind", auth.PostRemind(mailRecipients(
			"info@helmsauer-gruppe.de",
			"jan-erik.keller@helmsauer-gruppe.de",
			"bastian.helmsauer@helmsauer-gruppe.de",
		)))

		r.Route("/admin", administration)

		r = r.With(
			auth.CredentialChecker(version.Must(version.NewSemver("1.7.2"))),
		)
		r.Route("/verträge", func(r chi.Router) {
			handle.Get(r, "/", api.Verträge)
		})
		r.Route("/fremdverträge", func(r chi.Router) {
			r.Post("/", api.PostForeignVertrag(mailRecipients(
				"info@helmsauer-gruppe.de",
				"jan-erik.keller@helmsauer-gruppe.de",
				"bastian.helmsauer@helmsauer-gruppe.de",
			)))
		})
		r.Route("/adressen", func(r chi.Router) {
			r.Get("/"+api.AdressID.Ref()+"/dokumente/"+api.DokumentID.Ref(), api.Dokument)
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

func administration(r chi.Router) {
	r = r.With(
		auth.AdminTokenChecker(),
	)
	r.Get("/stats", api.Stats)
	r.Route("/user", func(r chi.Router) {
		handle.Get(r, "/", admin.GetUsers)
		handle.Post(r, "/", admin.PostUser)
		handle.Put(r, "/", admin.PutUser)

		r.Route("/"+admin.UserNameID.Ref(), func(r chi.Router) {

			handle.Delete(r, "/", admin.DeleteUser)

			r.Route("/vertrag", func(r chi.Router) {
				handle.Get(r, "/", admin.GetVerträge)
				handle.Put(r, "/", admin.PutVerträge)
			})
		})
	})
}
