//
//  Generated code. Do not modify.
//  source: parksense.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LotState extends $pb.ProtobufEnum {
  static const LotState UNKNOWN = LotState._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const LotState FREE = LotState._(1, _omitEnumNames ? '' : 'FREE');
  static const LotState OCCUPIED = LotState._(2, _omitEnumNames ? '' : 'OCCUPIED');
  static const LotState RESERVED = LotState._(3, _omitEnumNames ? '' : 'RESERVED');

  static const $core.List<LotState> values = <LotState> [
    UNKNOWN,
    FREE,
    OCCUPIED,
    RESERVED,
  ];

  static final $core.Map<$core.int, LotState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LotState? valueOf($core.int value) => _byValue[value];

  const LotState._(super.v, super.n);
}

class ParkState extends $pb.ProtobufEnum {
  static const ParkState NORMAL = ParkState._(0, _omitEnumNames ? '' : 'NORMAL');
  static const ParkState FIRE = ParkState._(1, _omitEnumNames ? '' : 'FIRE');

  static const $core.List<ParkState> values = <ParkState> [
    NORMAL,
    FIRE,
  ];

  static final $core.Map<$core.int, ParkState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ParkState? valueOf($core.int value) => _byValue[value];

  const ParkState._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
