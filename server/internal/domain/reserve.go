package domain

import (
	"server/pkg"
	"time"

	"gorm.io/gorm"
)

type (
	Reserve struct {
		pkg.EntityBase
		SlotId    string `gorm:"column:slot_id"`
		SlotLabel string `gorm:"column:slot_label"`
		UserId    string `gorm:"column:user_id"`
		Timestamp time.Time
	}

	ReserveHistory struct {
		pkg.EntityBase
		SlotId         string    `gorm:"column:slot_id"`
		SlotLabel      string    `gorm:"column:slot_label"`
		UserId         string    `gorm:"column:user_id"`
		TimestampBegin time.Time `gorm:"column:timestamp_begin"`
		TimestampEnd   time.Time `gorm:"column:timestamp_end"`
	}
)

func NewReserve(slotId, userID, slotLabel string, time time.Time) *Reserve {
	return &Reserve{
		SlotId:    slotId,
		SlotLabel: slotLabel,
		UserId:    userID,
		Timestamp: time,
	}
}

func (b *Reserve) TableName() string {
	return "reserve"
}

func (u *Reserve) BeforeCreate(tx *gorm.DB) error {
	u.GetId()

	u.DeletedAt = nil
	return nil
}

func NewReserveHistory(slotId, userId, slotLabel string, timeBegin, timeEnd time.Time) *ReserveHistory {
	return &ReserveHistory{
		SlotId:         slotId,
		SlotLabel:      slotLabel,
		UserId:         userId,
		TimestampBegin: timeBegin,
		TimestampEnd:   timeEnd,
	}
}

func (b *ReserveHistory) TableName() string {
	return "reserve_history"
}

func (u *ReserveHistory) BeforeCreate(tx *gorm.DB) error {
	u.GetId()

	u.DeletedAt = nil
	return nil
}
