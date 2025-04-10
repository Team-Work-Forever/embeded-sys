import 'package:get_it/get_it.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/core/providers/park_sense_provider_impl.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/services/parksense/park_sense_service.dart';

extension CoreInjection on DependencyInjection {
  void _addProviders(GetIt it) {
    var parkSenseService = it<ParkSenseService>();

    it.registerSingleton<ParkSenseProvider>(
      ParkSenseProviderImpl(parkSenseService),
    );
  }

  void addCore() {
    GetIt locator = DependencyInjection.locator;

    _addProviders(locator);
  }
}
