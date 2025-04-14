import 'package:mobile/core/models/parking_lot_item.dart';

class SectionItem {
  final String sectionId;
  final List<ParkingLotItem> parkingLots;
  final SectionStates state;

  SectionItem({
    required this.parkingLots,
    required this.sectionId,
    required this.state,
  });
}

enum SectionStates implements Comparable<SectionStates> {
  normal(id: 0, value: "NORMAL"),
  emergency(id: 1, value: "FIRE");

  final int id;
  final String value;

  const SectionStates({required this.value, required this.id});

  static SectionStates getOf(String value) =>
      SectionStates.values.singleWhere((element) => element.value == value);

  static SectionStates getOfId(int id) =>
      SectionStates.values.singleWhere((element) => element.id == id);

  static List<String> getAllTypes() {
    return SectionStates.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(SectionStates other) {
    throw UnimplementedError();
  }
}
