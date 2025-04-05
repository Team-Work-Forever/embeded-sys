package pkg

import (
	"google.golang.org/grpc"
)

type Controller interface {
	RegisterControllers(*grpc.Server)
}
