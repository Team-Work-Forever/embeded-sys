package migrations

import "embed"

//go:embed *.sql
var FileStream embed.FS

func GetMigrationsDir() string {
	return "."
}
