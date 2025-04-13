import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/interface/auth_routes.dart';
import 'package:mobile/services/proto/parksense.pb.dart';

final class HomeViewModel extends FormViewModel {
  final ParkSenseProvider _parkSenseProvider;
  final AuthProvider _authProvider;
  final INavigationManager _navigationManager;

  HomeViewModel(
    this._parkSenseProvider,
    this._authProvider,
    this._navigationManager,
  );

  ParkSet? get latest => _parkSenseProvider.latest;
  String get licensePlate => _authProvider.getMetadata.licensePlate;

  @override
  void initSync() {
    _parkSenseProvider.startListening();
    _parkSenseProvider.subscrive(notifyListeners);

    super.initSync();
  }

  void goBack() async {
    await _navigationManager.pushAsync(AuthRoutes.login);
  }

  @override
  void dispose() {
    _parkSenseProvider.unSubscrive(notifyListeners);
    super.dispose();
  }
}
