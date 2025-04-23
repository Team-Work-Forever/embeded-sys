package services

import (
	"context"
	"log"
	"server/internal/domain"
	"server/internal/middlewares"
	"server/internal/repositories"
	"server/internal/services/proto"

	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type (
	ParkSenseServiceImpl struct {
		proto.UnimplementedParkSenseServiceServer

		deviceStore        domain.DeviceStore
		reserveRepo        repositories.IReserveRepository
		reserveHistoryRepo repositories.IReserveHistoryRepository
		authRepo           repositories.IAuthRepository
		parkSenseRepo      repositories.IParkSetRepository
	}
)

func NewParkSenseServiceImpl(deviceStore domain.DeviceStore, reserveRepo repositories.IReserveRepository, reserveHistoryRepo repositories.IReserveHistoryRepository, authRepo repositories.IAuthRepository, parkSenseRepo repositories.IParkSetRepository) *ParkSenseServiceImpl {
	return &ParkSenseServiceImpl{
		deviceStore:        deviceStore,
		reserveRepo:        reserveRepo,
		reserveHistoryRepo: reserveHistoryRepo,
		authRepo:           authRepo,
		parkSenseRepo:      parkSenseRepo,
	}
}

func (s *ParkSenseServiceImpl) RegisterControllers(server *grpc.Server) {
	proto.RegisterParkSenseServiceServer(server, s)
}

func mapToProtoParkSet(parkSet *domain.ParkSet) *proto.ParkSet {
	parkLots := make([]*proto.ParkLot, 0, len(parkSet.Lots))

	for _, parkLot := range parkSet.Lots {
		entry := &proto.ParkLot{
			ParkLotId: parkLot.PublicId,
			State:     proto.LotState(parkLot.State),
			Row:       parkLot.Row,
			Column:    parkLot.Column,
		}
		parkLots = append(parkLots, entry)
	}

	return &proto.ParkSet{
		ParkSetId: parkSet.PublicId,
		Lots:      parkLots,
		State:     proto.ParkState(parkSet.State),
		Timestamp: timestamppb.New(parkSet.CreatedAt),
	}
}

func (park *ParkSenseServiceImpl) StreamIncomingParkLot(request *emptypb.Empty, stream grpc.ServerStreamingServer[proto.ParkSet]) error {
	ch, unsubscrive := park.deviceStore.Subscrive()
	defer unsubscrive()

	log.Println("Stream started")

	ctx := stream.Context()

	for {
		select {
		case <-ctx.Done():
			err := ctx.Err()
			log.Println("Client disconnected:", err)
			return err

		case device, ok := <-ch:
			if !ok {
				log.Println("Channel closed")
				return nil
			}

			log.Println("Send new stuff")
			if err := stream.Send(mapToProtoParkSet(device)); err != nil {
				log.Printf("Error sending update to client: %v", err)
				return err
			}
		}
	}
}

func (s *ParkSenseServiceImpl) CreateReserve(ctx context.Context, req *proto.CreateReserveRequest) (*proto.Reserve, error) {
	if req.SlotId == "" {
		return nil, status.Error(codes.InvalidArgument, "Missing required fields")
	}

	userID, err := middlewares.GetUserIDKey(ctx)

	if err != nil {
		return nil, status.Error(codes.Unauthenticated, "User not authenticated")
	}

	user, err := s.authRepo.GetByPublicId(userID)

	if err != nil {
		return nil, status.Error(codes.NotFound, "User not found")
	}

	parkLot, err := s.parkSenseRepo.GetLotByPublicId(req.SlotId)

	if err != nil {
		return nil, status.Error(codes.NotFound, "Parking slot not found")
	}

	if parkLot.State != domain.Free {
		return nil, status.Error(codes.FailedPrecondition, "Slot is not available for reservation")
	}

	reserve := &domain.Reserve{
		SlotId:    req.SlotId,
		SlotLabel: req.SlotLabel,
		UserId:    user.ID,
		Timestamp: req.Timestamp.AsTime(),
	}

	if err := s.reserveRepo.Create(reserve); err != nil {
		log.Printf("CreateReserve error: %v", err)
		return nil, status.Error(codes.Internal, "Could not create reserve")
	}

	parkLot.State = domain.Reserved

	if err := s.parkSenseRepo.UpdateLot(parkLot); err != nil {
		log.Printf("Failed to update lot state: %v", err)
		return nil, status.Error(codes.Internal, "Could not update parking slot state")
	}

	return &proto.Reserve{
		ReserveId: reserve.PublicId,
		SlotId:    reserve.SlotId,
		SlotLabel: reserve.SlotLabel,
		UserId:    user.PublicId,
		Timestamp: req.Timestamp,
	}, nil
}

func (s *ParkSenseServiceImpl) GetUserActiveReserves(ctx context.Context, req *emptypb.Empty) (*proto.ReserveListResponse, error) {
	userID, err := middlewares.GetUserIDKey(ctx)

	if err != nil {
		return nil, status.Error(codes.Unauthenticated, "User not authenticated")
	}

	user, err := s.authRepo.GetByPublicId(userID)

	if err != nil {
		return nil, status.Error(codes.NotFound, "User not found")
	}

	reserves, err := s.reserveRepo.GetByUserId(user.ID)

	if err != nil {
		return nil, status.Error(codes.Internal, "Could not fetch reserves")
	}

	var list []*proto.Reserve
	for _, r := range reserves {
		list = append(list, &proto.Reserve{
			ReserveId: r.PublicId,
			SlotId:    r.SlotId,
			SlotLabel: r.SlotLabel,
			UserId:    user.PublicId,
			Timestamp: timestamppb.New(r.Timestamp),
		})
	}

	return &proto.ReserveListResponse{Reserves: list}, nil
}

func (s *ParkSenseServiceImpl) GetUserReserveHistory(ctx context.Context, req *emptypb.Empty) (*proto.ReserveHistoryListResponse, error) {
	userID, err := middlewares.GetUserIDKey(ctx)

	if err != nil {
		return nil, status.Error(codes.Unauthenticated, "User not authenticated")
	}

	user, err := s.authRepo.GetByPublicId(userID)

	if err != nil {
		return nil, status.Error(codes.NotFound, "User not found")
	}

	history, err := s.reserveHistoryRepo.GetByUserId(user.ID)
	if err != nil {
		return nil, status.Error(codes.Internal, "Could not fetch reserve history")
	}

	var list []*proto.ReserveHistory
	for _, h := range history {
		list = append(list, &proto.ReserveHistory{
			ReserveHistoryId: h.PublicId,
			SlotId:           h.SlotId,
			SlotLabel:        h.SlotLabel,
			UserId:           user.PublicId,
			TimestampBegin:   timestamppb.New(h.TimestampBegin),
			TimestampEnd:     timestamppb.New(h.TimestampEnd),
		})
	}

	return &proto.ReserveHistoryListResponse{History: list}, nil
}

func (s *ParkSenseServiceImpl) CancelReserve(ctx context.Context, req *proto.CancelReserveRequest) (*emptypb.Empty, error) {
	userID, err := middlewares.GetUserIDKey(ctx)

	if err != nil {
		return nil, status.Error(codes.Unauthenticated, "User not authenticated")
	}

	user, err := s.authRepo.GetByPublicId(userID)

	if err != nil {
		return nil, status.Error(codes.NotFound, "User not found")
	}

	reserve, err := s.reserveRepo.GetByPublicId(req.ReserveId)

	if err != nil {
		return nil, status.Error(codes.NotFound, "Reserve not found")
	}

	parkLot, err := s.parkSenseRepo.GetLotByPublicId(reserve.SlotId)

	if err != nil {
		return nil, status.Error(codes.NotFound, "Parking slot not found")
	}

	parkLot.State = domain.Free

	if err := s.parkSenseRepo.UpdateLot(parkLot); err != nil {
		log.Printf("Failed to update lot state: %v", err)
		return nil, status.Error(codes.Internal, "Could not update parking slot state")
	}

	if err := s.reserveRepo.Delete(reserve); err != nil {
		return nil, status.Error(codes.Internal, "Failed to cancel reservation")
	}

	return &emptypb.Empty{}, nil
}

func (s *ParkSenseServiceImpl) GetAllParkSets(ctx context.Context, _ *emptypb.Empty) (*proto.ParkSetListResponse, error) {
	allSets, err := s.parkSenseRepo.GetAllParkSets()

	if err != nil {
		return nil, status.Error(codes.Internal, "Failed to fetch park sets")
	}

	var protoSets []*proto.ParkSet

	for _, ps := range allSets {
		protoSets = append(protoSets, mapToProtoParkSet(ps))
	}

	return &proto.ParkSetListResponse{
		ParkSets: protoSets,
	}, nil
}
