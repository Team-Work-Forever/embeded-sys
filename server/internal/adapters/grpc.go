package adapters

import (
	"fmt"
	"log"
	"net"
	"server/pkg"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/keepalive"
)

type GRPCServer struct {
	instance *grpc.Server
}

const (
	MaxConnectionIdle = 5 * time.Minute
	Time              = 2 * time.Minute
	TimeOut           = 20 * time.Second
)

func NewRPCServer() (*GRPCServer, error) {
	return &GRPCServer{
		instance: grpc.NewServer(grpc.KeepaliveParams(keepalive.ServerParameters{
			MaxConnectionIdle: MaxConnectionIdle,
			Time:              Time,
			Timeout:           TimeOut,
		})),
	}, nil
}

func (rpc *GRPCServer) RegisterServices(controllers []pkg.Controller) error {
	for i := range controllers {
		controllers[i].RegisterControllers(rpc.instance)
	}

	return nil
}

func (rpc *GRPCServer) Serve(port string) error {
	listAddr, err := net.Listen("tcp", fmt.Sprintf(":%s", port))

	if err != nil {
		return err
	}

	if err := rpc.instance.Serve(listAddr); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}

	return nil
}

func (rpc *GRPCServer) Close() {
	rpc.instance.GracefulStop()
}
