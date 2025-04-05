package main

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"server/config"
	"server/internal"
	"server/internal/adapters"
	"server/internal/services"
	"server/pkg"
	"server/pkg/utils"
	"syscall"
)

func main() {
	config.LoadEnv(config.DotEnv)
	env := config.GetCofig()

	// database
	db := adapters.GetDatabase()
	defer db.Close()

	// rpc server
	grpcServer, err := adapters.NewRPCServer()

	if err != nil {
		panic(err)
	}

	defer grpcServer.Close()

	// http server
	// Start an http server (alpine.js, htmx)
	httpServer := adapters.NewHttpServer()
	defer httpServer.Close()

	endpoints, err := internal.NewEndpoints()

	if err != nil {
		panic(err)
	}

	// bluetooth client
	/// 1. Must be another process always checking new devices connecting to the pull the modules

	// service registration
	greet_service := services.NewGreetService()

	// start service
	grpcServer.RegisterServices([]pkg.Controller{
		greet_service,
	})

	// start shared services
	go startHttpServer(httpServer, endpoints, env.HTTP_SERVER_PORT)
	go startGRPCServer(grpcServer, env.GRPC_SERVER_PORT)

	utils.DrawRectangle([]utils.Entry{
		&utils.CenterBlock{BlockItem: utils.BlockItem{Value: "Raspberry Pi & Arduino", Color: utils.Red}},
		&utils.EntryBlock{
			Title: utils.BlockItem{Value: "Listning on...", Color: utils.Blue},
			Value: utils.BlockItem{Value: fmt.Sprintf("http://%s:%s", "localhost", env.HTTP_SERVER_PORT), Color: utils.Green},
		},
		&utils.EntryBlock{
			Title: utils.BlockItem{Value: "Listning on...", Color: utils.Blue},
			Value: utils.BlockItem{Value: fmt.Sprintf("grpc://%s:%s", "localhost", env.GRPC_SERVER_PORT), Color: utils.Green},
		},
	})

	// Gracefull exit
	stop := make(chan os.Signal, 1)
	signal.Notify(stop, syscall.SIGINT, syscall.SIGTERM)

	<-stop
	log.Println("Shutting down servers...")
}

func startHttpServer(httpServer *adapters.HttpServer, endpoints *internal.Endpoints, httpPort string) {
	if err := httpServer.Serve(endpoints, httpPort); err != nil {
		log.Fatal(err)
	}
}

func startGRPCServer(grpcServer *adapters.GRPCServer, grpcPort string) {
	if err := grpcServer.Serve(grpcPort); err != nil {
		log.Fatal(err)
	}
}
