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

import 'google/protobuf/timestamp.pb.dart' as $3;
import 'parksense.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'parksense.pbenum.dart';

class ParkLot extends $pb.GeneratedMessage {
  factory ParkLot({
    $core.String? parkLotId,
    LotState? state,
    $core.int? row,
    $core.int? column,
  }) {
    final $result = create();
    if (parkLotId != null) {
      $result.parkLotId = parkLotId;
    }
    if (state != null) {
      $result.state = state;
    }
    if (row != null) {
      $result.row = row;
    }
    if (column != null) {
      $result.column = column;
    }
    return $result;
  }
  ParkLot._() : super();
  factory ParkLot.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ParkLot.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ParkLot', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parkLotId')
    ..e<LotState>(2, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: LotState.UNKNOWN, valueOf: LotState.valueOf, enumValues: LotState.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'row', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'column', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ParkLot clone() => ParkLot()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ParkLot copyWith(void Function(ParkLot) updates) => super.copyWith((message) => updates(message as ParkLot)) as ParkLot;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ParkLot create() => ParkLot._();
  ParkLot createEmptyInstance() => create();
  static $pb.PbList<ParkLot> createRepeated() => $pb.PbList<ParkLot>();
  @$core.pragma('dart2js:noInline')
  static ParkLot getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ParkLot>(create);
  static ParkLot? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get parkLotId => $_getSZ(0);
  @$pb.TagNumber(1)
  set parkLotId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasParkLotId() => $_has(0);
  @$pb.TagNumber(1)
  void clearParkLotId() => $_clearField(1);

  @$pb.TagNumber(2)
  LotState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(LotState v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get row => $_getIZ(2);
  @$pb.TagNumber(3)
  set row($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRow() => $_has(2);
  @$pb.TagNumber(3)
  void clearRow() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get column => $_getIZ(3);
  @$pb.TagNumber(4)
  set column($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasColumn() => $_has(3);
  @$pb.TagNumber(4)
  void clearColumn() => $_clearField(4);
}

class ParkSet extends $pb.GeneratedMessage {
  factory ParkSet({
    $core.String? parkSetId,
    $core.Iterable<ParkLot>? lots,
    ParkState? state,
    $3.Timestamp? timestamp,
  }) {
    final $result = create();
    if (parkSetId != null) {
      $result.parkSetId = parkSetId;
    }
    if (lots != null) {
      $result.lots.addAll(lots);
    }
    if (state != null) {
      $result.state = state;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  ParkSet._() : super();
  factory ParkSet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ParkSet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ParkSet', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parkSetId')
    ..pc<ParkLot>(2, _omitFieldNames ? '' : 'lots', $pb.PbFieldType.PM, subBuilder: ParkLot.create)
    ..e<ParkState>(3, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: ParkState.NORMAL, valueOf: ParkState.valueOf, enumValues: ParkState.values)
    ..aOM<$3.Timestamp>(4, _omitFieldNames ? '' : 'timestamp', subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ParkSet clone() => ParkSet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ParkSet copyWith(void Function(ParkSet) updates) => super.copyWith((message) => updates(message as ParkSet)) as ParkSet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ParkSet create() => ParkSet._();
  ParkSet createEmptyInstance() => create();
  static $pb.PbList<ParkSet> createRepeated() => $pb.PbList<ParkSet>();
  @$core.pragma('dart2js:noInline')
  static ParkSet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ParkSet>(create);
  static ParkSet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get parkSetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set parkSetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasParkSetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearParkSetId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<ParkLot> get lots => $_getList(1);

  @$pb.TagNumber(3)
  ParkState get state => $_getN(2);
  @$pb.TagNumber(3)
  set state(ParkState v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasState() => $_has(2);
  @$pb.TagNumber(3)
  void clearState() => $_clearField(3);

  @$pb.TagNumber(4)
  $3.Timestamp get timestamp => $_getN(3);
  @$pb.TagNumber(4)
  set timestamp($3.Timestamp v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureTimestamp() => $_ensure(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
