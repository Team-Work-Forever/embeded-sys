package adapters

import (
	"fmt"
	"log"
	"net"
	"server/pkg"

	"google.golang.org/grpc"
)

type GRPCServer struct {
	instance *grpc.Server
}

func NewRPCServer() (*GRPCServer, error) {
	return &GRPCServer{
		instance: grpc.NewServer(),
	}, nil
}

func (rpc *GRPCServer) RegisterServices(controllers []pkg.Controller) error {
	for i := range controllers {
		controllers[i].Register(rpc.instance)
	}

	return nil
}

func (rpc *GRPCServer) Serve(port string) error {
	listAddr, err := net.Listen("tcp", fmt.Sprintf(":%s", port))

	if err != nil {
		return err
	}

	log.Printf("Server is running on port %s...\n", port)

	if err := rpc.instance.Serve(listAddr); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}

	return nil
}

func (rpc *GRPCServer) Close() {
	rpc.instance.GracefulStop()
}
