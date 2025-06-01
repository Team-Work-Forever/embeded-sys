package repositories

import (
	"server/internal/domain"
	"server/pkg"

	"gorm.io/gorm"
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
		UpdateLotState(publicId string, state domain.ParkLotState) error
		GetByMAC(mac string) (*domain.ParkSet, error)
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

func (pr *ParkSetRepository) UpdateLotState(publicId string, state domain.ParkLotState) error {
	db := (*gorm.DB)(pr.Context)
	return db.Model(&domain.ParkLot{}).
		Where("public_id = ?", publicId).
		Update("state", state).Error
}

func (pr *ParkSetRepository) GetByMAC(mac string) (*domain.ParkSet, error) {
	var parkSet domain.ParkSet
	err := pr.Context.Statement.Where("mac_address = ?", mac).First(&parkSet).Error
	if err != nil {
		return nil, err
	}
	return &parkSet, nil
}
