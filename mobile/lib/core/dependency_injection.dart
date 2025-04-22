import 'package:get_it/get_it.dart';
import 'package:mobile/core/providers/language_provider.dart';
import 'package:mobile/core/providers/language_provider_impl.dart';
import 'package:mobile/core/providers/matrix_provider.dart';
import 'package:mobile/core/providers/matrix_provider_impl.dart';
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
    it.registerSingleton<LanguageProvider>(LanguageProviderImpl());
    it.registerSingleton<MatrixProvider>(MatrixProviderImpl());
  }

  void addCore() {
    GetIt locator = DependencyInjection.locator;

    _addProviders(locator);
  }
}
