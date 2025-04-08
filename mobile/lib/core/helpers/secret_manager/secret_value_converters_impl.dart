import 'package:get_it/get_it.dart';
import 'package:mobile/core/errors/converter_not_registered.dart';
import 'package:mobile/core/helpers/secret_manager/secret_converter.dart';
import 'package:mobile/core/helpers/secret_manager/secret_value.dart';
import 'package:mobile/core/helpers/secret_manager/secret_value_converters.dart';

class SecretValueConvertersImpl implements SecretValueConverters {
  final Map<Type, SecretConverter> _converters = {};

  @override
  SecretValueConverters register<T extends SecretValue>(
    SecretConverter<T> converter,
  ) {
    _converters[T] = converter;
    return this;
  }

  SecretConverter<T> get<T extends SecretValue>() {
    var converter = _converters[T] as SecretConverter<T>?;
    throwIf(converter == null, ConverterNotRegistered());

    return converter!;
  }
}
