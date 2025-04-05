package pkg

import (
	"strings"
	"time"
)

const Delimiter = ":"

type (
	Redis interface {
		GetValue(key RedisKey) (string, error)
		SetValue(key RedisKey, value any, expiration time.Duration) error
		GetAndDelValue(key RedisKey) (string, error)
		Close() error
	}

	RedisKey struct {
		Values []string
		Key    string
	}
)

func NewRedisKey(values ...string) RedisKey {
	var key strings.Builder

	for i := range values {
		key.WriteString(values[i])

		if i < len(values)-1 {
			key.WriteString(Delimiter)
		}
	}

	return RedisKey{
		Key:    key.String(),
		Values: values,
	}
}
