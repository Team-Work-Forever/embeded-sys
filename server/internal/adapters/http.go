package adapters

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"server/internal"
	"time"

	"github.com/gorilla/mux"
)

const STATIC_PATH = "./static"

type HttpServer struct {
	instance *http.Server
	router   *mux.Router
}

func NewHttpServer() *HttpServer {
	router := mux.NewRouter()

	return &HttpServer{
		instance: &http.Server{
			Handler:        router,
			ReadTimeout:    10 * time.Second,
			WriteTimeout:   10 * time.Second,
			MaxHeaderBytes: 1 << 20,
		},
		router: router,
	}
}

func (h *HttpServer) Serve(endpoints *internal.Endpoints, port string) error {
	h.instance.Addr = fmt.Sprintf(":%s", port)

	h.router.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir(STATIC_PATH))))
	endpoints.RegisterEndpoints(h.router)

	log.Printf("Starting HTTP instance on %s...\n", port)
	return h.instance.ListenAndServe()
}

func (h *HttpServer) Shutdown(context context.Context) error {
	return h.instance.Shutdown(context)
}

func (h *HttpServer) Close() {
	if err := h.instance.Close(); err != nil {
		log.Printf("Error while closing HTTP server: %v\n", err)
		return
	}

	log.Println("HTTP server shut down successfully.")
}
