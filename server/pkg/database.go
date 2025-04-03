package pkg

import "gorm.io/gorm"

type Orm *gorm.DB

type Database interface {
	GetConnectionString() string
	Close()
	GetOrm() Orm
}
