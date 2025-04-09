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
		Id    string
		State ParkLotState
	}

	ParkSet struct {
		Id        string
		Lots      []ParkLot
		State     ParkState
		Timestamp time.Time
	}
)
