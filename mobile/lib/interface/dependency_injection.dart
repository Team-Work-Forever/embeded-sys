import 'package:get_it/get_it.dart';
import 'package:mobile/application_router.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/interface/auth/home/home_view.dart';
import 'package:mobile/interface/auth/home/home_view_model.dart';
import 'package:mobile/interface/login/login_view.dart';
import 'package:mobile/interface/login/login_view_model.dart';
import 'package:mobile/interface/auth_routes.dart';
import 'package:mobile/interface/protected_routes.dart';

extension InterfaceInjection on DependencyInjection {
  _addViewModels(GetIt it) {
    var navManager = it<INavigationManager>();
    var authProvider = it<AuthProvider>();

    var parkSenseProvider = it<ParkSenseProvider>();

    it.registerFactory(() => LoginViewModel(authProvider, navManager));

    it.registerLazySingleton(
      () => HomeViewModel(parkSenseProvider, authProvider, navManager),
      dispose: (homeViewModel) => homeViewModel.dispose(),
    );
  }

  _addViews(GetIt it) {
    it.registerFactory(() => LoginView(viewModel: it<LoginViewModel>()));
    it.registerFactory(() => HomeView(viewModel: it<HomeViewModel>()));
  }

  void addInterface(ApplicationRouter appRouter) {
    var locator = DependencyInjection.locator;

    // Bind MVVM
    _addViewModels(locator);
    _addViews(locator);

    // Connect Routes
    appRouter.addRoute(appRoutes);
    appRouter.addRoute(protectedRoutes);
  }
}
