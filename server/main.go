/*package main

import (
	"flag"
	"log"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/hashicorp/go-version"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/account"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/admin"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/auth"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/handle"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/verzeichnis"
	"gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/data"
)

var testserver = flag.Bool("testserver", false, "Startet den Server mit einer test config.")

func main() {
	flag.Parse()

	if err := data.Open("database.db"); err != nil {
		panic(err)
	}
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
			//"info@helmsauer-gruppe.de",
			//"jan-erik.keller@helmsauer-gruppe.de",
			//"bastian.helmsauer@helmsauer-gruppe.de",
			"zita.mounyicha@helmsauer-gruppe.de"
		)))

		r.Route("/admin", administration)

		r = r.With(
			auth.CredentialChecker(version.Must(version.NewSemver("1.9.1"))),
		)
		r.Route("/info", func(r chi.Router) {
			handle.Get(r, "/", account.Info)
		})
		r.Route("/password", func(r chi.Router) {
			handle.Post(r, "/", account.ChangePassword)
		})
		r.Route("/verträge", func(r chi.Router) {
			handle.Get(r, "/", api.Verträge)
		})
		r.Route("/verzeichnis", func(r chi.Router) {
			handle.Get(r, "/", verzeichnis.GetVerzeichnis)
			handle.Put(r, "/", verzeichnis.PutWertgegenstand)
			handle.Delete(r, "/"+verzeichnis.ID.Ref(), verzeichnis.DeleteWertgegenstand)
		})
		r.Route("/fremdverträge", func(r chi.Router) {
			r.Post("/", api.PostForeignVertrag(mailRecipients(
				//"info@helmsauer-gruppe.de",
				//"jan-erik.keller@helmsauer-gruppe.de",
				//"bastian.helmsauer@helmsauer-gruppe.de",
				"zita.mounyicha@helmsauer-gruppe.de"
			)))
		})
		r.Route("/adressen", func(r chi.Router) {
			r.Get("/"+api.AdressID.Ref()+"/dokumente/"+api.DokumentID.Ref(), api.Dokument)
		})
		r.Post("/vorgänge", api.PostVorgang(mailRecipients(
			//"info@helmsauer-gruppe.de",
			//"jan-erik.keller@helmsauer-gruppe.de",
			//"bastian.helmsauer@helmsauer-gruppe.de",
			"zita.mounyicha@helmsauer-gruppe.de"
		)))
		r.Post("/message", api.PostMessage(mailRecipients(
			//"info@helmsauer-gruppe.de",
			//"jan-erik.keller@helmsauer-gruppe.de",
			//"bastian.helmsauer@helmsauer-gruppe.de",
			"zita.mounyicha@helmsauer-gruppe.de"
		)))
	})

	//log.Fatal(http.ListenAndServe(":8080", r))
	log.Fatal(http.ListenAndServe("172.18.48.242:8080", r))
}

func mailRecipients(recipients ...string) []string {
	if *testserver {
		return []string{ "zita.mounyicha@helmsauer-gruppe.de"//"jan-erik.keller@helmsauer-gruppe.de" }
	}
	return recipients
}

func administration(r chi.Router) {
	r = r.With(
		auth.AdminTokenChecker(),
	)
	handle.Get(r, "/stats", admin.Stats)
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
}*/


package main

import (
	"flag"
	"log"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/hashicorp/go-version"

    "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api"
    "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/account"
    "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/admin"
    "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/auth"
    "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/handle"
    "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/api/verzeichnis"
    "gitlab.helmsauer-it-solutions.org/versicherung/myhelmsauer/server/pkg/data"
)

var testserver = flag.Bool("testserver", false, "Startet den Server mit einer test config.")

func main() {
    flag.Parse()

    if err := data.Open("database.db"); err != nil {
        panic(err)
    }

    r := chi.NewRouter()

    // Configuration CORS simplifiée qui accepte toutes les origines
    r.Use(func(next http.Handler) http.Handler {
        return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
            w.Header().Set("Access-Control-Allow-Origin", "*")
            w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
            w.Header().Set("Access-Control-Allow-Headers", "Accept, Authorization, Content-Type, client-version")
            
            if r.Method == "OPTIONS" {
                w.WriteHeader(http.StatusOK)
                return
            }
            
            next.ServeHTTP(w, r)
        })
    },
        middleware.RequestID,
        middleware.Logger,
        middleware.Recoverer,
        middleware.Timeout(10*time.Minute),
    )

    r.Route("/api/v1", func(r chi.Router) {
        handle.Post(r, "/login", auth.Login)

        r.Post("/remind", auth.PostRemind(mailRecipients(
            //"info@helmsauer-gruppe.de",
            //"jan-erik.keller@helmsauer-gruppe.de",
            //"bastian.helmsauer@helmsauer-gruppe.de",
            "zita.mounyicha@helmsauer-gruppe.de",
        )))

        r.Route("/admin", administration)

        r = r.With(
            auth.CredentialChecker(version.Must(version.NewSemver("1.9.1"))),
        )

        r.Route("/info", func(r chi.Router) {
            handle.Get(r, "/", account.Info)
        })

        r.Route("/password", func(r chi.Router) {
            handle.Post(r, "/", account.ChangePassword)
        })

        r.Route("/verträge", func(r chi.Router) {
            handle.Get(r, "/", api.Verträge)
        })

        r.Route("/verzeichnis", func(r chi.Router) {
            handle.Get(r, "/", verzeichnis.GetVerzeichnis)
            handle.Put(r, "/", verzeichnis.PutWertgegenstand)
            handle.Delete(r, "/"+verzeichnis.ID.Ref(), verzeichnis.DeleteWertgegenstand)
        })

        r.Route("/fremdverträge", func(r chi.Router) {
            r.Post("/", api.PostForeignVertrag(mailRecipients(
                //"info@helmsauer-gruppe.de",
                //"jan-erik.keller@helmsauer-gruppe.de",
                //"bastian.helmsauer@helmsauer-gruppe.de",
                "zita.mounyicha@helmsauer-gruppe.de",
            )))
        })

        r.Route("/adressen", func(r chi.Router) {
            r.Get("/"+api.AdressID.Ref()+"/dokumente/"+api.DokumentID.Ref(), api.Dokument)
        })

        r.Post("/vorgänge", api.PostVorgang(mailRecipients(
            //"info@helmsauer-gruppe.de",
            //"jan-erik.keller@helmsauer-gruppe.de",
            //"bastian.helmsauer@helmsauer-gruppe.de",
            "zita.mounyicha@helmsauer-gruppe.de",
        )))

        r.Post("/message", api.PostMessage(mailRecipients(
            //"info@helmsauer-gruppe.de",
            //"jan-erik.keller@helmsauer-gruppe.de",
            //"bastian.helmsauer@helmsauer-gruppe.de",
            "zita.mounyicha@helmsauer-gruppe.de",
        )))
    })

    // ✅ Écoute sur toutes les interfaces (hôte + conteneur). En Docker, expose le port 8080 côté hôte.
    log.Fatal(http.ListenAndServe(":8080", r))
}

func mailRecipients(recipients ...string) []string {
    if *testserver {
        return []string{
            "zita.mounyicha@helmsauer-gruppe.de", // "jan-erik.keller@helmsauer-gruppe.de"
        }
    }
    return recipients
}

func administration(r chi.Router) {
    r = r.With(
        auth.AdminTokenChecker(),
    )
    handle.Get(r, "/stats", admin.Stats)
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
