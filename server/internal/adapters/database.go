package adapters

import (
	"server/config"
	"server/pkg"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var gormDatabase *GormDatabase

type GormDatabase struct {
	conn *gorm.DB
}

func (gdc *GormDatabase) GetConnectionString() string {
	return getConnectionString()
}

func (gdc *GormDatabase) GetOrm() pkg.Orm {
	return gdc.conn
}

func (gdc *GormDatabase) Close() {
}

func newDatabaseGorm(connectionString string) (*GormDatabase, error) {
	db, err := gorm.Open(sqlite.Open(connectionString), &gorm.Config{})

	if err != nil {
		return nil, err
	}

	return &GormDatabase{
		conn: db,
	}, nil
}

func getConnectionString() string {
	return config.GetCofig().DB_SQL_PATH
}

func GetDatabaseWithConnectionString(connectionString string) pkg.Database {
	var err error

	if gormDatabase == nil {
		gormDatabase, err = newDatabaseGorm(connectionString)

		if err != nil {
			panic(err)
		}
	}

	return gormDatabase
}

func GetDatabase() pkg.Database {
	connectionString := getConnectionString()

	if err := config.Migrate(connectionString, false); err != nil {
		panic(err)
	}

	return GetDatabaseWithConnectionString(connectionString)
}
