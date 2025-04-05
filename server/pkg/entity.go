package pkg

import (
	"math/rand"
	"time"

	"github.com/google/uuid"
	"github.com/oklog/ulid"
	"gorm.io/gorm"
)

type Entity interface {
	GetId() string
}

type EntityBase struct {
	ID        string `gorm:"type:char(26);primaryKey;column:id"`
	PublicId  string
	CreatedAt time.Time       `gorm:"column:created_at;<-:update"`
	UpdatedAt time.Time       `gorm:"column:updated_at;<-:update"`
	DeletedAt *gorm.DeletedAt `gorm:"index"`
}

func (e *EntityBase) GetId() string {
	e.GetPublicId()

	if e.ID == "" {
		entropy := ulid.Monotonic(rand.New(rand.NewSource(time.Now().UnixNano())), 0)
		e.ID = ulid.MustNew(ulid.Now(), entropy).String()
	}

	return e.ID
}

func (e *EntityBase) GetPublicId() string {
	if e.PublicId == "" {
		e.PublicId = uuid.New().String()
	}

	return e.PublicId
}

func (u *EntityBase) BeforeCreate(tx *gorm.DB) error {
	u.GetId()

	u.DeletedAt = nil
	return nil
}
