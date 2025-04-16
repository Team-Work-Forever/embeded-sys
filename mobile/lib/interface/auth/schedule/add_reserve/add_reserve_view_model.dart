import 'package:mobile/core/converters/park_set_converter.dart';
import 'package:mobile/core/helpers/form/form_field_values.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/reserve_item.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/core/temp/data.dart';
import 'package:mobile/interface/protected_routes.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

final class AddReserveViewModel extends FormViewModel {
  final ParkSenseProvider _parkSenseProvider;
  final AuthProvider _authProvider;
  final INavigationManager _navigationManager;

  AddReserveViewModel(
    this._parkSenseProvider,
    this._authProvider,
    this._navigationManager,
  ) {
    initializeFields([FormFieldValues.date, FormFieldValues.parkLot]);

    setValue(FormFieldValues.date, DateTime.now());
    setValue(FormFieldValues.parkLot, null);
  }

  ParkSet? get latest => _parkSenseProvider.latest;
  String get licensePlate => _authProvider.getMetadata.licensePlate;

  List<ParkLot> get parkingLots => parkingLotsData;
  List<ParkLot> get parkingLots1 => parkingLots1Data;

  ParkSet get section => sectionData;
  ParkSet get section1 => section1Data;

  List<SectionItem> get sections => [
    ParkSetConverter.convertParkSetToSectionItem(section),
    ParkSetConverter.convertParkSetToSectionItem(section1),
  ];

  int get getNumberRows => rows;
  int get getNumberColumns => columns;

  void setDate(DateTime date) {
    setValue<DateTime>(FormFieldValues.date, date);
  }

  void setParkLot(ParkingLotItem parkLot) {
    setValue<ParkingLotItem>(FormFieldValues.parkLot, parkLot);
  }

  void goBack() async {
    await _navigationManager.pushAsync(ProtectedRoutes.schedule);
  }

  Future<void> addReserve(ReserveItem item) async {
    await _navigationManager.pushAsync(ProtectedRoutes.schedule);
    // TODO: ADD ENDPOINT
  }
}
