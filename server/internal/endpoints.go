package internal

import (
	"encoding/json"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"server/internal/domain"
	"server/internal/repositories"
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
	parkSenseRepo repositories.IParkSetRepository
}

func NewEndpoints(deviceStorage domain.DeviceStore, parkSenseRepo repositories.IParkSetRepository) (*Endpoints, error) {
	tmpl, err := template.ParseFS(templates.FileStream, "*.html")

	if err != nil {
		return nil, err
	}

	return &Endpoints{
		tmpl:          tmpl,
		deviceStorage: deviceStorage,
		parkSenseRepo: parkSenseRepo,
	}, nil
}

func (e *Endpoints) RegisterEndpoints(router *mux.Router) {
	router.HandleFunc("/", e.index).Methods("GET")
	router.HandleFunc("/ping", e.Ping)
	router.HandleFunc("/devices", e.getDevices)
	router.HandleFunc("/api/parksets", e.getParkSets).Methods("GET")
	router.HandleFunc("/api/parksets/update", e.updateLotsPosition).Methods("POST")

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

func (e *Endpoints) Ping(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("pong"))
}

func (e *Endpoints) index(w http.ResponseWriter, r *http.Request) {
	e.tmpl.ExecuteTemplate(w, "index.html", nil)
}

func (e *Endpoints) getDevices(w http.ResponseWriter, r *http.Request) {
	parkSets := e.deviceStorage.GetDevices()

	type Section struct {
		Index int
		Lots  []string
	}
	secs := make([]Section, len(parkSets))

	for i, ps := range parkSets {
		ids := make([]string, len(ps.Lots))
		for j := range ps.Lots {
			ids[j] = fmt.Sprintf("%d", j+1)
		}
		secs[i] = Section{Index: i, Lots: ids}
	}

	data := struct {
		Sections []Section
	}{Sections: secs}

	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	e.tmpl.ExecuteTemplate(w, "devices.html", data)
}

func (e *Endpoints) getParkSets(w http.ResponseWriter, r *http.Request) {
	parkSets, err := e.parkSenseRepo.GetAllParkSets()
	if err != nil {
		http.Error(w, "failed to load park sets", http.StatusInternalServerError)
		return
	}

	type ts struct {
		Seconds int64 `json:"seconds"`
		Nanos   int32 `json:"nanos"`
	}
	type lotJSON struct {
		ParkLotID string `json:"park_lot_id"`
		State     string `json:"state"`
		Row       uint32 `json:"row"`
		Column    uint32 `json:"column"`
	}
	type setJSON struct {
		ParkSetsID string    `json:"park_set_id"`
		Lots       []lotJSON `json:"lots"`
		State      string    `json:"state"`
		Timestamp  ts        `json:"timestamp"`
	}
	var resp struct {
		ParkSets []setJSON `json:"park_sets"`
	}

	for _, ps := range parkSets {
		var setState string
		switch ps.State {
		case domain.Normal:
			setState = "NORMAL"
		case domain.Fire:
			setState = "FIRE"
		default:
			setState = "UNKNOWN"
		}

		sj := setJSON{
			ParkSetsID: ps.PublicId,
			State:      setState,
			Timestamp: ts{
				Seconds: ps.CreatedAt.Unix(),
				Nanos:   int32(ps.CreatedAt.Nanosecond()),
			},
		}

		for _, lot := range ps.Lots {
			var lotState string
			switch lot.State {
			case domain.Free:
				lotState = "FREE"
			case domain.Occupied:
				lotState = "OCCUPIED"
			case domain.Reserved:
				lotState = "RESERVED"
			default:
				lotState = "UNKNOWN"
			}

			sj.Lots = append(sj.Lots, lotJSON{
				ParkLotID: lot.PublicId,
				State:     lotState,
				Row:       lot.Row,
				Column:    lot.Column,
			})
		}

		resp.ParkSets = append(resp.ParkSets, sj)
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

func (e *Endpoints) updateLotsPosition(w http.ResponseWriter, r *http.Request) {
	var payload struct {
		Placements []struct {
			SlotId string `json:"slotId"`
			Row    uint32 `json:"row"`
			Col    uint32 `json:"col"`
		} `json:"placements"`
	}

	if err := json.NewDecoder(r.Body).Decode(&payload); err != nil {
		http.Error(w, "Invalid payload", http.StatusBadRequest)
		return
	}

	for _, p := range payload.Placements {
		lot, err := e.parkSenseRepo.GetLotByPublicId(p.SlotId)
		if err != nil {
			log.Printf("Lot not found %s: %v", p.SlotId, err)
			continue
		}
		lot.Row = p.Row
		lot.Column = p.Col

		if err := e.parkSenseRepo.UpdateLot(lot); err != nil {
			log.Printf("Failed to update lot %s: %v", p.SlotId, err)
		}
	}

	w.WriteHeader(http.StatusNoContent)
}
