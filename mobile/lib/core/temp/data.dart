import 'package:mobile/services/proto/parksense.pb.dart';

List<ParkLot> get parkingLotsData => [
  ParkLot(parkLotId: "A1", row: 2, column: 3, state: LotState.FREE),
  ParkLot(parkLotId: "A2", row: 5, column: 4, state: LotState.OCCUPIED),
  ParkLot(parkLotId: "A3", row: 1, column: 9, state: LotState.FREE),
  ParkLot(parkLotId: "A4", row: 6, column: 7, state: LotState.RESERVED),
  ParkLot(parkLotId: "A5", row: 10, column: 2, state: LotState.OCCUPIED),
  ParkLot(parkLotId: "A6", row: 10, column: 1, state: LotState.OCCUPIED),
];
List<ParkLot> get parkingLots1Data => [
  ParkLot(parkLotId: "B1", row: 3, column: 8, state: LotState.FREE),
  ParkLot(parkLotId: "B2", row: 3, column: 10, state: LotState.FREE),
  ParkLot(parkLotId: "B3", row: 4, column: 2, state: LotState.FREE),
];

ParkSet get sectionData =>
    ParkSet(parkSetId: "A", lots: parkingLotsData, state: ParkState.NORMAL);
ParkSet get section1Data =>
    ParkSet(parkSetId: "B", lots: parkingLots1Data, state: ParkState.NORMAL);

int get rows => 10;
int get columns => 10;
