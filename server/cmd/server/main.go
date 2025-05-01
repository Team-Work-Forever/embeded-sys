package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/signal"
	"server/config"
	"server/internal"
	"server/internal/adapters"
	"server/internal/domain"
	"server/internal/middlewares"
	"server/internal/repositories"
	"server/internal/services"
	"server/pkg"
	"server/pkg/helpers"
	"server/pkg/utils"
	"strings"
	"syscall"

	"google.golang.org/grpc"
)

func main() {
	config.LoadEnv(config.DotEnv)
	env := config.GetCofig()

	// generate pkis
	if err := generatePki(); err != nil {
		panic(err)
	}

	if err := generateJWKS(); err != nil {
		panic(err)
	}

	// database
	db := adapters.GetDatabase()
	defer db.Close()

	redis := adapters.GetRedis()
	defer redis.Close()

	// Init global state of the application
	globalState := domain.NewDeviceManager()

	// rpc server
	tokenHelper := helpers.NewTokenService(redis)
	authStreamInterceptor := middlewares.NewAuthMiddleware(tokenHelper)

	grpcServer, err := adapters.NewRPCServer(
		grpc.StreamInterceptor(authStreamInterceptor.StreamHandler),
		grpc.UnaryInterceptor(
			middlewares.ConditionalUnaryInterceptor(
				authStreamInterceptor.UnaryHandler,
				func(ctx context.Context, info *grpc.UnaryServerInfo) bool {
					return !strings.HasPrefix(info.FullMethod, "/auth.AuthService/")
				},
			),
		),
	)

	if err != nil {
		panic(err)
	}

	defer grpcServer.Close()

	// repositories
	authRepository := repositories.NewAuthRepository(db)
	parkSetRepository := repositories.NewParkSetRepository(db)
	reserveRepository := repositories.NewReserveRepository(db)
	reserveHistoryRepository := repositories.NewReserveHistoryRepository(db)

	// http server
	// Start an http server (alpine.js, htmx)
	httpServer := adapters.NewHttpServer()
	defer httpServer.Close()

	endpoints, err := internal.NewEndpoints(globalState, parkSetRepository)

	if err != nil {
		panic(err)
	}

	// bluetooth client
	bluetoothServer := adapters.NewBluetoothServer(globalState, parkSetRepository)

	// service registration
	authService := services.NewAuthServiceImpl(authRepository, tokenHelper)

	parkSenseService := services.NewParkSenseServiceImpl(globalState, reserveRepository, reserveHistoryRepository, authRepository, parkSetRepository)

	// start service
	grpcServer.RegisterServices([]pkg.Controller{
		authService,
		parkSenseService,
	})

	// start shared services
	go startHttpServer(httpServer, endpoints, env.HTTP_SERVER_PORT)
	go startGRPCServer(grpcServer, env.GRPC_SERVER_PORT)
	go startBluetooth(bluetoothServer)

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

func generatePki() error {
	if !helpers.MustCreatePKI() {
		if err := helpers.GenerateServerPKI(); err != nil {
			return err
		}
	}

	// load pki
	publicKey, privateKey, err := helpers.ReadKeys()

	if err != nil {
		return err
	}

	err = helpers.LoadKeys(privateKey, publicKey)

	if err != nil {
		return err
	}

	return nil
}

func generateJWKS() error {
	if _, err := helpers.NewJWKS(); err != nil {
		return err
	}

	return nil
}

func startBluetooth(bluetoothServer *adapters.BluetoothServer) {
	if err := bluetoothServer.Serve(); err != nil {
		log.Fatal(err)
	}
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
