import 'package:flutter_dotenv/flutter_dotenv.dart';

sealed class EnvironmentVars {
  static String grpcHost = dotenv.env["GRPC_HOST"] ?? "localhost";
  static int grpcPort = _convertToInt(dotenv.env["GRPC_PORT"], 50551);

  static int _convertToInt(String? envEntry, int defValue) =>
      envEntry != null ? int.tryParse(envEntry) ?? defValue : defValue;
}
