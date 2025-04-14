import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

class ParkSetConverter {
  static List<ParkingLotItem> convertParkLotToParkingLotItem(
    List<ParkLot> parkLot,
    ParkState state,
  ) {
    return parkLot
        .map(
          (e) => ParkingLotItem(
            id: e.parkLotId,
            myCar: false,
            state:
                state.value == 1
                    ? ParkingLotStates.emergency
                    : ParkingLotStates.getOfId(e.state.value),
            row: e.row,
            column: e.column,
          ),
        )
        .toList();
  }

  static SectionItem convertParkSetToSectionItem(ParkSet parkSet) {
    return SectionItem(
      sectionId: parkSet.parkSetId,
      parkingLots: convertParkLotToParkingLotItem(parkSet.lots, parkSet.state),
      state: SectionStates.getOfId(parkSet.state.value),
    );
  }
}
