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
  static final _$getAllParkSets = $grpc.ClientMethod<$1.Empty, $2.ParkSetListResponse>(
      '/parksense.ParkSenseService/GetAllParkSets',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ParkSetListResponse.fromBuffer(value));
  static final _$createReserve = $grpc.ClientMethod<$2.CreateReserveRequest, $2.Reserve>(
      '/parksense.ParkSenseService/CreateReserve',
      ($2.CreateReserveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Reserve.fromBuffer(value));
  static final _$getUserActiveReserves = $grpc.ClientMethod<$1.Empty, $2.ReserveListResponse>(
      '/parksense.ParkSenseService/GetUserActiveReserves',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ReserveListResponse.fromBuffer(value));
  static final _$getUserReserveHistory = $grpc.ClientMethod<$1.Empty, $2.ReserveHistoryListResponse>(
      '/parksense.ParkSenseService/GetUserReserveHistory',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ReserveHistoryListResponse.fromBuffer(value));
  static final _$cancelReserve = $grpc.ClientMethod<$2.CancelReserveRequest, $1.Empty>(
      '/parksense.ParkSenseService/CancelReserve',
      ($2.CancelReserveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  ParkSenseServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$2.ParkSet> streamIncomingParkLot($1.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamIncomingParkLot, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$2.ParkSetListResponse> getAllParkSets($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllParkSets, request, options: options);
  }

  $grpc.ResponseFuture<$2.Reserve> createReserve($2.CreateReserveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createReserve, request, options: options);
  }

  $grpc.ResponseFuture<$2.ReserveListResponse> getUserActiveReserves($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserActiveReserves, request, options: options);
  }

  $grpc.ResponseFuture<$2.ReserveHistoryListResponse> getUserReserveHistory($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReserveHistory, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> cancelReserve($2.CancelReserveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelReserve, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.ParkSetListResponse>(
        'GetAllParkSets',
        getAllParkSets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($2.ParkSetListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CreateReserveRequest, $2.Reserve>(
        'CreateReserve',
        createReserve_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CreateReserveRequest.fromBuffer(value),
        ($2.Reserve value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.ReserveListResponse>(
        'GetUserActiveReserves',
        getUserActiveReserves_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($2.ReserveListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.ReserveHistoryListResponse>(
        'GetUserReserveHistory',
        getUserReserveHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($2.ReserveHistoryListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CancelReserveRequest, $1.Empty>(
        'CancelReserve',
        cancelReserve_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CancelReserveRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Stream<$2.ParkSet> streamIncomingParkLot_Pre($grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async* {
    yield* streamIncomingParkLot($call, await $request);
  }

  $async.Future<$2.ParkSetListResponse> getAllParkSets_Pre($grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return getAllParkSets($call, await $request);
  }

  $async.Future<$2.Reserve> createReserve_Pre($grpc.ServiceCall $call, $async.Future<$2.CreateReserveRequest> $request) async {
    return createReserve($call, await $request);
  }

  $async.Future<$2.ReserveListResponse> getUserActiveReserves_Pre($grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return getUserActiveReserves($call, await $request);
  }

  $async.Future<$2.ReserveHistoryListResponse> getUserReserveHistory_Pre($grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return getUserReserveHistory($call, await $request);
  }

  $async.Future<$1.Empty> cancelReserve_Pre($grpc.ServiceCall $call, $async.Future<$2.CancelReserveRequest> $request) async {
    return cancelReserve($call, await $request);
  }

  $async.Stream<$2.ParkSet> streamIncomingParkLot($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$2.ParkSetListResponse> getAllParkSets($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$2.Reserve> createReserve($grpc.ServiceCall call, $2.CreateReserveRequest request);
  $async.Future<$2.ReserveListResponse> getUserActiveReserves($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$2.ReserveHistoryListResponse> getUserReserveHistory($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> cancelReserve($grpc.ServiceCall call, $2.CancelReserveRequest request);
}
