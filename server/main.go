package main

import (
	"log"
	"net/http"

	"gitlab.helmsauer2000.local/Portal/CustomerPortalApp/server/pkg/api"
)

func main() {
	http.HandleFunc("/api/v1/login", api.Login)
	http.HandleFunc("/api/v1/vertraege", api.Vertraege)
	http.HandleFunc("/api/v1/dokument", api.Dokument)
	http.HandleFunc("/api/v1/melden", api.Melden)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
