package adapters

import (
	"log"
	"math/rand"
	"server/internal/domain"
	"server/internal/repositories"
	"time"
)

type (
	BluetoothServer struct {
		deviceStore domain.DeviceStore
		parkSetRepo repositories.IParkSetRepository
	}
)

func NewBluetoothServer(deviceStore domain.DeviceStore, parkSetRepo repositories.IParkSetRepository) *BluetoothServer {
	return &BluetoothServer{
		deviceStore: deviceStore,
		parkSetRepo: parkSetRepo,
	}
}

var rng = rand.New(rand.NewSource(time.Now().UnixNano()))

func (blue *BluetoothServer) Serve() error {
	const setsToCreate = 3
	const lotsPerSet = 3

	validStates := []domain.ParkLotState{domain.Free, domain.Occupied, domain.Reserved}
	validParkSetStates := []domain.ParkState{domain.Normal, domain.Fire}

	for i := 0; i < setsToCreate; i++ {
		stateParkSet := validParkSetStates[rng.Intn(len(validParkSetStates))]
		parkSet := domain.NewParkSet(stateParkSet)

		for j := 0; j < lotsPerSet; j++ {
			state := validStates[rng.Intn(len(validStates))]
			row := uint32(rng.Intn(10) + 1)
			col := uint32(rng.Intn(10) + 1)

			lot := domain.NewParkLot(state, row, col)
			parkSet.AddLot(lot)
		}

		if err := blue.parkSetRepo.Create(parkSet); err != nil {
			log.Printf("Error creating ParkSet: %s", err.Error())
			continue
		}

		blue.deviceStore.AddDevice(parkSet)

		time.Sleep(2 * time.Second)
	}

	return nil
}
