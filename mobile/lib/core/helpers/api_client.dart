import 'package:grpc/grpc.dart';

abstract class ApiClient {
  ClientChannel getChannel();
}

final class GrpcApiClient implements ApiClient {
  final String baseurl;
  final int port;

  late final ClientChannel _clientChannel;

  GrpcApiClient(this.baseurl, this.port) {
    _clientChannel = ClientChannel(
      baseurl,
      port: port,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  @override
  ClientChannel getChannel() {
    return _clientChannel;
  }
}
