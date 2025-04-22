import 'package:mobile/core/converters/park_set_converter.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/models/reserve_item.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/interface/protected_routes.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

final class ScheduleViewModel extends FormViewModel {
  final ParkSenseProvider _parkSenseProvider;
  final INavigationManager _navigationManager;

  List<ReserveItem> _reserves = [];
  List<ReserveHistoryItem> _historyReserves = [];

  ScheduleViewModel(this._parkSenseProvider, this._navigationManager);

  @override
  void initSync() {
    _getAllReserves();
    _getAllHistoryReserves();

    super.initSync();
  }

  List<ReserveItem> get reserves => _reserves;
  List<ReserveHistoryItem> get historyReserves => _historyReserves;

  Future<void> _getAllReserves() async {
    List<Reserve> reservesItem =
        await _parkSenseProvider.getUserActiveReserves();

    _reserves =
        reservesItem
            .map((e) => ParkSetConverter.convertReserveToReserveItem(e))
            .toList();

    notifyListeners();
  }

  Future<void> _getAllHistoryReserves() async {
    List<ReserveHistory> historyReservesItem =
        await _parkSenseProvider.getUserReserveHistory();

    _historyReserves =
        historyReservesItem
            .map(
              (e) =>
                  ParkSetConverter.convertReserveHistoryToReserveHistoryItem(e),
            )
            .toList();

    notifyListeners();
  }

  void goBack() async {
    await _navigationManager.pushAsync(ProtectedRoutes.home);
  }

  void cancelReserve(String id) async {
    await _parkSenseProvider.cancelReserve(id);
    await _navigationManager.pushAsync(ProtectedRoutes.schedule);
  }

  void addReserve() async {
    await _navigationManager.pushAsync(ProtectedRoutes.addReserve);
  }
}
