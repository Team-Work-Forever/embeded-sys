import 'package:mobile/services/proto/google/protobuf/empty.pb.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

abstract class ParkSenseService {
  Stream<ParkSet> streamIncomingParkLot();
  Future<ParkSetListResponse> getAllParkSets();
  Future<Reserve> createReserve(CreateReserveRequest request);
  Future<ReserveListResponse> getUserActiveReserves();
  Future<ReserveHistoryListResponse> getUserReserveHistory();
  Future<Empty> cancelReserve(CancelReserveRequest request);
}
