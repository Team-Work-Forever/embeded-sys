import 'package:flutter/material.dart';
import 'package:mobile/services/proto/parksense.pbgrpc.dart';

abstract class ParkSenseProvider {
  ParkSet? get latest;

  void startListening();

  void subscrive(VoidCallback notifyListeners);
  void unSubscrive(VoidCallback notifyListeners);
}
