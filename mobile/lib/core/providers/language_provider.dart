import 'dart:ui';

abstract class LanguageProvider {
  Stream<Locale> get localeStream;
  Locale get currentLocale;

  void deviceLanguage();
  void initializeLanguage();
  void changeLanguage(String languageCode);
}
