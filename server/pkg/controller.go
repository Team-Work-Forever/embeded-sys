package pkg

import (
	"google.golang.org/grpc"
)

type Controller interface {
	Register(*grpc.Server)
}
