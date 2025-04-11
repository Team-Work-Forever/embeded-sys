import 'package:mobile/core/models/user.dart';

abstract class AuthProvider {
  Future checkAuth();
  Future login(String licensePlate);
  Future register(String licensePlate);
  Future logout();

  Future<String> getAccessToken();

  bool get isAuthenticated;
  Future<bool> get canAuthenticate;
  AppUser get getMetadata;
}
