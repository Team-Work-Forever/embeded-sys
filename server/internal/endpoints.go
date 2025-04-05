package internal

import (
	"encoding/json"
	"fmt"
	"html/template"
	"net/http"
	"server/pkg/helpers"
	"server/templates"

	"github.com/gorilla/mux"
)

type Endpoints struct {
	tmpl *template.Template
}

func NewEndpoints() (*Endpoints, error) {
	tmpl, err := template.ParseFS(templates.FileStream, "*.html")

	if err != nil {
		return nil, err
	}

	return &Endpoints{
		tmpl: tmpl,
	}, nil
}

func (e *Endpoints) RegisterEndpoints(router *mux.Router) {
	router.HandleFunc("/", e.index)
	router.HandleFunc("/.well-known/jwks.json", e.jwks)
}

func (e *Endpoints) jwks(w http.ResponseWriter, _ *http.Request) {
	jwks, err := helpers.NewJWKS()

	if err != nil {
		http.Error(w, fmt.Sprintf("Error generating JWKS: %v", err), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(jwks)
}

func (e *Endpoints) index(w http.ResponseWriter, r *http.Request) {
	e.tmpl.ExecuteTemplate(w, "index.html", nil)
}
