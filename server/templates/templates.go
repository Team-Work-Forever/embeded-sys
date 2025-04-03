package templates

import "embed"

//go:embed *.html
var FileStream embed.FS

func GetTemplateDir() string {
	return "."
}
