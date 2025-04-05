package pkg

import ()

type (
	Repository[T Entity] interface {
		Create(entity T) error
		Delete(entity T) error
		Update(entity T) error
		Get(id string) (T, error)

		BeginTransaction() (Transaction[Entity], error)
		GetOrm() Orm
	}

	Transaction[T Entity] interface {
		Repository[T]
		Rollback() error
		Commit() error
	}

	TransationBase[T Entity] struct {
		Repository[T]
	}

	RepositoryBase[T Entity] struct {
		Context Orm
	}
)

func NewTransaction[T Entity](repository Repository[T]) Transaction[T] {
	return &TransationBase[T]{
		Repository: repository,
	}
}

func (tran *TransationBase[T]) Rollback() error {
	orm := tran.GetOrm().Statement.Rollback()
	tran.Repository = nil

	return orm.Error
}

func (tran *TransationBase[T]) Commit() error {
	orm := tran.GetOrm().Statement.Commit()
	tran.Repository = nil

	return orm.Error
}

func NewRepositoryBase[T Entity](database Database) *RepositoryBase[T] {
	return &RepositoryBase[T]{
		Context: database.GetOrm(),
	}
}

func (repo *RepositoryBase[T]) BeginTransaction() (Transaction[Entity], error) {
	cloneRepo := &RepositoryBase[Entity]{
		Context: repo.Context.Statement.Begin(),
	}

	return NewTransaction(cloneRepo), nil
}

func (repo *RepositoryBase[T]) GetOrm() Orm {
	return repo.Context
}

func (repo *RepositoryBase[T]) Create(entity T) error {
	if err := repo.Context.Statement.Create(entity).Error; err != nil {
		return err
	}

	return nil
}

func (repo *RepositoryBase[T]) Delete(entity T) error {
	if err := repo.Context.Statement.Delete(entity).Error; err != nil {
		return err
	}

	return nil
}

func (repo *RepositoryBase[T]) Update(entity T) error {
	return repo.Context.Statement.Save(entity).Error
}

func (repo *RepositoryBase[T]) Get(id string) (T, error) {
	var entity T

	if err := repo.Context.Statement.Where("id = ?", id).First(&entity).Error; err != nil {
		return entity, err
	}

	return entity, nil
}
