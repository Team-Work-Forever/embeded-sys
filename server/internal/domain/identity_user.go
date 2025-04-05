package domain

import (
	"server/pkg"

	"gorm.io/gorm"
)

type IdentityUser struct {
	pkg.EntityBase
	LicencePlate string
	SecretKey    string
}

func NewIdentityUser(licencePlate, secretKey string) *IdentityUser {
	return &IdentityUser{
		LicencePlate: licencePlate,
		SecretKey:    secretKey,
	}
}

func (b *IdentityUser) TableName() string {
	return "auths"
}

func (u *IdentityUser) BeforeCreate(tx *gorm.DB) error {
	u.GetId()

	u.DeletedAt = nil
	return nil
}
