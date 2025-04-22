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

class Reserve extends $pb.GeneratedMessage {
  factory Reserve({
    $core.String? reserveId,
    $core.String? slotId,
    $core.String? slotLabel,
    $core.String? userId,
    $3.Timestamp? timestamp,
  }) {
    final $result = create();
    if (reserveId != null) {
      $result.reserveId = reserveId;
    }
    if (slotId != null) {
      $result.slotId = slotId;
    }
    if (slotLabel != null) {
      $result.slotLabel = slotLabel;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  Reserve._() : super();
  factory Reserve.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Reserve.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Reserve', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reserveId')
    ..aOS(2, _omitFieldNames ? '' : 'slotId')
    ..aOS(3, _omitFieldNames ? '' : 'slotLabel')
    ..aOS(4, _omitFieldNames ? '' : 'userId')
    ..aOM<$3.Timestamp>(5, _omitFieldNames ? '' : 'timestamp', subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Reserve clone() => Reserve()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Reserve copyWith(void Function(Reserve) updates) => super.copyWith((message) => updates(message as Reserve)) as Reserve;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Reserve create() => Reserve._();
  Reserve createEmptyInstance() => create();
  static $pb.PbList<Reserve> createRepeated() => $pb.PbList<Reserve>();
  @$core.pragma('dart2js:noInline')
  static Reserve getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Reserve>(create);
  static Reserve? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reserveId => $_getSZ(0);
  @$pb.TagNumber(1)
  set reserveId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReserveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReserveId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get slotId => $_getSZ(1);
  @$pb.TagNumber(2)
  set slotId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSlotId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlotId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get slotLabel => $_getSZ(2);
  @$pb.TagNumber(3)
  set slotLabel($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSlotLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlotLabel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $3.Timestamp get timestamp => $_getN(4);
  @$pb.TagNumber(5)
  set timestamp($3.Timestamp v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.Timestamp ensureTimestamp() => $_ensure(4);
}

class ReserveHistory extends $pb.GeneratedMessage {
  factory ReserveHistory({
    $core.String? reserveHistoryId,
    $core.String? slotId,
    $core.String? slotLabel,
    $core.String? userId,
    $3.Timestamp? timestampBegin,
    $3.Timestamp? timestampEnd,
  }) {
    final $result = create();
    if (reserveHistoryId != null) {
      $result.reserveHistoryId = reserveHistoryId;
    }
    if (slotId != null) {
      $result.slotId = slotId;
    }
    if (slotLabel != null) {
      $result.slotLabel = slotLabel;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (timestampBegin != null) {
      $result.timestampBegin = timestampBegin;
    }
    if (timestampEnd != null) {
      $result.timestampEnd = timestampEnd;
    }
    return $result;
  }
  ReserveHistory._() : super();
  factory ReserveHistory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReserveHistory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReserveHistory', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reserveHistoryId')
    ..aOS(2, _omitFieldNames ? '' : 'slotId')
    ..aOS(3, _omitFieldNames ? '' : 'slotLabel')
    ..aOS(4, _omitFieldNames ? '' : 'userId')
    ..aOM<$3.Timestamp>(5, _omitFieldNames ? '' : 'timestampBegin', subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(6, _omitFieldNames ? '' : 'timestampEnd', subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReserveHistory clone() => ReserveHistory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReserveHistory copyWith(void Function(ReserveHistory) updates) => super.copyWith((message) => updates(message as ReserveHistory)) as ReserveHistory;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReserveHistory create() => ReserveHistory._();
  ReserveHistory createEmptyInstance() => create();
  static $pb.PbList<ReserveHistory> createRepeated() => $pb.PbList<ReserveHistory>();
  @$core.pragma('dart2js:noInline')
  static ReserveHistory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReserveHistory>(create);
  static ReserveHistory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reserveHistoryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set reserveHistoryId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReserveHistoryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReserveHistoryId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get slotId => $_getSZ(1);
  @$pb.TagNumber(2)
  set slotId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSlotId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlotId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get slotLabel => $_getSZ(2);
  @$pb.TagNumber(3)
  set slotLabel($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSlotLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlotLabel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $3.Timestamp get timestampBegin => $_getN(4);
  @$pb.TagNumber(5)
  set timestampBegin($3.Timestamp v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestampBegin() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestampBegin() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.Timestamp ensureTimestampBegin() => $_ensure(4);

  @$pb.TagNumber(6)
  $3.Timestamp get timestampEnd => $_getN(5);
  @$pb.TagNumber(6)
  set timestampEnd($3.Timestamp v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimestampEnd() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestampEnd() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.Timestamp ensureTimestampEnd() => $_ensure(5);
}

class CreateReserveRequest extends $pb.GeneratedMessage {
  factory CreateReserveRequest({
    $core.String? slotId,
    $core.String? slotLabel,
    $3.Timestamp? timestamp,
  }) {
    final $result = create();
    if (slotId != null) {
      $result.slotId = slotId;
    }
    if (slotLabel != null) {
      $result.slotLabel = slotLabel;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  CreateReserveRequest._() : super();
  factory CreateReserveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateReserveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateReserveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'slotId')
    ..aOS(2, _omitFieldNames ? '' : 'slotLabel')
    ..aOM<$3.Timestamp>(3, _omitFieldNames ? '' : 'timestamp', subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateReserveRequest clone() => CreateReserveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateReserveRequest copyWith(void Function(CreateReserveRequest) updates) => super.copyWith((message) => updates(message as CreateReserveRequest)) as CreateReserveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateReserveRequest create() => CreateReserveRequest._();
  CreateReserveRequest createEmptyInstance() => create();
  static $pb.PbList<CreateReserveRequest> createRepeated() => $pb.PbList<CreateReserveRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateReserveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateReserveRequest>(create);
  static CreateReserveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get slotId => $_getSZ(0);
  @$pb.TagNumber(1)
  set slotId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSlotId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSlotId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get slotLabel => $_getSZ(1);
  @$pb.TagNumber(2)
  set slotLabel($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSlotLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlotLabel() => $_clearField(2);

  @$pb.TagNumber(3)
  $3.Timestamp get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp($3.Timestamp v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.Timestamp ensureTimestamp() => $_ensure(2);
}

class CancelReserveRequest extends $pb.GeneratedMessage {
  factory CancelReserveRequest({
    $core.String? reserveId,
  }) {
    final $result = create();
    if (reserveId != null) {
      $result.reserveId = reserveId;
    }
    return $result;
  }
  CancelReserveRequest._() : super();
  factory CancelReserveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelReserveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelReserveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reserveId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelReserveRequest clone() => CancelReserveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelReserveRequest copyWith(void Function(CancelReserveRequest) updates) => super.copyWith((message) => updates(message as CancelReserveRequest)) as CancelReserveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelReserveRequest create() => CancelReserveRequest._();
  CancelReserveRequest createEmptyInstance() => create();
  static $pb.PbList<CancelReserveRequest> createRepeated() => $pb.PbList<CancelReserveRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelReserveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelReserveRequest>(create);
  static CancelReserveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reserveId => $_getSZ(0);
  @$pb.TagNumber(1)
  set reserveId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReserveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReserveId() => $_clearField(1);
}

class ParkSetListResponse extends $pb.GeneratedMessage {
  factory ParkSetListResponse({
    $core.Iterable<ParkSet>? parkSets,
  }) {
    final $result = create();
    if (parkSets != null) {
      $result.parkSets.addAll(parkSets);
    }
    return $result;
  }
  ParkSetListResponse._() : super();
  factory ParkSetListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ParkSetListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ParkSetListResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..pc<ParkSet>(1, _omitFieldNames ? '' : 'parkSets', $pb.PbFieldType.PM, subBuilder: ParkSet.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ParkSetListResponse clone() => ParkSetListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ParkSetListResponse copyWith(void Function(ParkSetListResponse) updates) => super.copyWith((message) => updates(message as ParkSetListResponse)) as ParkSetListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ParkSetListResponse create() => ParkSetListResponse._();
  ParkSetListResponse createEmptyInstance() => create();
  static $pb.PbList<ParkSetListResponse> createRepeated() => $pb.PbList<ParkSetListResponse>();
  @$core.pragma('dart2js:noInline')
  static ParkSetListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ParkSetListResponse>(create);
  static ParkSetListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ParkSet> get parkSets => $_getList(0);
}

class ReserveHistoryListResponse extends $pb.GeneratedMessage {
  factory ReserveHistoryListResponse({
    $core.Iterable<ReserveHistory>? history,
  }) {
    final $result = create();
    if (history != null) {
      $result.history.addAll(history);
    }
    return $result;
  }
  ReserveHistoryListResponse._() : super();
  factory ReserveHistoryListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReserveHistoryListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReserveHistoryListResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..pc<ReserveHistory>(1, _omitFieldNames ? '' : 'history', $pb.PbFieldType.PM, subBuilder: ReserveHistory.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReserveHistoryListResponse clone() => ReserveHistoryListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReserveHistoryListResponse copyWith(void Function(ReserveHistoryListResponse) updates) => super.copyWith((message) => updates(message as ReserveHistoryListResponse)) as ReserveHistoryListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReserveHistoryListResponse create() => ReserveHistoryListResponse._();
  ReserveHistoryListResponse createEmptyInstance() => create();
  static $pb.PbList<ReserveHistoryListResponse> createRepeated() => $pb.PbList<ReserveHistoryListResponse>();
  @$core.pragma('dart2js:noInline')
  static ReserveHistoryListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReserveHistoryListResponse>(create);
  static ReserveHistoryListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ReserveHistory> get history => $_getList(0);
}

class ReserveListResponse extends $pb.GeneratedMessage {
  factory ReserveListResponse({
    $core.Iterable<Reserve>? reserves,
  }) {
    final $result = create();
    if (reserves != null) {
      $result.reserves.addAll(reserves);
    }
    return $result;
  }
  ReserveListResponse._() : super();
  factory ReserveListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReserveListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReserveListResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'parksense'), createEmptyInstance: create)
    ..pc<Reserve>(1, _omitFieldNames ? '' : 'reserves', $pb.PbFieldType.PM, subBuilder: Reserve.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReserveListResponse clone() => ReserveListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReserveListResponse copyWith(void Function(ReserveListResponse) updates) => super.copyWith((message) => updates(message as ReserveListResponse)) as ReserveListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReserveListResponse create() => ReserveListResponse._();
  ReserveListResponse createEmptyInstance() => create();
  static $pb.PbList<ReserveListResponse> createRepeated() => $pb.PbList<ReserveListResponse>();
  @$core.pragma('dart2js:noInline')
  static ReserveListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReserveListResponse>(create);
  static ReserveListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Reserve> get reserves => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
