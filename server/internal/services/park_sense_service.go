package services

import (
	"log"
	"server/internal/domain"
	"server/internal/services/proto"

	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type (
	ParkSenseServiceImpl struct {
		proto.UnimplementedParkSenseServiceServer

		deviceStore domain.DeviceStore
	}
)

func NewParkSenseServiceImpl(deviceStore domain.DeviceStore) *ParkSenseServiceImpl {
	return &ParkSenseServiceImpl{
		deviceStore: deviceStore,
	}
}

func (s *ParkSenseServiceImpl) RegisterControllers(server *grpc.Server) {
	proto.RegisterParkSenseServiceServer(server, s)
}

func mapToProtoParkSet(parkSet *domain.ParkSet) *proto.ParkSet {
	parkLots := make([]*proto.ParkLot, 0, len(parkSet.Lots))

	for _, parkLot := range parkSet.Lots {
		entry := &proto.ParkLot{
			ParkLotId: parkLot.Id,
			State:     proto.LotState(parkLot.State),
			Row:       parkLot.Row,
			Column:    parkLot.Column,
		}
		parkLots = append(parkLots, entry)
	}

	return &proto.ParkSet{
		ParkSetId: parkSet.Id,
		Lots:      parkLots,
		State:     proto.ParkState(parkSet.State),
		Timestamp: timestamppb.New(parkSet.Timestamp),
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
