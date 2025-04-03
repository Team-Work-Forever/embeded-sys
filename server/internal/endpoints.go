package internal

import (
	"html/template"
	"net/http"
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
}

func (e *Endpoints) index(w http.ResponseWriter, r *http.Request) {
	e.tmpl.ExecuteTemplate(w, "index.html", nil)
}
