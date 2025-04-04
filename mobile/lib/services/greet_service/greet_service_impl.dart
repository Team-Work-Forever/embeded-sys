import 'package:mobile/services/base_service.dart';
import 'package:mobile/services/greet_service/greet_service.dart';
import 'package:mobile/services/proto/greet.pbgrpc.dart';

final class GreetServiceImpl extends BaseService<GreetServiceClient>
    implements GreetService {
  GreetServiceImpl(super.apiClient);

  @override
  Future<HelloResponse> sayHello(HelloRequest request) {
    return client.sayHello(request);
  }
}
