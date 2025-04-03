package main

import (
	"log"
	"os"
	"os/signal"
	"server/config"
	"server/internal"
	"server/internal/adapters"
	"server/internal/services"
	"server/pkg"
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
