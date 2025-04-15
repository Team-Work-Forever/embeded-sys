import 'package:mobile/core/locales/locale_context.dart';

enum Language implements Comparable<Language> {
  pt(code: 'PT', value: 'pt'),
  en(code: 'GB', value: 'en');

  final String value;
  final String code;

  const Language({required this.code, required this.value});

  String get displayValue {
    final locale = LocaleContext.get();
    return switch (this) {
      Language.pt => locale.language_pt,
      Language.en => locale.language_en,
    };
  }

  static Language getOf(String value) =>
      Language.values.singleWhere((element) => element.value == value);

  static Language getOfDisplayValue(String value) =>
      Language.values.singleWhere((element) => element.displayValue == value);

  static List<Language> getAllLanguages() {
    return Language.values.toList();
  }

  @override
  String toString() => displayValue;

  @override
  int compareTo(Language other) {
    throw UnimplementedError();
  }
}
