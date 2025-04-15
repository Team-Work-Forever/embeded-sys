import 'package:mobile/core/helpers/form/form_field_values.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/language_provider.dart';
import 'package:mobile/core/value_objetcs/language.dart';
import 'package:mobile/interface/auth_routes.dart';
import 'package:mobile/interface/protected_routes.dart';

final class ProfileViewModel extends FormViewModel {
  final AuthProvider _authProvider;
  final LanguageProvider _languageProvider;
  final INavigationManager _navigationManager;

  ProfileViewModel(
    this._authProvider,
    this._languageProvider,
    this._navigationManager,
  ) {
    initializeFields([FormFieldValues.language]);

    setValue(
      FormFieldValues.language,
      Language.getOf(_languageProvider.currentLocale.toString()),
    );
  }

  void changeLanguage(Language lang) {
    setValue(FormFieldValues.language, lang);
    _languageProvider.changeLanguage(lang.value);
  }

  List<Language> get getAllLanguages => Language.getAllLanguages();

  String get licensePlate => _authProvider.getMetadata.licensePlate;

  void goBack() async {
    await _navigationManager.pushAsync(ProtectedRoutes.home);
  }

  void goSignOut() async {
    _authProvider.logout();
    await _navigationManager.pushAsync(AuthRoutes.login);
  }
}
