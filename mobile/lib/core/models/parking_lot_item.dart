import 'dart:ui';

import 'package:mobile/core/config/global.dart';

class ParkingLotItem {
  final bool myCar;
  final ParkingLotStates state;
  final int row;
  final int column;

  ParkingLotItem({
    required this.myCar,
    required this.state,
    required this.row,
    required this.column,
  });
}

enum ParkingLotStates implements Comparable<ParkingLotStates> {
  free(value: "Free", color: AppColor.free),
  occupied(value: "Occupied", color: AppColor.occupied),
  reserved(value: "Reserved", color: AppColor.reserved),
  emergency(value: "Emergency", color: AppColor.emergency),
  notDefined(value: "NotDefined", color: AppColor.notDefined);

  final String value;
  final Color color;

  const ParkingLotStates({required this.value, required this.color});

  static ParkingLotStates getOf(String value) =>
      ParkingLotStates.values.singleWhere((element) => element.value == value);

  static List<String> getAllTypes() {
    return ParkingLotStates.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(ParkingLotStates other) {
    throw UnimplementedError();
  }
}
