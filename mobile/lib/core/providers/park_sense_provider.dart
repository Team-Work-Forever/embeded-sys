import 'package:flutter/material.dart';
import 'package:mobile/services/proto/google/protobuf/empty.pb.dart';
import 'package:mobile/services/proto/parksense.pbgrpc.dart';

abstract class ParkSenseProvider {
  ParkSet? get latest;
  List<ParkSet> get parkSets;

  void startListening();

  void subscrive(VoidCallback notifyListeners);
  void unSubscrive(VoidCallback notifyListeners);

  Future<List<ParkSet>> getAllParkSets();
  Future<Reserve> createReserve(String slotId, String slotLabel, DateTime date);
  Future<List<Reserve>> getUserActiveReserves();
  Future<List<ReserveHistory>> getUserReserveHistory();
  Future<Empty> cancelReserve(String reserveId);
}
