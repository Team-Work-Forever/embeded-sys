import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:mobile/core/helpers/api_client.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/services/auth_service_impl.dart';
import 'package:mobile/services/proto/auth.pbgrpc.dart';

extension ServiceInjection on DependencyInjection {
  void _addGrpcClients(GetIt it) {
    it.registerFactoryParam<AuthServiceClient, ClientChannel, void>(
      (channel, _) => AuthServiceClient(channel),
    );
  }

  void addServices(ApiClient apiClient) {
    GetIt locator = DependencyInjection.locator;

    _addGrpcClients(locator);
    locator.registerFactory<AuthService>(() => AuthServiceImpl(apiClient));
  }
}
