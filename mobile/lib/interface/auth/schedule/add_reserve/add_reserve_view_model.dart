import 'package:mobile/core/converters/park_set_converter.dart';
import 'package:mobile/core/helpers/form/form_field_values.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/reserve_item.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/matrix_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/interface/protected_routes.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

final class AddReserveViewModel extends FormViewModel {
  final ParkSenseProvider _parkSenseProvider;
  final AuthProvider _authProvider;
  final MatrixProvider _matrixProvider;
  final INavigationManager _navigationManager;

  AddReserveViewModel(
    this._parkSenseProvider,
    this._authProvider,
    this._matrixProvider,
    this._navigationManager,
  ) {
    initializeFields([FormFieldValues.date, FormFieldValues.parkLot]);

    setValue(FormFieldValues.date, DateTime.now());
    setValue(FormFieldValues.parkLot, null);
  }

  ParkSet? get latest => _parkSenseProvider.latest;
  String get licensePlate => _authProvider.getMetadata.licensePlate;

  List<SectionItem> _sections = [];

  int get getNumberRows => _matrixProvider.rows;
  int get getNumberColumns => _matrixProvider.cols;
  int get rowOffset => _matrixProvider.rowOffset;
  int get colOffset => _matrixProvider.colOffset;

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
    await _parkSenseProvider.createReserve(
      item.slotId,
      item.slot ?? '',
      item.date,
    );
    await _navigationManager.pushAsync(ProtectedRoutes.schedule);
  }
}
