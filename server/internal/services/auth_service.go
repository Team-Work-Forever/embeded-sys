package services

import (
	"context"
	"encoding/base64"
	"regexp"
	"server/internal/domain"
	"server/internal/repositories"
	"server/internal/services/proto"
	"server/pkg/helpers"

	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type (
	AuthServiceImpl struct {
		proto.UnimplementedAuthServiceServer

		authRepo    repositories.IAuthRepository
		tokenHelper helpers.ITokenHelper
	}
)

func NewAuthServiceImpl(
	authRepo repositories.IAuthRepository,
	tokenHelper helpers.ITokenHelper,
) *AuthServiceImpl {
	return &AuthServiceImpl{
		authRepo:    authRepo,
		tokenHelper: tokenHelper,
	}
}

func (s *AuthServiceImpl) RegisterControllers(server *grpc.Server) {
	proto.RegisterAuthServiceServer(server, s)
}

// middleware to check lincese place
func validateLicensePlate(plate string) bool {
	pattern := `^(([A-Z]{2}-\d{2}-(\d{2}|[A-Z]{2}))|(\d{2}-(\d{2}-[A-Z]{2}|[A-Z]{2}-\d{2})))$`

	re := regexp.MustCompile(pattern)
	return re.MatchString(plate)
}

func (as *AuthServiceImpl) Register(context context.Context, request *proto.RegisterEntryRequest) (*proto.RegisterResponse, error) {
	if !validateLicensePlate(request.CarPlate) {
		return nil, status.Errorf(codes.InvalidArgument, "Invalid license place format: %s", request.CarPlate)
	}

	if !as.authRepo.ExistsLicensePlate(request.CarPlate) {
		return nil, status.Error(codes.AlreadyExists, "License Plate already registered, speak with the manager of the park")
	}

	secretKey, err := helpers.GenerateSecretKey()

	if err != nil {
		return nil, status.Error(codes.Aborted, "An error occorred while creating this account.")
	}

	mac := helpers.GenerateMAC(secretKey, request.CarPlate)

	secretKey, err = helpers.EncryptPK(secretKey)

	if err != nil {
		return nil, status.Error(codes.Aborted, "An error occorred while creating this account.")
	}

	identityUser := domain.NewIdentityUser(request.CarPlate, string(secretKey))

	if err := as.authRepo.Create(identityUser); err != nil {
		return nil, status.Error(codes.Aborted, "An error occorred while creating this account.")
	}

	accessToken, refreshToken, err := as.tokenHelper.CreateAuthenticationTokens(helpers.TokenPayload{
		Id:           identityUser.PublicId,
		LicensePlate: request.CarPlate,
	})

	if err != nil {
		return nil, status.Error(codes.Canceled, "An error occorred while generating access keys, please try again later... ")
	}

	return &proto.RegisterResponse{
		AccessToken:  accessToken.Token,
		RefreshToken: refreshToken.Token,
		MAC:          base64.StdEncoding.EncodeToString(mac),
	}, nil
}

func (as *AuthServiceImpl) Login(context.Context, *proto.LoginEntryRequest) (*proto.AuthResponse, error) {
	return nil, nil
}
