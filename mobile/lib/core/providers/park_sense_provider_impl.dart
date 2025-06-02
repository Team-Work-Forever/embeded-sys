import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/core/view_model.dart';
import 'package:mobile/services/parksense/park_sense_service.dart';
import 'package:mobile/services/proto/google/protobuf/empty.pb.dart';
import 'package:mobile/services/proto/google/protobuf/timestamp.pb.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

class ParkSenseProviderImpl extends ViewModel implements ParkSenseProvider {
  final ParkSenseService _parkSenseService;

  late StreamSubscription<ParkSet> _subscription;
  late bool _isListening = false;

  List<ParkSet> _parkSets = [];
  ParkSet? _latest;

  ParkSenseProviderImpl(this._parkSenseService);

  @override
  ParkSet? get latest => _latest;

  @override
  List<ParkSet> get parkSets => _parkSets;

  void _addParkSet(ParkSet parkSet) {
    if (_parkSets.any((ps) => ps.parkSetId == parkSet.parkSetId)) {
      _parkSets.removeWhere((ps) => ps.parkSetId == parkSet.parkSetId);
    }

    _parkSets.add(parkSet);
    notifyListeners();
  }

  void _subscriveToStream() {
    var parkStream = _parkSenseService.streamIncomingParkLot();

    _subscription = parkStream.listen(
      (parkSet) {
        // _latest = parkSet;
        debugPrint("Received ParkSet: ${parkSet.parkSetId}");
        _addParkSet(parkSet);

        debugPrint("ParkSet: ${parkSet.parkSetId}");
        notifyListeners();
      },
      onError: (e) async {
        debugPrint('Stream error: $e');
        await _handleStreamError();
      },
      onDone: () async {
        debugPrint("Stream is done");
        await _handleStreamError();
      },
      cancelOnError: true,
    );
  }

  Future<void> _handleStreamError() async {
    _isListening = false;
    await _subscription.cancel();

    Future.delayed(Duration(seconds: 5));
    debugPrint("Reconnecting....");
    startListening();
  }

  @override
  void startListening() {
    if (_isListening) {
      return;
    }

    _subscriveToStream();
    debugPrint("Connected...");
    _isListening = true;
  }

  @override
  void subscrive(VoidCallback notifyListeners) {
    addListener(notifyListeners);
  }

  @override
  void unSubscrive(VoidCallback notifyListeners) {
    removeListener(notifyListeners);
  }

  @override
  Future<List<ParkSet>> getAllParkSets() async {
    try {
      final response = await _parkSenseService.getAllParkSets();
      return response.parkSets;
    } catch (e) {
      debugPrint("Error while fetching park sets: $e");
      return [];
    }
  }

  @override
  Future<Reserve> createReserve(
    String slotId,
    String slotLabel,
    DateTime date,
  ) async {
    try {
      return await _parkSenseService.createReserve(
        CreateReserveRequest(
          slotId: slotId,
          slotLabel: slotLabel,
          timestamp: Timestamp.fromDateTime(date),
        ),
      );
    } catch (e) {
      debugPrint("Error while creating reserve: $e");
      rethrow;
    }
  }

  @override
  Future<List<Reserve>> getUserActiveReserves() async {
    try {
      final response = await _parkSenseService.getUserActiveReserves();
      return response.reserves;
    } catch (e) {
      debugPrint("Error while fetching active reserves: $e");
      rethrow;
    }
  }

  @override
  Future<List<ReserveHistory>> getUserReserveHistory() async {
    try {
      final response = await _parkSenseService.getUserReserveHistory();
      return response.history;
    } catch (e) {
      debugPrint("Error while fetching reserve history: $e");
      rethrow;
    }
  }

  @override
  Future<Empty> cancelReserve(String reserveId) async {
    try {
      return await _parkSenseService.cancelReserve(
        CancelReserveRequest(reserveId: reserveId),
      );
    } catch (e) {
      debugPrint("Error while canceling reserve: $e");
      rethrow;
    }
  }
}
