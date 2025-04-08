import 'package:get_it/get_it.dart';
import 'package:mobile/core/helpers/secret_manager/secret_manager.dart';
import 'package:mobile/core/helpers/secret_manager/secret_manager_impl.dart';
import 'package:mobile/core/models/token.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/auth_provider_impl.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/services/auth_service.dart';

extension CoreInjection on DependencyInjection {
  void _addProviders(GetIt it) {
    var authService = it<AuthService>();

    var secretManager = it.registerSingleton<SecretManager>(
      SecretManagerImpl((converters) {
        return converters.register(TokenConverter());
      }),
    );

    it.registerSingleton<AuthProvider>(
      AuthProviderImpl(authService, secretManager),
    );
  }

  void addCore() {
    GetIt locator = DependencyInjection.locator;

    _addProviders(locator);
  }
}
