import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/reserve_item.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

class ParkSetConverter {
  static List<ParkingLotItem> convertParkLotToParkingLotItem(
    String parkSetId,
    List<ParkLot> parkLot,
    ParkState state,
  ) {
    return parkLot
        .map(
          (e) => ParkingLotItem(
            id: e.parkLotId,
            slotId: parkSetId,
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
      parkingLots: convertParkLotToParkingLotItem(
        parkSet.parkSetId,
        parkSet.lots,
        parkSet.state,
      ),
      state: SectionStates.getOfId(parkSet.state.value),
    );
  }

  static ReserveItem convertReserveToReserveItem(Reserve reserve) {
    return ReserveItem(
      id: reserve.reserveId,
      slotId: reserve.slotId,
      slot: reserve.slotLabel,
      date: reserve.timestamp.toDateTime(),
    );
  }

  static ReserveHistoryItem convertReserveHistoryToReserveHistoryItem(
    ReserveHistory reserve,
  ) {
    return ReserveHistoryItem(
      id: reserve.reserveHistoryId,
      slotId: reserve.slotId,
      slot: reserve.slotLabel,
      dateBegin: reserve.timestampBegin.toDateTime(),
      dateEnd: reserve.timestampEnd.toDateTime(),
    );
  }
}
