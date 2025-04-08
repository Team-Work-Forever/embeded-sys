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
    debugPrint(getAuthState());
    await _authProvider.register("AB-12-34");
    debugPrint(getAuthState());
  }
}
