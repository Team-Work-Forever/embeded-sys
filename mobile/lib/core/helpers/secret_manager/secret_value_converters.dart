import 'package:mobile/core/helpers/secret_manager/secret_converter.dart';
import 'package:mobile/core/helpers/secret_manager/secret_value.dart';

abstract class SecretValueConverters {
  SecretValueConverters register<T extends SecretValue>(
    SecretConverter<T> converter,
  );
}
