import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/core/helpers/secret_manager/secret_manager.dart';
import 'package:mobile/core/helpers/secret_manager/secret_value.dart';
import 'package:mobile/core/helpers/secret_manager/secret_value_converters.dart';
import 'package:mobile/core/helpers/secret_manager/secret_value_converters_impl.dart';

final class SecretManagerImpl implements SecretManager {
  final FlutterSecureStorage _storage;
  final SecretValueConvertersImpl _converters;

  static const AndroidOptions _options = AndroidOptions(
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding,
    encryptedSharedPreferences: true,
  );

  SecretManagerImpl(
    SecretValueConverters Function(SecretValueConverters) registerConverters,
  ) : _storage = FlutterSecureStorage(aOptions: _options),
      _converters =
          registerConverters(SecretValueConvertersImpl())
              as SecretValueConvertersImpl;

  @override
  Future<TValue?> get<TValue extends SecretValue>(String key) async {
    var selectedConverter = _converters.get<TValue>();

    var value = await _storage.read(key: key);

    if (value == null) {
      return null;
    }

    return selectedConverter.toValue(value);
  }

  @override
  Future store<TValue extends SecretValue>(String key, TValue value) async {
    var selectedConverter = _converters.get<TValue>();
    await _storage.write(key: key, value: selectedConverter.fromValue(value));
  }

  @override
  SecretValueConverters getConverters() => _converters;
}
