package repositories

import (
	"server/internal/domain"
	"server/pkg"
)

type (
	ReserveRepository struct {
		pkg.RepositoryBase[*domain.Reserve]
	}

	IReserveRepository interface {
		pkg.Repository[*domain.Reserve]

		GetByPublicId(publicId string) (*domain.Reserve, error)
		GetByPublicSlotId(slotId string) (*domain.Reserve, error)
		GetByUserId(userId string) ([]*domain.Reserve, error)
	}
)

func NewReserveRepository(database pkg.Database) *ReserveRepository {
	return &ReserveRepository{
		RepositoryBase: *pkg.NewRepositoryBase[*domain.Reserve](database),
	}
}

func (rr *ReserveRepository) GetByPublicId(publicId string) (*domain.Reserve, error) {
	var reserve *domain.Reserve

	if err := rr.Context.Statement.Where("public_id = ?", publicId).First(&reserve).Error; err != nil {
		return nil, err
	}

	return reserve, nil
}

func (rr *ReserveRepository) GetByPublicSlotId(slotId string) (*domain.Reserve, error) {
	var reserve *domain.Reserve

	if err := rr.Context.Statement.Where("slot_id = ?", slotId).First(&reserve).Error; err != nil {
		return nil, err
	}

	return reserve, nil
}

func (rr *ReserveRepository) GetByUserId(userId string) ([]*domain.Reserve, error) {
	var reserves []*domain.Reserve

	if err := rr.Context.Statement.Where("user_id = ?", userId).Find(&reserves).Error; err != nil {
		return nil, err
	}

	return reserves, nil
}
