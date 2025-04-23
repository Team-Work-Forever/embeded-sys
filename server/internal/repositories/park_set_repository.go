package repositories

import (
	"server/internal/domain"
	"server/pkg"
)

type (
	ParkSetRepository struct {
		pkg.RepositoryBase[*domain.ParkSet]
	}

	IParkSetRepository interface {
		pkg.Repository[*domain.ParkSet]

		GetAllParkSets() ([]*domain.ParkSet, error)
		GetLotByPublicId(publicId string) (*domain.ParkLot, error)
		UpdateLot(lot *domain.ParkLot) error
	}
)

func NewParkSetRepository(database pkg.Database) *ParkSetRepository {
	return &ParkSetRepository{
		RepositoryBase: *pkg.NewRepositoryBase[*domain.ParkSet](database),
	}
}

func (pr *ParkSetRepository) GetAllParkSets() ([]*domain.ParkSet, error) {
	var parkSets []*domain.ParkSet

	if err := pr.Context.Statement.Preload("Lots").Find(&parkSets).Error; err != nil {
		return nil, err
	}

	return parkSets, nil
}

func (pr *ParkSetRepository) GetLotByPublicId(publicId string) (*domain.ParkLot, error) {
	var lot domain.ParkLot
	if err := pr.Context.Statement.Where("public_id = ?", publicId).First(&lot).Error; err != nil {
		return nil, err
	}
	return &lot, nil
}

func (pr *ParkSetRepository) UpdateLot(lot *domain.ParkLot) error {
	return pr.Context.Statement.Save(lot).Error
}
