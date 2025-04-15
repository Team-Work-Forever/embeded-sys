import 'package:mobile/core/converters/park_set_converter.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/interface/auth_routes.dart';
import 'package:mobile/interface/protected_routes.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

final class HomeViewModel extends FormViewModel {
  final ParkSenseProvider _parkSenseProvider;
  final AuthProvider _authProvider;
  final INavigationManager _navigationManager;
  late bool _isList = true;
  late bool _modalShown = false;

  HomeViewModel(
    this._parkSenseProvider,
    this._authProvider,
    this._navigationManager,
  );

  ParkSet? get latest => _parkSenseProvider.latest;
  String get licensePlate => _authProvider.getMetadata.licensePlate;

  List<ParkLot> get parkingLots => [
    ParkLot(parkLotId: "A1", row: 2, column: 3, state: LotState.FREE),
    ParkLot(parkLotId: "A2", row: 5, column: 4, state: LotState.OCCUPIED),
    ParkLot(parkLotId: "A3", row: 1, column: 9, state: LotState.FREE),
    ParkLot(parkLotId: "A4", row: 6, column: 7, state: LotState.RESERVED),
    ParkLot(parkLotId: "A5", row: 10, column: 2, state: LotState.OCCUPIED),
    ParkLot(parkLotId: "A6", row: 10, column: 1, state: LotState.OCCUPIED),
  ];
  List<ParkLot> get parkingLots1 => [
    ParkLot(parkLotId: "B1", row: 3, column: 8, state: LotState.FREE),
    ParkLot(parkLotId: "B2", row: 3, column: 10, state: LotState.FREE),
    ParkLot(parkLotId: "B3", row: 4, column: 2, state: LotState.FREE),
  ];

  ParkSet get section =>
      ParkSet(parkSetId: "A", lots: parkingLots, state: ParkState.NORMAL);
  ParkSet get section1 =>
      ParkSet(parkSetId: "B", lots: parkingLots1, state: ParkState.NORMAL);

  List<SectionItem> get sections => [
    ParkSetConverter.convertParkSetToSectionItem(section),
    ParkSetConverter.convertParkSetToSectionItem(section1),
  ];

  int get getNumberRows => 10;
  int get getNumberColumns => 10;

  bool get isList => _isList;
  bool get modalShow => _modalShown;

  @override
  void initSync() {
    _parkSenseProvider.startListening();
    _parkSenseProvider.subscrive(notifyListeners);

    _isList = true;
    _modalShown = false;
    super.initSync();
  }

  void changeLayout() {
    _isList = !_isList;
    notifyListeners();
  }

  void changeModalShow() {
    _modalShown = !_modalShown;
  }

  void goBack() async {
    await _navigationManager.pushAsync(AuthRoutes.login);
  }

  void goToSchedule() async {
    // TODO: CHANGE ROUTE
    // await _navigationManager.pushAsync(AuthRoutes.login);
  }

  void goToProfile() async {
    await _navigationManager.pushAsync(ProtectedRoutes.profile);
  }

  @override
  void dispose() {
    _parkSenseProvider.unSubscrive(notifyListeners);
    super.dispose();
  }
}
