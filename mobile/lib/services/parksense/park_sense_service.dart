import 'package:mobile/services/proto/parksense.pb.dart';

abstract class ParkSenseService {
  Stream<ParkSet> streamIncomingParkLot();
}
