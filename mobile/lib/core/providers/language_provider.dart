import 'dart:ui';

abstract class LanguageProvider {
  Stream<Locale> get localeStream;

  void deviceLanguage();
  void initializeLanguage();
  void changeLanguage(String languageCode);
}
