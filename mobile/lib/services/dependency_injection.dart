import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:mobile/core/helpers/api_client.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/services/greet_service/greet_service.dart';
import 'package:mobile/services/greet_service/greet_service_impl.dart';
import 'package:mobile/services/proto/greet.pbgrpc.dart';

extension ServiceInjection on DependencyInjection {
  void _addGrpcClients(GetIt it) {
    it.registerFactoryParam<GreetServiceClient, ClientChannel, void>(
      (channel, _) => GreetServiceClient(channel),
    );
  }

  void addServices(ApiClient apiClient) {
    GetIt locator = DependencyInjection.locator;

    _addGrpcClients(locator);
    locator.registerFactory<GreetService>(() => GreetServiceImpl(apiClient));
  }
}
