package repositories

import (
	"server/internal/domain"
	"server/pkg"
)

type (
	ReserveHistoryRepository struct {
		pkg.RepositoryBase[*domain.ReserveHistory]
	}

	IReserveHistoryRepository interface {
		pkg.Repository[*domain.ReserveHistory]

		GetByPublicId(publicId string) (*domain.ReserveHistory, error)
		GetByUserId(userId string) ([]*domain.ReserveHistory, error)
	}
)

func NewReserveHistoryRepository(database pkg.Database) *ReserveHistoryRepository {
	return &ReserveHistoryRepository{
		RepositoryBase: *pkg.NewRepositoryBase[*domain.ReserveHistory](database),
	}
}

func (rr *ReserveHistoryRepository) GetByPublicId(publicId string) (*domain.ReserveHistory, error) {
	var reserve *domain.ReserveHistory

	if err := rr.Context.Statement.Where("public_id = ?", publicId).First(&reserve).Error; err != nil {
		return nil, err
	}

	return reserve, nil
}

func (rr *ReserveHistoryRepository) GetByUserId(userId string) ([]*domain.ReserveHistory, error) {
	var reserves []*domain.ReserveHistory

	if err := rr.Context.Statement.Where("user_id = ?", userId).Find(&reserves).Error; err != nil {
		return nil, err
	}

	return reserves, nil
}
