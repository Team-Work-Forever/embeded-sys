package helpers

import (
	"server/config"
	"server/pkg"
	"time"
)

type (
	TokenKey string

	ITokenHelper interface {
		CreateAuthenticationTokens(payload TokenPayload) (*JwtToken, *JwtToken, error)
		ValidateToken(authId, token string, key TokenKey) error
	}

	TokenHelper struct {
		redis pkg.Redis
	}
)

const (
	AccessTokenKey  TokenKey = "access"
	RefreshTokenKey TokenKey = "refresh"
)

func NewTokenService(redis pkg.Redis) *TokenHelper {
	return &TokenHelper{
		redis: redis,
	}
}

func NewAccessTokenKey(userId string) pkg.RedisKey {
	return pkg.NewRedisKey(userId, string(AccessTokenKey))
}

func NewRefreshTokenKey(userId string) pkg.RedisKey {
	return pkg.NewRedisKey(userId, string(RefreshTokenKey))
}

func generateAuthenticationTokens(payload TokenPayload, accessTokenExp, refreshTokenExp time.Duration) (*JwtToken, *JwtToken, error) {
	payload.Duration = time.Now().Add(accessTokenExp)
	payload.Type = Access

	accessToken, err := CreateJwtToken(payload)

	if err != nil {
		return nil, nil, err
	}

	payload.Duration = time.Now().Add(refreshTokenExp)
	payload.Type = Refresh

	refreshToken, err := CreateJwtToken(payload)

	if err != nil {
		return nil, nil, err
	}

	return accessToken, refreshToken, nil
}

func (ts *TokenHelper) ValidateToken(authId, token string, key TokenKey) error {
	var tokenKey pkg.RedisKey

	switch key {
	case AccessTokenKey:
		tokenKey = NewAccessTokenKey(authId)
	case RefreshTokenKey:
		tokenKey = NewRefreshTokenKey(authId)
	default:
		return ErrInvalidToken
	}

	storedToken, err := ts.redis.GetValue(tokenKey)

	if err != nil {
		return err
	}

	if storedToken != token {
		return ErrInvalidToken
	}

	return nil
}

func (ts *TokenHelper) CreateAuthenticationTokens(payload TokenPayload) (*JwtToken, *JwtToken, error) {
	env := config.GetCofig()

	accessTokenExp := time.Duration(env.JWT_ACCESS_EXPIRED_IN_MINUTES) * time.Minute         // per minute
	refreshTokenExp := time.Duration(env.JWT_REFRESH_EXPIRED_IN_HOURS) * time.Hour * 24 * 30 // per month

	accessToken, refreshToken, err := generateAuthenticationTokens(payload, accessTokenExp, refreshTokenExp)

	if err != nil {
		return nil, nil, err
	}

	ts.redis.GetAndDelValue(NewAccessTokenKey(payload.Id))
	ts.redis.GetAndDelValue(NewRefreshTokenKey(payload.Id))

	if err := ts.redis.SetValue(NewAccessTokenKey(payload.Id), accessToken.Token, accessTokenExp); err != nil {
		return nil, nil, ErrCreatingToken
	}

	if err := ts.redis.SetValue(NewRefreshTokenKey(payload.Id), refreshToken.Token, refreshTokenExp); err != nil {
		return nil, nil, ErrCreatingToken
	}

	return accessToken, refreshToken, nil
}
