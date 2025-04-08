import 'package:get_it/get_it.dart';
import 'package:mobile/application_router.dart';
import 'package:mobile/core/config/environment_vars.dart';
import 'package:mobile/core/dependency_injection.dart';
import 'package:mobile/core/helpers/api_client.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/interface/dependency_injection.dart';
import 'package:mobile/interface/login/login_view.dart';
import 'package:mobile/services/dependency_injection.dart';

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  static GetIt get locator => DependencyInjection._locator;

  ApplicationRouter createApplicationRouter<TView extends LinearView>() {
    var applicationRouter = locator.registerSingleton(
      ApplicationRouter<TView>(),
    );

    locator.registerFactory<INavigationManager>(
      () => applicationRouter.navigationManager,
    );

    return applicationRouter;
  }

  ApiClient _setUpApiClient() =>
      GrpcApiClient(EnvironmentVars.grpcHost, EnvironmentVars.grpcPort);

  ApplicationRouter setupDIContainer() {
    var applicationRouter = createApplicationRouter<LoginView>();

    // add module
    addServices(_setUpApiClient());
    addCore();
    addInterface(applicationRouter);

    return applicationRouter;
  }
}
