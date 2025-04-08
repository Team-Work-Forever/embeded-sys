import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/core/errors/not_authenticated_error.dart';
import 'package:mobile/core/helpers/secret_manager/secret_manager.dart';
import 'package:mobile/core/models/token.dart';
import 'package:mobile/core/models/user.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/view_model.dart';
import 'package:mobile/services/auth_service.dart';

final class AuthProviderImpl extends ViewModel implements AuthProvider {
  final AuthService _authService;
  final SecretManager _secretManager;
  late AppUser? _identityUser;

  AuthProviderImpl(this._authService, this._secretManager)
    : _identityUser = null;

  @override
  get isAuthenticated => _identityUser != null;

  @override
  get getMetadata =>
      isAuthenticated ? _identityUser! : throw NotAuthenticatedError();

  Future<bool> authenticate(String accessToken, String refreshToken) async {
    var claims = JwtDecoder.tryDecode(accessToken);

    if (claims == null) {
      return false;
    }

    _identityUser = AppUser(licensePlate: claims["license_plate"]);

    await _secretManager.store(Token.accessToken, Token(accessToken));
    await _secretManager.store(Token.refreshToken, Token(refreshToken));

    notifyListeners();
    return true;
  }

  @override
  Future login(String licensePlate) async {
    await _authService.login(licensePlate);
  }

  @override
  Future register(String licensePlate) async {
    var tokens = await _authService.register(licensePlate);

    if (!await authenticate(tokens.accessToken, tokens.refreshToken)) {
      return;
    }

    await _secretManager.store(Token.mac, Token(tokens.mAC));
  }

  @override
  Future logout() {
    throw UnimplementedError();
  }
}
