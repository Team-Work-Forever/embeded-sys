package internal

import (
	"encoding/json"
	"fmt"
	"html/template"
	"net/http"
	"server/internal/domain"
	"server/pkg/helpers"
	"server/templates"

	"github.com/gorilla/mux"
)

type Dummy struct {
	Id string
}

type Endpoints struct {
	tmpl *template.Template

	deviceStorage domain.DeviceStore
}

func NewEndpoints(deviceStorage domain.DeviceStore) (*Endpoints, error) {
	tmpl, err := template.ParseFS(templates.FileStream, "*.html")

	if err != nil {
		return nil, err
	}

	return &Endpoints{
		tmpl:          tmpl,
		deviceStorage: deviceStorage,
	}, nil
}

func (e *Endpoints) RegisterEndpoints(router *mux.Router) {
	router.HandleFunc("/", e.index)
	router.HandleFunc("/devices", e.getDevices)

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

func (e *Endpoints) getDevices(w http.ResponseWriter, r *http.Request) {
	data := map[string][]*domain.ParkSet{
		"Modules": e.deviceStorage.GetDevices(),
	}

	e.tmpl.ExecuteTemplate(w, "devices.html", data)
}
