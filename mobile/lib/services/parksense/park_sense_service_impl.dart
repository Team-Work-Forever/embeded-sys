import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/services/base_service.dart';
import 'package:mobile/services/parksense/park_sense_service.dart';
import 'package:mobile/services/proto/google/protobuf/empty.pb.dart';
import 'package:mobile/services/proto/parksense.pb.dart';
import 'package:mobile/services/proto/parksense.pbgrpc.dart';

final class ParkSenseServiceImpl extends BaseService<ParkSenseServiceClient>
    implements ParkSenseService {
  final AuthProvider _authProvider;

  ParkSenseServiceImpl(super.apiClient, this._authProvider);

  Future<CallOptions> _withAuth() async {
    final accessToken = await _authProvider.getAccessToken();
    return CallOptions(metadata: {'authorization': '$accessToken'});
  }

  @override
  Stream<ParkSet> streamIncomingParkLot() async* {
    final options = await _withAuth();
    yield* client.streamIncomingParkLot(Empty(), options: options);
  }

  @override
  Future<ParkSetListResponse> getAllParkSets() async {
    final options = await _withAuth();
    return client.getAllParkSets(Empty(), options: options);
  }

  @override
  Future<Reserve> createReserve(CreateReserveRequest request) async {
    final options = await _withAuth();
    return client.createReserve(request, options: options);
  }

  @override
  Future<ReserveListResponse> getUserActiveReserves() async {
    final options = await _withAuth();
    return client.getUserActiveReserves(Empty(), options: options);
  }

  @override
  Future<ReserveHistoryListResponse> getUserReserveHistory() async {
    final options = await _withAuth();
    return client.getUserReserveHistory(Empty(), options: options);
  }

  @override
  Future<Empty> cancelReserve(CancelReserveRequest request) async {
    final options = await _withAuth();
    return client.cancelReserve(request, options: options);
  }
}
