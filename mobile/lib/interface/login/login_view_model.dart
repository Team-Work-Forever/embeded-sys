import 'package:flutter/widgets.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/providers/auth_provider.dart';

final class LoginViewModel extends FormViewModel {
  final AuthProvider _authProvider;

  LoginViewModel(this._authProvider);

  String getAuthState() {
    if (_authProvider.isAuthenticated) {
      return "Congrats: ${_authProvider.getMetadata.licensePlate}";
    }

    return "Not Authenticated";
  }

  @override
  Future initAsync() async {
    var licensePlate = "AB-12-34";

    if (!await _authProvider.canAuthenticate) {
      await _authProvider.register(licensePlate);
    } else {
      await _authProvider.login(licensePlate);
    }

    debugPrint(getAuthState());
  }
}
