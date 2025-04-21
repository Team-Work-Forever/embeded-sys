package middlewares

import (
	"context"
	"errors"
	"fmt"
	"server/pkg/helpers"
	"strings"

	"github.com/golang-jwt/jwt/v5"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
)

const (
	AuthHeader string = "authorization"
)

type contextKey string

const UserIDKey = contextKey("userId")

type (
	AuthMiddleware struct {
		tokenService helpers.ITokenHelper
	}

	authServerStream struct {
		grpc.ServerStream
		ctx context.Context
	}
)

func NewAuthMiddleware(
	token helpers.ITokenHelper,
) *AuthMiddleware {
	return &AuthMiddleware{
		tokenService: token,
	}
}

func (w *authServerStream) Context() context.Context {
	return w.ctx
}

func getClaims(tokenString string) (*helpers.AuthClaims, *jwt.Token, error) {
	claims := &helpers.AuthClaims{}
	keyFunc := func(token *jwt.Token) (any, error) {

		if token.Method.Alg() != jwt.SigningMethodRS256.Alg() {
			return nil, fmt.Errorf("unexpected signing method")
		}

		return helpers.PubKey, nil
	}

	token, err := jwt.ParseWithClaims(tokenString, claims, keyFunc)

	if err != nil {
		return nil, nil, fmt.Errorf("invalid token: %w", err)
	}

	return claims, token, nil
}

// validate token and stuff
func (middleware *AuthMiddleware) validateToken(stream grpc.ServerStream, token string) (*authServerStream, error) {
	claims, jwtToken, err := getClaims(token)

	if err != nil {
		return nil, status.Error(codes.Unauthenticated, "Invalid token")
	}

	if err := middleware.tokenService.ValidateToken(claims.Subject, jwtToken.Raw, helpers.AccessTokenKey); err != nil {
		return nil, status.Error(codes.Unauthenticated, "Invalid token")
	}

	return &authServerStream{
		ServerStream: stream,
		ctx: context.WithValue(
			stream.Context(),
			UserIDKey,
			claims.Subject,
		),
	}, nil
}

func (middleware *AuthMiddleware) StreamHandler(
	srv any,
	stream grpc.ServerStream,
	info *grpc.StreamServerInfo,
	handler grpc.StreamHandler,
) error {
	md, ok := metadata.FromIncomingContext(stream.Context())

	if !ok {
		return status.Error(codes.Unauthenticated, "Missing metadata")
	}

	authHeader := md[AuthHeader]

	if len(authHeader) == 0 {
		return status.Error(codes.Unauthenticated, "Authorization token not provided")
	}

	token := strings.TrimPrefix(authHeader[0], "Bearer ")
	serverStream, err := middleware.validateToken(stream, token)

	if err != nil {
		return err
	}

	return handler(srv, serverStream)
}

func (middleware *AuthMiddleware) UnaryHandler(
	ctx context.Context,
	req any,
	info *grpc.UnaryServerInfo,
	handler grpc.UnaryHandler,
) (any, error) {
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "Missing metadata")
	}

	authHeader := md[AuthHeader]
	if len(authHeader) == 0 {
		return nil, status.Error(codes.Unauthenticated, "Authorization token not provided")
	}

	token := strings.TrimPrefix(authHeader[0], "Bearer ")

	claims, jwtToken, err := getClaims(token)
	if err != nil {
		return nil, status.Error(codes.Unauthenticated, "Invalid token")
	}

	if err := middleware.tokenService.ValidateToken(claims.Subject, jwtToken.Raw, helpers.AccessTokenKey); err != nil {
		return nil, status.Error(codes.Unauthenticated, "Invalid token")
	}

	ctx = context.WithValue(ctx, UserIDKey, claims.Subject)

	return handler(ctx, req)
}

func ConditionalUnaryInterceptor(
	interceptor grpc.UnaryServerInterceptor,
	condition func(ctx context.Context, info *grpc.UnaryServerInfo) bool,
) grpc.UnaryServerInterceptor {
	return func(ctx context.Context, req any, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (any, error) {
		if condition(ctx, info) {
			return interceptor(ctx, req, info, handler)
		}
		return handler(ctx, req)
	}
}

func GetUserIDKey(ctx context.Context) (string, error) {

	if userID, ok := ctx.Value(UserIDKey).(string); ok {
		return userID, nil
	}

	return "", errors.New("user_id not provided")
}
