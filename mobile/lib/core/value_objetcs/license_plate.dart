import 'package:mobile/core/errors/domain_exception.dart';
import 'package:mobile/core/locales/locale_context.dart';

class LicensePlate {
  final String value;

  static final RegExp regex = RegExp(
    r'^(([A-Z]{2}-\d{2}-(\d{2}|[A-Z]{2}))|(\d{2}-(\d{2}-[A-Z]{2}|[A-Z]{2}-\d{2})))$',
  );

  LicensePlate._(this.value);

  factory LicensePlate.create(String plate) {
    final normalized = plate.toUpperCase();

    if (!regex.hasMatch(normalized)) {
      throw DomainException(
        LocaleContext.get().auth_login_invalid_license_plate,
      );
    }

    return LicensePlate._(normalized);
  }

  @override
  String toString() => value;
}
