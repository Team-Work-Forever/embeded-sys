import 'package:grpc/grpc.dart' as $grpc;

// ignore: unused_import
import 'package:mobile/core/helpers/api_client.dart';
import 'package:mobile/dependency_injection.dart';

abstract class BaseService<TGrpcClient extends $grpc.Client> {
  final TGrpcClient client;

  BaseService(ApiClient apiClient)
    : client = DependencyInjection.locator<TGrpcClient>(
        param1: apiClient.getChannel(),
      );
}
