package adapters

import (
	"server/internal/domain"
	"time"

	"github.com/google/uuid"
)

type (
	BluetoothServer struct {
	}
)

func NewBluetoothServer() *BluetoothServer {
	return &BluetoothServer{}
}

func (blue *BluetoothServer) Serve(updateFun func(*domain.ParkSet)) error {
	ticker := time.NewTicker(10 * time.Second)
	defer ticker.Stop()

	for t := range ticker.C {
		updateFun(&domain.ParkSet{
			Id: uuid.NewString(),
			Lots: []domain.ParkLot{
				{
					Id:    "Parking Lot",
					State: domain.Occupied,
				},
			},
			State:     domain.Normal,
			Timestamp: t,
		})
	}

	return nil
}
