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
	}
)

func NewAuthRepository(database pkg.Database) *AuthRepository {
	return &AuthRepository{
		RepositoryBase: *pkg.NewRepositoryBase[*domain.IdentityUser](database),
	}
}
