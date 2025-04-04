import 'package:mobile/services/proto/greet.pb.dart';

abstract class GreetService {
  Future<HelloResponse> sayHello(HelloRequest request);
}
