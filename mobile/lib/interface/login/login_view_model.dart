// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobile/core/errors/domain_exception.dart';
import 'package:mobile/core/errors/failed_to_authenticate.dart';
import 'package:mobile/core/helpers/dialog_helpers.dart';
import 'package:mobile/core/helpers/form/form_field_values.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/value_objetcs/license_plate.dart';
import 'package:mobile/interface/protected_routes.dart';

final class LoginViewModel extends FormViewModel {
  final AuthProvider _authProvider;
  final INavigationManager _navManager;

  LoginViewModel(this._authProvider, this._navManager) {
    initializeFields([FormFieldValues.licensePlate]);

    setError(FormFieldValues.licensePlate, '');
  }

  void setLicensePlate(String setLicensePlate) {
    try {
      if (setLicensePlate.isEmpty) {
        throw DomainException(
          LocaleContext.get().auth_login_licensePlate_empty,
        );
      }

      setValue(
        FormFieldValues.licensePlate,
        LicensePlate.create(setLicensePlate).toString(),
      );
    } on DomainException catch (e) {
      setError(FormFieldValues.licensePlate, e.message);
    }
  }

  register(BuildContext context) async {
    String licensePlate = getValue(FormFieldValues.licensePlate).value;

    try {
      if (!await _authProvider.canAuthenticate) {
        await _authProvider.register(licensePlate);
      } else {
        await _authProvider.login(licensePlate);
      }

      await _navManager.pushAsync(ProtectedRoutes.home);
    } on FailedToAuthenticateError catch (e) {
      DialogHelper.showError(context, e.toString());
    }
  }
}
