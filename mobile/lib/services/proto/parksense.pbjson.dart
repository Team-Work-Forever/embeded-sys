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

@$core.Deprecated('Use reserveDescriptor instead')
const Reserve$json = {
  '1': 'Reserve',
  '2': [
    {'1': 'reserve_id', '3': 1, '4': 1, '5': 9, '10': 'reserveId'},
    {'1': 'slot_id', '3': 2, '4': 1, '5': 9, '10': 'slotId'},
    {'1': 'slot_label', '3': 3, '4': 1, '5': 9, '10': 'slotLabel'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `Reserve`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reserveDescriptor = $convert.base64Decode(
    'CgdSZXNlcnZlEh0KCnJlc2VydmVfaWQYASABKAlSCXJlc2VydmVJZBIXCgdzbG90X2lkGAIgAS'
    'gJUgZzbG90SWQSHQoKc2xvdF9sYWJlbBgDIAEoCVIJc2xvdExhYmVsEhcKB3VzZXJfaWQYBCAB'
    'KAlSBnVzZXJJZBI4Cgl0aW1lc3RhbXAYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgl0aW1lc3RhbXA=');

@$core.Deprecated('Use reserveHistoryDescriptor instead')
const ReserveHistory$json = {
  '1': 'ReserveHistory',
  '2': [
    {'1': 'reserve_history_id', '3': 1, '4': 1, '5': 9, '10': 'reserveHistoryId'},
    {'1': 'slot_id', '3': 2, '4': 1, '5': 9, '10': 'slotId'},
    {'1': 'slot_label', '3': 3, '4': 1, '5': 9, '10': 'slotLabel'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'timestamp_begin', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestampBegin'},
    {'1': 'timestamp_end', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestampEnd'},
  ],
};

/// Descriptor for `ReserveHistory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reserveHistoryDescriptor = $convert.base64Decode(
    'Cg5SZXNlcnZlSGlzdG9yeRIsChJyZXNlcnZlX2hpc3RvcnlfaWQYASABKAlSEHJlc2VydmVIaX'
    'N0b3J5SWQSFwoHc2xvdF9pZBgCIAEoCVIGc2xvdElkEh0KCnNsb3RfbGFiZWwYAyABKAlSCXNs'
    'b3RMYWJlbBIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQSQwoPdGltZXN0YW1wX2JlZ2luGAUgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIOdGltZXN0YW1wQmVnaW4SPwoNdGltZXN0'
    'YW1wX2VuZBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHRpbWVzdGFtcEVuZA'
    '==');

@$core.Deprecated('Use createReserveRequestDescriptor instead')
const CreateReserveRequest$json = {
  '1': 'CreateReserveRequest',
  '2': [
    {'1': 'slot_id', '3': 1, '4': 1, '5': 9, '10': 'slotId'},
    {'1': 'slot_label', '3': 2, '4': 1, '5': 9, '10': 'slotLabel'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `CreateReserveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createReserveRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVSZXNlcnZlUmVxdWVzdBIXCgdzbG90X2lkGAEgASgJUgZzbG90SWQSHQoKc2xvdF'
    '9sYWJlbBgCIAEoCVIJc2xvdExhYmVsEjgKCXRpbWVzdGFtcBgDIAEoCzIaLmdvb2dsZS5wcm90'
    'b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use cancelReserveRequestDescriptor instead')
const CancelReserveRequest$json = {
  '1': 'CancelReserveRequest',
  '2': [
    {'1': 'reserve_id', '3': 1, '4': 1, '5': 9, '10': 'reserveId'},
  ],
};

/// Descriptor for `CancelReserveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelReserveRequestDescriptor = $convert.base64Decode(
    'ChRDYW5jZWxSZXNlcnZlUmVxdWVzdBIdCgpyZXNlcnZlX2lkGAEgASgJUglyZXNlcnZlSWQ=');

@$core.Deprecated('Use parkSetListResponseDescriptor instead')
const ParkSetListResponse$json = {
  '1': 'ParkSetListResponse',
  '2': [
    {'1': 'park_sets', '3': 1, '4': 3, '5': 11, '6': '.parksense.ParkSet', '10': 'parkSets'},
  ],
};

/// Descriptor for `ParkSetListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List parkSetListResponseDescriptor = $convert.base64Decode(
    'ChNQYXJrU2V0TGlzdFJlc3BvbnNlEi8KCXBhcmtfc2V0cxgBIAMoCzISLnBhcmtzZW5zZS5QYX'
    'JrU2V0UghwYXJrU2V0cw==');

@$core.Deprecated('Use reserveHistoryListResponseDescriptor instead')
const ReserveHistoryListResponse$json = {
  '1': 'ReserveHistoryListResponse',
  '2': [
    {'1': 'history', '3': 1, '4': 3, '5': 11, '6': '.parksense.ReserveHistory', '10': 'history'},
  ],
};

/// Descriptor for `ReserveHistoryListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reserveHistoryListResponseDescriptor = $convert.base64Decode(
    'ChpSZXNlcnZlSGlzdG9yeUxpc3RSZXNwb25zZRIzCgdoaXN0b3J5GAEgAygLMhkucGFya3Nlbn'
    'NlLlJlc2VydmVIaXN0b3J5UgdoaXN0b3J5');

@$core.Deprecated('Use reserveListResponseDescriptor instead')
const ReserveListResponse$json = {
  '1': 'ReserveListResponse',
  '2': [
    {'1': 'reserves', '3': 1, '4': 3, '5': 11, '6': '.parksense.Reserve', '10': 'reserves'},
  ],
};

/// Descriptor for `ReserveListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reserveListResponseDescriptor = $convert.base64Decode(
    'ChNSZXNlcnZlTGlzdFJlc3BvbnNlEi4KCHJlc2VydmVzGAEgAygLMhIucGFya3NlbnNlLlJlc2'
    'VydmVSCHJlc2VydmVz');

