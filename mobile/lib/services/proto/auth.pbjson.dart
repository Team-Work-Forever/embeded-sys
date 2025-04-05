//
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use registerEntryRequestDescriptor instead')
const RegisterEntryRequest$json = {
  '1': 'RegisterEntryRequest',
  '2': [
    {'1': 'carPlate', '3': 1, '4': 1, '5': 9, '10': 'carPlate'},
  ],
};

/// Descriptor for `RegisterEntryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerEntryRequestDescriptor = $convert.base64Decode(
    'ChRSZWdpc3RlckVudHJ5UmVxdWVzdBIaCghjYXJQbGF0ZRgBIAEoCVIIY2FyUGxhdGU=');

@$core.Deprecated('Use loginEntryRequestDescriptor instead')
const LoginEntryRequest$json = {
  '1': 'LoginEntryRequest',
  '2': [
    {'1': 'carPlate', '3': 1, '4': 1, '5': 9, '10': 'carPlate'},
    {'1': 'MAC', '3': 2, '4': 1, '5': 9, '10': 'MAC'},
  ],
};

/// Descriptor for `LoginEntryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginEntryRequestDescriptor = $convert.base64Decode(
    'ChFMb2dpbkVudHJ5UmVxdWVzdBIaCghjYXJQbGF0ZRgBIAEoCVIIY2FyUGxhdGUSEAoDTUFDGA'
    'IgASgJUgNNQUM=');

@$core.Deprecated('Use authResponseDescriptor instead')
const AuthResponse$json = {
  '1': 'AuthResponse',
  '2': [
    {'1': 'accessToken', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refreshToken', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'MAC', '3': 3, '4': 1, '5': 9, '10': 'MAC'},
  ],
};

/// Descriptor for `AuthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authResponseDescriptor = $convert.base64Decode(
    'CgxBdXRoUmVzcG9uc2USIAoLYWNjZXNzVG9rZW4YASABKAlSC2FjY2Vzc1Rva2VuEiIKDHJlZn'
    'Jlc2hUb2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEhAKA01BQxgDIAEoCVIDTUFD');

