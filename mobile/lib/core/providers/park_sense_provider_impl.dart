import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/core/view_model.dart';
import 'package:mobile/services/parksense/park_sense_service.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

class ParkSenseProviderImpl extends ViewModel implements ParkSenseProvider {
  final ParkSenseService _parkSenseService;

  late StreamSubscription<ParkSet> _subscription;
  late bool _isListening = false;

  ParkSet? _latest;

  ParkSenseProviderImpl(this._parkSenseService);

  @override
  ParkSet? get latest => _latest;

  void _subscriveToStream() {
    var parkStream = _parkSenseService.streamIncomingParkLot();

    _subscription = parkStream.listen(
      (parkSet) {
        _latest = parkSet;

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
}
