//
//  Generated code. Do not modify.
//  source: parksense.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/empty.pb.dart' as $1;
import 'parksense.pb.dart' as $2;

export 'parksense.pb.dart';

@$pb.GrpcServiceName('parksense.ParkSenseService')
class ParkSenseServiceClient extends $grpc.Client {
  static final _$streamIncomingParkLot = $grpc.ClientMethod<$1.Empty, $2.ParkSet>(
      '/parksense.ParkSenseService/StreamIncomingParkLot',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ParkSet.fromBuffer(value));

  ParkSenseServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$2.ParkSet> streamIncomingParkLot($1.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamIncomingParkLot, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('parksense.ParkSenseService')
abstract class ParkSenseServiceBase extends $grpc.Service {
  $core.String get $name => 'parksense.ParkSenseService';

  ParkSenseServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.ParkSet>(
        'StreamIncomingParkLot',
        streamIncomingParkLot_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($2.ParkSet value) => value.writeToBuffer()));
  }

  $async.Stream<$2.ParkSet> streamIncomingParkLot_Pre($grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async* {
    yield* streamIncomingParkLot($call, await $request);
  }

  $async.Stream<$2.ParkSet> streamIncomingParkLot($grpc.ServiceCall call, $1.Empty request);
}
