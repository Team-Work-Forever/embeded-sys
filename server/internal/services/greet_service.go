package services

import (
	"context"

	"server/internal/services/proto"

	"google.golang.org/grpc"
)

type (
	GreetServiceImpl struct {
		proto.UnimplementedGreetServiceServer
	}
)

func NewGreetService() *GreetServiceImpl {
	return &GreetServiceImpl{}
}

func (s *GreetServiceImpl) Register(server *grpc.Server) {
	proto.RegisterGreetServiceServer(server, s)
}

func (s *GreetServiceImpl) SayHello(ctx context.Context, in *proto.HelloRequest) (*proto.HelloResponse, error) {
	return &proto.HelloResponse{
		Message: "Hey baby ;)",
	}, nil
}
