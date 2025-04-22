import 'package:get_it/get_it.dart';
import 'package:mobile/application_router.dart';
import 'package:mobile/core/helpers/nav_manager.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/language_provider.dart';
import 'package:mobile/core/providers/matrix_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/interface/auth/home/home_view.dart';
import 'package:mobile/interface/auth/home/home_view_model.dart';
import 'package:mobile/interface/auth/profile/profile_view.dart';
import 'package:mobile/interface/auth/profile/profile_view_model.dart';
import 'package:mobile/interface/auth/schedule/add_reserve/add_reserve_view.dart';
import 'package:mobile/interface/auth/schedule/add_reserve/add_reserve_view_model.dart';
import 'package:mobile/interface/auth/schedule/schedule_view.dart';
import 'package:mobile/interface/auth/schedule/schedule_view_model.dart';
import 'package:mobile/interface/login/login_view.dart';
import 'package:mobile/interface/login/login_view_model.dart';
import 'package:mobile/interface/auth_routes.dart';
import 'package:mobile/interface/protected_routes.dart';

extension InterfaceInjection on DependencyInjection {
  _addViewModels(GetIt it) {
    var navManager = it<INavigationManager>();
    var authProvider = it<AuthProvider>();

    var parkSenseProvider = it<ParkSenseProvider>();
    var languageProvider = it<LanguageProvider>();
    var matrixProvider = it<MatrixProvider>();

    it.registerFactory(() => LoginViewModel(authProvider, navManager));

    it.registerFactory(
      () => HomeViewModel(
        parkSenseProvider,
        authProvider,
        matrixProvider,
        navManager,
      ),
    );
    it.registerFactory(
      () => ProfileViewModel(authProvider, languageProvider, navManager),
    );
    it.registerFactory(() => ScheduleViewModel(parkSenseProvider, navManager));
    it.registerFactory(
      () => AddReserveViewModel(
        parkSenseProvider,
        authProvider,
        matrixProvider,
        navManager,
      ),
    );
  }

  _addViews(GetIt it) {
    it.registerFactory(() => LoginView(viewModel: it<LoginViewModel>()));
    it.registerFactory(() => HomeView(viewModel: it<HomeViewModel>()));
    it.registerFactory(() => ProfileView(viewModel: it<ProfileViewModel>()));
    it.registerFactory(() => ScheduleView(viewModel: it<ScheduleViewModel>()));
    it.registerFactory(
      () => AddReserveView(viewModel: it<AddReserveViewModel>()),
    );
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
