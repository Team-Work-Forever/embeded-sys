import 'package:mobile/core/models/user.dart';

abstract class AuthProvider {
  Future login(String licensePlate);
  Future register(String licensePlate);
  Future logout();

  bool get isAuthenticated;
  AppUser get getMetadata;
}
