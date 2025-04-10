import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/services/base_service.dart';
import 'package:mobile/services/parksense/park_sense_service.dart';
import 'package:mobile/services/proto/google/protobuf/empty.pb.dart';
import 'package:mobile/services/proto/parksense.pbgrpc.dart';

final class ParkSenseServiceImpl extends BaseService<ParkSenseServiceClient>
    implements ParkSenseService {
  final AuthProvider _authProvider;

  ParkSenseServiceImpl(super.apiClient, this._authProvider);

  @override
  Stream<ParkSet> streamIncomingParkLot() async* {
    var accessToken = await _authProvider.getAccessToken();

    yield* client.streamIncomingParkLot(
      Empty(),
      options: CallOptions(metadata: {"authorization": accessToken}),
    );
  }
}
