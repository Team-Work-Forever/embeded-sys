package config

import "github.com/spf13/viper"

const DotEnv = ".env"

var config *Config

type Config struct {
	GRPC_SERVER_PORT string
	HTTP_SERVER_PORT string

	DB_SQL_PATH string

	JWT_AUDIENCE                  string
	JWT_ISSUER                    string
	JWT_ACCESS_EXPIRED_IN_MINUTES int
	JWT_REFRESH_EXPIRED_IN_HOURS  int

	REDIS_HOST string
	REDIS_PORT string
	REDIS_DB   int
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

		JWT_AUDIENCE:                  viper.GetString("JWT_AUDIENCE"),
		JWT_ISSUER:                    viper.GetString("JWT_ISSUER"),
		JWT_ACCESS_EXPIRED_IN_MINUTES: viper.GetInt("JWT_ACCESS_EXPIRED_IN_MINUTES"),
		JWT_REFRESH_EXPIRED_IN_HOURS:  viper.GetInt("JWT_REFRESH_EXPIRED_IN_HOURS"),

		REDIS_HOST: viper.GetString("REDIS_HOST"),
		REDIS_PORT: viper.GetString("REDIS_PORT"),
		REDIS_DB:   viper.GetInt("REDIS_DB"),
	}
}

func GetCofig() *Config {
	return config
}
