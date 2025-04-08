import 'package:mobile/core/helpers/secret_manager/secret_value.dart';

abstract class SecretConverter<TSecret extends SecretValue> {
  TSecret toValue(String value);
  String fromValue(TSecret value);
}
