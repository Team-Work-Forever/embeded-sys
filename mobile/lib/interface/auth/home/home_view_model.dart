import 'package:mobile/core/converters/park_set_converter.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/core/temp/data.dart';
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
    await _navigationManager.pushAsync(ProtectedRoutes.schedule);
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
