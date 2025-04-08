import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/core/errors/failed_to_authenticate.dart';
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
  Future<bool> get canAuthenticate async =>
      (await _secretManager.get<Token>(Token.refreshToken)) != null;

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
    var fetchMac = await _secretManager.get<Token>(Token.mac);
    throwIf(fetchMac == null, FailedToAuthenticateError());

    var tokens = await _authService.login(licensePlate, fetchMac!.getValue());

    throwIfNot(
      await authenticate(tokens.accessToken, tokens.refreshToken),
      FailedToAuthenticateError(),
    );
  }

  @override
  Future register(String licensePlate) async {
    var tokens = await _authService.register(licensePlate);

    throwIfNot(
      await authenticate(tokens.accessToken, tokens.refreshToken),
      FailedToAuthenticateError(),
    );

    await _secretManager.store(Token.mac, Token(tokens.mAC));
  }

  @override
  Future logout() async {
    await _secretManager.deleteAll();
    _identityUser = null;
    notifyListeners();
  }
}
