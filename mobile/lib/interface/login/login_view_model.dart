// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobile/core/errors/failed_to_authenticate.dart';
import 'package:mobile/core/helpers/dialog_helpers.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/interface/protected_routes.dart';

final class LoginViewModel extends FormViewModel {
  final AuthProvider _authProvider;
  final INavigationManager _navManager;

  LoginViewModel(this._authProvider, this._navManager);

  register(BuildContext context, String licensePlate) async {
    try {
      await _authProvider.register(licensePlate);
      await _navManager.pushAsync(ProtectedRoutes.home);
    } on FailedToAuthenticateError catch (e) {
      DialogHelper.showError(context, e.toString());
    }
  }
}
