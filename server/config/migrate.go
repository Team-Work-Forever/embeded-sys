package config

import (
	"database/sql"
	"errors"
	"path"
	"path/filepath"
	"runtime"
	"server/migrations"

	"github.com/pressly/goose/v3"
)

var (
	ErrFileNotRunning = errors.New("file is not running")
	ErrConnectToDb    = errors.New("failed to connect to the database")
	ErrFailToMigrate  = errors.New("fail to apply migrations")
)

func GetProjectRoot() (string, error) {
	_, filename, _, ok := runtime.Caller(0)

	if !ok {
		return "", ErrFileNotRunning
	}

	absPath, err := filepath.Abs(filename)

	if err != nil {
		return "", err
	}

	return path.Dir(path.Dir(absPath)), nil
}

func Migrate(connectionString string, verbose bool) error {
	db, err := sql.Open("sqlite3", connectionString)

	if err != nil {
		return ErrConnectToDb
	}

	defer db.Close()

	goose.SetBaseFS(migrations.FileStream)
	goose.SetVerbose(verbose)

	if err := goose.SetDialect("sqlite3"); err != nil {
		return err
	}

	if err := goose.Up(db, migrations.GetMigrationsDir()); err != nil {
		return ErrFailToMigrate
	}

	return nil
}
