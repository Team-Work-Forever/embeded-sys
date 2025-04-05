import 'package:mobile/services/base_service.dart';
import 'package:mobile/services/greet_service/greet_service.dart';
import 'package:mobile/services/proto/auth.pbgrpc.dart';

final class GreetServiceImpl extends BaseService<AuthServiceClient>
    implements GreetService {
  GreetServiceImpl(super.apiClient);
}
