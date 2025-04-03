package config

import "github.com/spf13/viper"

const DotEnv = ".env"

var config *Config

type Config struct {
	GRPC_SERVER_PORT string
	HTTP_SERVER_PORT string

	DB_SQL_PATH string
}

func LoadEnv(path string) {
	viper.SetConfigName(path)
	viper.SetConfigType("env")
	viper.AddConfigPath(".")
	viper.AutomaticEnv()

	if err := viper.ReadInConfig(); err != nil {
		viper.Reset()
		viper.AutomaticEnv()
	}

	config = &Config{
		GRPC_SERVER_PORT: viper.GetString("GRPC_SERVER_PORT"),
		HTTP_SERVER_PORT: viper.GetString("HTTP_SERVER_PORT"),

		DB_SQL_PATH: viper.GetString("DB_SQL_PATH"),
	}
}

func GetCofig() *Config {
	return config
}
