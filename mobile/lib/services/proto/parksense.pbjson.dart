//
//  Generated code. Do not modify.
//  source: parksense.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use lotStateDescriptor instead')
const LotState$json = {
  '1': 'LotState',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'FREE', '2': 1},
    {'1': 'OCCUPIED', '2': 2},
    {'1': 'RESERVED', '2': 3},
  ],
};

/// Descriptor for `LotState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lotStateDescriptor = $convert.base64Decode(
    'CghMb3RTdGF0ZRILCgdVTktOT1dOEAASCAoERlJFRRABEgwKCE9DQ1VQSUVEEAISDAoIUkVTRV'
    'JWRUQQAw==');

@$core.Deprecated('Use parkStateDescriptor instead')
const ParkState$json = {
  '1': 'ParkState',
  '2': [
    {'1': 'NORMAL', '2': 0},
    {'1': 'FIRE', '2': 1},
  ],
};

/// Descriptor for `ParkState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List parkStateDescriptor = $convert.base64Decode(
    'CglQYXJrU3RhdGUSCgoGTk9STUFMEAASCAoERklSRRAB');

@$core.Deprecated('Use parkLotDescriptor instead')
const ParkLot$json = {
  '1': 'ParkLot',
  '2': [
    {'1': 'park_lot_id', '3': 1, '4': 1, '5': 9, '10': 'parkLotId'},
    {'1': 'state', '3': 2, '4': 1, '5': 14, '6': '.parksense.LotState', '10': 'state'},
    {'1': 'row', '3': 3, '4': 1, '5': 13, '10': 'row'},
    {'1': 'column', '3': 4, '4': 1, '5': 13, '10': 'column'},
  ],
};

/// Descriptor for `ParkLot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List parkLotDescriptor = $convert.base64Decode(
    'CgdQYXJrTG90Eh4KC3BhcmtfbG90X2lkGAEgASgJUglwYXJrTG90SWQSKQoFc3RhdGUYAiABKA'
    '4yEy5wYXJrc2Vuc2UuTG90U3RhdGVSBXN0YXRlEhAKA3JvdxgDIAEoDVIDcm93EhYKBmNvbHVt'
    'bhgEIAEoDVIGY29sdW1u');

@$core.Deprecated('Use parkSetDescriptor instead')
const ParkSet$json = {
  '1': 'ParkSet',
  '2': [
    {'1': 'park_set_id', '3': 1, '4': 1, '5': 9, '10': 'parkSetId'},
    {'1': 'lots', '3': 2, '4': 3, '5': 11, '6': '.parksense.ParkLot', '10': 'lots'},
    {'1': 'state', '3': 3, '4': 1, '5': 14, '6': '.parksense.ParkState', '10': 'state'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `ParkSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List parkSetDescriptor = $convert.base64Decode(
    'CgdQYXJrU2V0Eh4KC3Bhcmtfc2V0X2lkGAEgASgJUglwYXJrU2V0SWQSJgoEbG90cxgCIAMoCz'
    'ISLnBhcmtzZW5zZS5QYXJrTG90UgRsb3RzEioKBXN0YXRlGAMgASgOMhQucGFya3NlbnNlLlBh'
    'cmtTdGF0ZVIFc3RhdGUSOAoJdGltZXN0YW1wGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbW'
    'VzdGFtcFIJdGltZXN0YW1w');

