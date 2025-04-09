import 'package:get_it/get_it.dart';
import 'package:mobile/core/helpers/secret_manager/secret_manager.dart';
import 'package:mobile/core/helpers/secret_manager/secret_manager_impl.dart';
import 'package:mobile/core/models/token.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/auth_provider_impl.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/core/providers/park_sense_provider_impl.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/services/auth/auth_service.dart';
import 'package:mobile/services/parksense/park_sense_service.dart';

extension CoreInjection on DependencyInjection {
  void _addProviders(GetIt it) {
    var authService = it<AuthService>();
    var parkSenseService = it<ParkSenseService>();

    var secretManager = it.registerSingleton<SecretManager>(
      SecretManagerImpl((converters) {
        return converters.register(TokenConverter());
      }),
    );

    it.registerSingleton<AuthProvider>(
      AuthProviderImpl(authService, secretManager),
    );

    it.registerSingleton<ParkSenseProvider>(
      ParkSenseProviderImpl(parkSenseService),
    );
  }

  void addCore() {
    GetIt locator = DependencyInjection.locator;

    _addProviders(locator);
  }
}
