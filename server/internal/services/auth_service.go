package services

import (
	"context"
	"log"
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

	if as.authRepo.ExistsLicensePlate(request.CarPlate) {
		return nil, status.Error(codes.AlreadyExists, "License Plate already registered, speak with the manager of the park")
	}

	mac64, secret64, err := helpers.CreateSecrets(request.CarPlate)

	if err != nil {
		return nil, status.Error(codes.Aborted, "An error occorred while creating this account.")
	}

	identityUser := domain.NewIdentityUser(request.CarPlate, secret64)

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
		MAC:          mac64,
	}, nil
}

func (as *AuthServiceImpl) Login(context context.Context, request *proto.LoginEntryRequest) (*proto.AuthResponse, error) {
	if !validateLicensePlate(request.CarPlate) {
		return nil, status.Errorf(codes.InvalidArgument, "Invalid license place format: %s", request.CarPlate)
	}

	if !as.authRepo.ExistsLicensePlate(request.CarPlate) {
		return nil, status.Errorf(codes.NotFound, "The license Plate %s was not found", request.CarPlate)
	}

	foundUser, err := as.authRepo.GetByLicense(request.CarPlate)

	if err != nil {
		return nil, status.Error(codes.Aborted, "An error occorred while validating this account.")
	}

	// check secret
	if !helpers.CheckSecrets(request.CarPlate, foundUser.SecretKey, request.MAC) {
		return nil, status.Error(codes.Aborted, "An error occorred while validating this account.")
	}

	accessToken, refreshToken, err := as.tokenHelper.CreateAuthenticationTokens(helpers.TokenPayload{
		Id:           foundUser.PublicId,
		LicensePlate: request.CarPlate,
	})

	if err != nil {
		return nil, status.Error(codes.Canceled, "An error occorred while generating access keys, please try again later... ")
	}

	return &proto.AuthResponse{
		AccessToken:  accessToken.Token,
		RefreshToken: refreshToken.Token,
	}, nil
}

func (as *AuthServiceImpl) RefreshTokens(context context.Context, request *proto.RefreshtTokensRequest) (*proto.AuthResponse, error) {
	claims := &helpers.AuthClaims{}

	if err := helpers.GetClaims(request.RefreshToken, claims); err != nil {
		log.Printf("Error while getting claims: %s\n", err.Error())
		return nil, status.Error(codes.Aborted, "Invalid token")
	}

	if err := as.tokenHelper.ValidateToken(claims.Subject, request.RefreshToken, helpers.RefreshTokenKey); err != nil {
		log.Println("Error validating token")
		return nil, status.Error(codes.Aborted, "Invalid token")
	}

	foundIdentityUser, err := as.authRepo.GetByPublicId(claims.Subject)

	if err != nil {
		return nil, status.Error(codes.NotFound, "User doesn't exist")
	}

	accessToken, refreshToken, err := as.tokenHelper.CreateAuthenticationTokens(helpers.TokenPayload{
		Id:           foundIdentityUser.PublicId,
		LicensePlate: foundIdentityUser.LicensePlate,
	})

	if err != nil {
		return nil, status.Error(codes.Canceled, "An error occorred while generating access keys, please try again later... ")
	}

	return &proto.AuthResponse{
		AccessToken:  accessToken.Token,
		RefreshToken: refreshToken.Token,
	}, nil
}
