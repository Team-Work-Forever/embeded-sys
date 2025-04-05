package repositories

import (
	"server/internal/domain"
	"server/pkg"
)

type (
	AuthRepository struct {
		pkg.RepositoryBase[*domain.IdentityUser]
	}

	IAuthRepository interface {
		pkg.Repository[*domain.IdentityUser]

		ExistsLicensePlate(plate string) bool
	}
)

func NewAuthRepository(database pkg.Database) *AuthRepository {
	return &AuthRepository{
		RepositoryBase: *pkg.NewRepositoryBase[*domain.IdentityUser](database),
	}
}

func (ar *AuthRepository) ExistsLicensePlate(plate string) bool {
	return ar.Context.Statement.Where("licence_plate = ?", plate).First(&domain.IdentityUser{}).Error != nil
}
