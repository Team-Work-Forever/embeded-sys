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
		GetByLicense(plate string) (*domain.IdentityUser, error)
		GetByPublicId(publicId string) (*domain.IdentityUser, error)
	}
)

func NewAuthRepository(database pkg.Database) *AuthRepository {
	return &AuthRepository{
		RepositoryBase: *pkg.NewRepositoryBase[*domain.IdentityUser](database),
	}
}

func (ar *AuthRepository) ExistsLicensePlate(plate string) bool {
	return ar.Context.Statement.Where("license_plate = ?", plate).First(&domain.IdentityUser{}).Error == nil
}

func (ar *AuthRepository) GetByLicense(plate string) (*domain.IdentityUser, error) {
	var identityUser *domain.IdentityUser

	if err := ar.Context.Statement.Where("license_plate = ?", plate).First(&identityUser).Error; err != nil {
		return nil, err
	}

	return identityUser, nil
}

func (ar *AuthRepository) GetByPublicId(publicKey string) (*domain.IdentityUser, error) {
	var identityUser *domain.IdentityUser

	if err := ar.Context.Statement.Where("public_id = ?", publicKey).First(&identityUser).Error; err != nil {
		return nil, err
	}

	return identityUser, nil
}
