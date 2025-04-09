import 'package:mobile/services/base_service.dart';
import 'package:mobile/services/parksense/park_sense_service.dart';
import 'package:mobile/services/proto/google/protobuf/empty.pb.dart';
import 'package:mobile/services/proto/parksense.pbgrpc.dart';

final class ParkSenseServiceImpl extends BaseService<ParkSenseServiceClient>
    implements ParkSenseService {
  ParkSenseServiceImpl(super.apiClient);

  @override
  Stream<ParkSet> streamIncomingParkLot() {
    return client.streamIncomingParkLot(Empty());
  }
}
