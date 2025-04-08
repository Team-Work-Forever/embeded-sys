import 'package:mobile/core/helpers/secret_manager/secret_value.dart';
import 'package:mobile/core/helpers/secret_manager/secret_value_converters.dart';

abstract class SecretManager {
  SecretValueConverters getConverters();
  Future store<TValue extends SecretValue>(String key, TValue value);
  Future<TValue?> get<TValue extends SecretValue>(String key);
}
