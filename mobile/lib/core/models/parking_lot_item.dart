import 'dart:ui';

import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/locales/locale_context.dart';

class ParkingLotItem {
  final String id;
  final String slotId;
  final String? slot;
  final bool myCar;
  late ParkingLotStates state;
  final int row;
  final int column;

  ParkingLotItem({
    required this.id,
    required this.slotId,
    this.slot,
    required this.myCar,
    required this.state,
    required this.row,
    required this.column,
  });
}

enum ParkingLotStates implements Comparable<ParkingLotStates> {
  notDefined(id: 0, value: "NotDefined", color: AppColor.notDefined),
  free(id: 1, value: "Free", color: AppColor.free),
  occupied(id: 2, value: "Occupied", color: AppColor.occupied),
  reserved(id: 3, value: "Reserved", color: AppColor.reserved),
  emergency(id: 4, value: "Emergency", color: AppColor.emergency);

  final int id;
  final String value;
  final Color color;

  const ParkingLotStates({
    required this.id,
    required this.value,
    required this.color,
  });

  String get displayValue {
    final locale = LocaleContext.get();
    return switch (this) {
      ParkingLotStates.notDefined => locale.parking_lot_state_not_defined,
      ParkingLotStates.free => locale.parking_lot_state_free,
      ParkingLotStates.occupied => locale.parking_lot_state_occupied,
      ParkingLotStates.reserved => locale.parking_lot_state_reserved,
      ParkingLotStates.emergency => locale.parking_lot_state_emergency,
    };
  }

  static ParkingLotStates getOf(String value) =>
      ParkingLotStates.values.singleWhere((element) => element.value == value);

  static ParkingLotStates getOfId(int value) =>
      ParkingLotStates.values.singleWhere((element) => element.id == value);

  static List<String> getAllTypes() {
    return ParkingLotStates.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(ParkingLotStates other) {
    throw UnimplementedError();
  }
}
