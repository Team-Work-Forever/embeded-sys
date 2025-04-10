package adapters

import (
	"server/internal/domain"
	"time"

	"github.com/google/uuid"
)

type (
	BluetoothServer struct {
		deviceStore domain.DeviceStore
	}
)

func NewBluetoothServer(deviceStore domain.DeviceStore) *BluetoothServer {
	return &BluetoothServer{
		deviceStore: deviceStore,
	}
}

func (blue *BluetoothServer) Serve() error {
	ticker := time.NewTicker(10 * time.Second)
	defer ticker.Stop()

	for t := range ticker.C {
		blue.deviceStore.AddDevice(&domain.ParkSet{
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
