import 'package:mobile/core/converters/park_set_converter.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/matrix_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/interface/auth_routes.dart';
import 'package:mobile/interface/protected_routes.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

final class HomeViewModel extends FormViewModel {
  final ParkSenseProvider _parkSenseProvider;
  final AuthProvider _authProvider;
  final MatrixProvider _matrixProvider;
  final INavigationManager _navigationManager;
  late bool _isList = true;
  late bool _modalShown = false;

  HomeViewModel(
    this._parkSenseProvider,
    this._authProvider,
    this._matrixProvider,
    this._navigationManager,
  );

  ParkSet? get latest => _parkSenseProvider.latest;
  String get licensePlate => _authProvider.getMetadata.licensePlate;

  List<SectionItem> _sections = [];

  int get getNumberRows => _matrixProvider.rows;
  int get getNumberColumns => _matrixProvider.cols;
  int get rowOffset => _matrixProvider.rowOffset;
  int get colOffset => _matrixProvider.colOffset;

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

  @override
  Future<void> initAsync() async {
    await _getAllParkSets();
    await _matrixProvider.defineMatrix(_sections);

    super.initAsync();
  }

  List<SectionItem> get sections => _sections;

  Future<void> _getAllParkSets() async {
    List<ParkSet> parkSets = await _parkSenseProvider.getAllParkSets();

    _sections =
        parkSets
            .map((e) => ParkSetConverter.convertParkSetToSectionItem(e))
            .toList();

    notifyListeners();
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
