//
//  Generated code. Do not modify.
//  source: auth.proto
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

import 'auth.pb.dart' as $0;

export 'auth.pb.dart';

@$pb.GrpcServiceName('auth.AuthService')
class AuthServiceClient extends $grpc.Client {
  static final _$register = $grpc.ClientMethod<$0.RegisterEntryRequest, $0.RegisterResponse>(
      '/auth.AuthService/Register',
      ($0.RegisterEntryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RegisterResponse.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$0.LoginEntryRequest, $0.AuthResponse>(
      '/auth.AuthService/Login',
      ($0.LoginEntryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AuthResponse.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.RegisterResponse> register($0.RegisterEntryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.AuthResponse> login($0.LoginEntryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }
}

@$pb.GrpcServiceName('auth.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RegisterEntryRequest, $0.RegisterResponse>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RegisterEntryRequest.fromBuffer(value),
        ($0.RegisterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LoginEntryRequest, $0.AuthResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginEntryRequest.fromBuffer(value),
        ($0.AuthResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.RegisterResponse> register_Pre($grpc.ServiceCall $call, $async.Future<$0.RegisterEntryRequest> $request) async {
    return register($call, await $request);
  }

  $async.Future<$0.AuthResponse> login_Pre($grpc.ServiceCall $call, $async.Future<$0.LoginEntryRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$0.RegisterResponse> register($grpc.ServiceCall call, $0.RegisterEntryRequest request);
  $async.Future<$0.AuthResponse> login($grpc.ServiceCall call, $0.LoginEntryRequest request);
}
