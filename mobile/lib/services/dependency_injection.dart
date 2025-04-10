import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:mobile/core/helpers/api_client.dart';
import 'package:mobile/core/helpers/secret_manager/secret_manager.dart';
import 'package:mobile/core/helpers/secret_manager/secret_manager_impl.dart';
import 'package:mobile/core/models/token.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/auth_provider_impl.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/services/auth/auth_service.dart';
import 'package:mobile/services/auth/auth_service_impl.dart';
import 'package:mobile/services/parksense/park_sense_service.dart';
import 'package:mobile/services/parksense/park_sense_service_impl.dart';
import 'package:mobile/services/proto/auth.pbgrpc.dart';
import 'package:mobile/services/proto/parksense.pbgrpc.dart';

extension ServiceInjection on DependencyInjection {
  void _addGrpcClients(GetIt it) {
    it.registerFactoryParam<AuthServiceClient, ClientChannel, void>(
      (channel, _) => AuthServiceClient(channel),
    );

    it.registerFactoryParam<ParkSenseServiceClient, ClientChannel, void>(
      (channel, _) => ParkSenseServiceClient(channel),
    );
  }

  void addServices(ApiClient apiClient) {
    GetIt locator = DependencyInjection.locator;

    _addGrpcClients(locator);

    locator.registerFactory<AuthService>(() => AuthServiceImpl(apiClient));

    var secretManager = locator.registerSingleton<SecretManager>(
      SecretManagerImpl((converters) {
        return converters.register(TokenConverter());
      }),
    );

    var authProvider = locator.registerSingleton<AuthProvider>(
      AuthProviderImpl(locator<AuthService>(), secretManager),
    );

    locator.registerFactory<ParkSenseService>(
      () => ParkSenseServiceImpl(apiClient, authProvider),
    );
  }
}
