package domain

import (
	"server/pkg"

	"gorm.io/gorm"
)

const (
	Normal ParkState = iota
	Fire
)

const (
	Unknown ParkLotState = iota
	Free
	Occupied
	Reserved
)

type (
	ParkState    int
	ParkLotState int

	ParkLot struct {
		pkg.EntityBase
		ParkSetID string
		State     ParkLotState
		Row       uint32 `gorm:"column:row"`
		Column    uint32 `gorm:"column:col"`
	}

	ParkSet struct {
		pkg.EntityBase
		Lots  []ParkLot `gorm:"foreignKey:ParkSetID;references:ID"`
		State ParkState
	}
)

func NewParkLot(state ParkLotState, row, col uint32) *ParkLot {
	return &ParkLot{
		State:  state,
		Row:    row,
		Column: col,
	}
}

func (b *ParkLot) TableName() string {
	return "park_lot"
}

func (u *ParkLot) BeforeCreate(tx *gorm.DB) error {
	u.GetId()

	u.DeletedAt = nil
	return nil
}

func NewParkSet(state ParkState) *ParkSet {
	return &ParkSet{
		State: state,
		Lots:  make([]ParkLot, 0),
	}
}

func (p *ParkSet) AddLot(lot *ParkLot) {
	p.Lots = append(p.Lots, *lot)
}

func (b *ParkSet) TableName() string {
	return "park_set"
}

func (u *ParkSet) BeforeCreate(tx *gorm.DB) error {
	u.GetId()

	u.DeletedAt = nil
	return nil
}

func GetParkLotState(state ParkLotState) string {
	switch state {
	case Free:
		return "FREE"
	case Occupied:
		return "OCCUPIED"
	case Reserved:
		return "RESERVED"
	default:
		return "UNKNOWN"
	}
}
