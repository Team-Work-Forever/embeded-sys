import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/models/reserve_item.dart';
import 'package:mobile/interface/protected_routes.dart';

final class ScheduleViewModel extends FormViewModel {
  final INavigationManager _navigationManager;

  List<ReserveHistoryItem> get reservesCompleted => [
    ReserveHistoryItem(
      id: "1",
      slotId: "A3",
      slot: "A3",
      dateBegin: DateTime(2024, 4, 5, 18, 30),
      dateEnd: DateTime(2024, 4, 5, 19, 45),
    ),
    ReserveHistoryItem(
      id: "2",
      slotId: "A1",
      slot: "A1",
      dateBegin: DateTime(2022, 9, 5, 07, 30),
      dateEnd: DateTime(2022, 10, 5, 10, 45),
    ),
    ReserveHistoryItem(
      id: "3",
      slotId: "B1",
      slot: "B1",
      dateBegin: DateTime(2025, 1, 1, 15, 15),
      dateEnd: DateTime(2025, 1, 1, 15, 45),
    ),
    ReserveHistoryItem(
      id: "4",
      slotId: "B5",
      slot: "B5",
      dateBegin: DateTime(2025, 4, 6, 10, 15),
      dateEnd: DateTime(2025, 4, 7, 11, 45),
    ),
    ReserveHistoryItem(
      id: "5",
      slotId: "B6",
      slot: "B6",
      dateBegin: DateTime(2025, 4, 6, 10, 20),
      dateEnd: DateTime(2025, 4, 6, 11, 30),
    ),
  ];

  List<ReserveItem> get reserves => [
    ReserveItem(
      id: "A",
      slotId: "B1",
      slot: "B1",
      date: DateTime(2025, 4, 5, 18, 30),
    ),
  ];

  ScheduleViewModel(this._navigationManager);

  void goBack() async {
    await _navigationManager.pushAsync(ProtectedRoutes.home);
  }

  void cancelReserve(String id) async {
    //TODO: CANCEL RESERVE
  }

  void addReserve() async {
    await _navigationManager.pushAsync(ProtectedRoutes.addReserve);
  }
}
