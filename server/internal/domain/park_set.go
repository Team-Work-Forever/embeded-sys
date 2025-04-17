package domain

import "time"

const (
	Normal ParkState = iota
	Fire

	Unknown ParkLotState = iota
	Free
	Occupied
	Reserved
)

type (
	ParkState    int
	ParkLotState int

	ParkLot struct {
		Id     string
		State  ParkLotState
		Row    uint32
		Column uint32
	}

	ParkSet struct {
		Id        string // MAC
		Lots      []ParkLot
		State     ParkState
		Timestamp time.Time // On Connect
	}
)
