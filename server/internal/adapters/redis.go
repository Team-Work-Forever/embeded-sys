package adapters

import (
	"context"
	"fmt"
	"server/config"
	"server/pkg"
	"time"

	"github.com/redis/go-redis/v9"
)

var redisConnection *RedisConnection

type RedisConnection struct {
	client *redis.Client
	ctx    context.Context
}

func GetRedis() *RedisConnection {
	if redisConnection == nil {
		redisConnection = newRedisConnection()
	}

	return redisConnection
}

func newRedisConnection() *RedisConnection {
	config := config.GetCofig()

	return &RedisConnection{
		client: redis.NewClient(&redis.Options{
			Addr: fmt.Sprintf("%s:%s", config.REDIS_HOST, config.REDIS_PORT),
			DB:   config.REDIS_DB,
		}),
		ctx: context.Background(),
	}
}

func (r *RedisConnection) GetValue(key pkg.RedisKey) (string, error) {
	return r.client.Get(r.ctx, key.Key).Result()
}

func (r *RedisConnection) SetValue(key pkg.RedisKey, value any, expiration time.Duration) error {
	return r.client.Set(r.ctx, key.Key, value, expiration).Err()
}

func (r *RedisConnection) GetAndDelValue(key pkg.RedisKey) (string, error) {
	return r.client.GetDel(r.ctx, key.Key).Result()
}

func (r *RedisConnection) Close() error {
	return r.client.Close()
}
