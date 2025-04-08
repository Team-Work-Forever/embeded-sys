import 'package:mobile/core/helpers/secret_manager/secret_converter.dart';
import 'package:mobile/core/helpers/secret_manager/secret_value.dart';

final class Token implements SecretValue {
  static String get accessToken => "access-token";
  static String get refreshToken => "refresh-token";
  static String get mac => "mac";

  final String token;

  Token(this.token);

  @override
  getValue() => token;
}

class TokenConverter implements SecretConverter<Token> {
  @override
  String fromValue(Token value) => value.getValue();

  @override
  Token toValue(String value) => Token(value);
}
