import 'package:mobile/services/proto/auth.pbgrpc.dart';

abstract class AuthService {
  Future<AuthResponse> login(String licensePlate, String mac);
  Future<RegisterResponse> register(String licensePlate);
}
