import 'package:mobile/services/auth_service.dart';
import 'package:mobile/services/base_service.dart';
import 'package:mobile/services/proto/auth.pbgrpc.dart';

class AuthServiceImpl extends BaseService<AuthServiceClient>
    implements AuthService {
  AuthServiceImpl(super.apiClient);

  @override
  Future<AuthResponse> login(String licensePlate, String mac) async {
    return await client.login(
      LoginEntryRequest(carPlate: licensePlate, mAC: mac),
    );
  }

  @override
  Future<RegisterResponse> register(String licensePlate) async {
    return await client.register(RegisterEntryRequest(carPlate: licensePlate));
  }
}
