package services

import (
	"log"
	"server/internal/domain"
	"server/internal/services/proto"
	"sync"

	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type (
	ParkSenseServiceImpl struct {
		proto.UnimplementedParkSenseServiceServer

		parkLots []chan *proto.ParkSet
		mu       sync.Mutex
	}
)

func NewParkSenseServiceImpl() *ParkSenseServiceImpl {
	return &ParkSenseServiceImpl{}
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

func (park *ParkSenseServiceImpl) RegisterModule(parkSet *domain.ParkSet) {
	park.mu.Lock()
	defer park.mu.Unlock()

	for _, ch := range park.parkLots {
		ch <- mapToProtoParkSet(parkSet)
	}
}

func (park *ParkSenseServiceImpl) StreamIncomingParkLot(request *emptypb.Empty, stream grpc.ServerStreamingServer[proto.ParkSet]) error {
	ch := make(chan *proto.ParkSet, 1)

	park.mu.Lock()
	park.parkLots = append(park.parkLots, ch)
	park.mu.Unlock()

	log.Println("Stream started")

	ctx := stream.Context()

	defer func() {
		log.Println("Cleaning up stream...")

		park.mu.Lock()
		var updated []chan *proto.ParkSet
		for _, c := range park.parkLots {
			if c != ch {
				updated = append(updated, c)
			}
		}

		park.parkLots = updated
		park.mu.Unlock()
	}()

	for {
		select {
		case <-ctx.Done():
			err := ctx.Err()
			log.Println("Client disconnected:", err)
			return err
		case update := <-ch:
			log.Println("Send new stuff")

			if err := stream.Send(update); err != nil {
				log.Printf("Error sending update to client: %v", err)
				return err
			}
		}
	}
}
