import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/interface/auth_routes.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

final class HomeViewModel extends FormViewModel {
  final ParkSenseProvider _parkSenseProvider;
  final AuthProvider _authProvider;
  final INavigationManager _navigationManager;
  late bool _isList = true;

  HomeViewModel(
    this._parkSenseProvider,
    this._authProvider,
    this._navigationManager,
  );

  ParkSet? get latest => _parkSenseProvider.latest;
  String get licensePlate => _authProvider.getMetadata.licensePlate;

  List<ParkingLotItem> get parkingLots => [
    ParkingLotItem(
      myCar: true,
      state: ParkingLotStates.occupied,
      row: 1,
      column: 1,
    ),
    ParkingLotItem(
      myCar: false,
      state: ParkingLotStates.free,
      row: 2,
      column: 3,
    ),
    ParkingLotItem(
      myCar: false,
      state: ParkingLotStates.reserved,
      row: 5,
      column: 4,
    ),
    ParkingLotItem(
      myCar: false,
      state: ParkingLotStates.reserved,
      row: 1,
      column: 9,
    ),
    ParkingLotItem(
      myCar: false,
      state: ParkingLotStates.reserved,
      row: 6,
      column: 2,
    ),
    ParkingLotItem(
      myCar: false,
      state: ParkingLotStates.reserved,
      row: 7,
      column: 3,
    ),
  ];
  List<ParkingLotItem> get parkingLots1 => [
    ParkingLotItem(
      myCar: false,
      state: ParkingLotStates.emergency,
      row: 3,
      column: 8,
    ),
    ParkingLotItem(
      myCar: false,
      state: ParkingLotStates.emergency,
      row: 3,
      column: 10,
    ),
    ParkingLotItem(
      myCar: false,
      state: ParkingLotStates.emergency,
      row: 4,
      column: 2,
    ),
  ];

  List<SectionItem> get sections => [
    SectionItem(parkingLots: parkingLots),
    SectionItem(parkingLots: parkingLots1),
  ];

  bool get isList => _isList;

  @override
  void initSync() {
    _parkSenseProvider.startListening();
    _parkSenseProvider.subscrive(notifyListeners);

    _isList = true;
    super.initSync();
  }

  void changeLayout() {
    _isList = !_isList;
    notifyListeners();
  }

  void goBack() async {
    await _navigationManager.pushAsync(AuthRoutes.login);
  }

  void goToSchedule() async {
    // TODO: CHANGE ROUTE
    // await _navigationManager.pushAsync(AuthRoutes.login);
  }

  @override
  void dispose() {
    _parkSenseProvider.unSubscrive(notifyListeners);
    super.dispose();
  }
}
