import 'package:get_it/get_it.dart';
import 'package:mobile/application_router.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/interface/login/login_view.dart';
import 'package:mobile/interface/login/login_view_model.dart';
import 'package:mobile/interface/routes.dart';

extension InterfaceInjection on DependencyInjection {
  _addViewModels(GetIt it) {
    var authProvider = it<AuthProvider>();

    it.registerFactory(() => LoginViewModel(authProvider));
  }

  _addViews(GetIt it) {
    it.registerFactory(() => LoginView(viewModel: it<LoginViewModel>()));
  }

  void addInterface(ApplicationRouter appRouter) {
    var locator = DependencyInjection.locator;

    // Bind MVVM
    _addViewModels(locator);
    _addViews(locator);

    // Connect Routes
    appRouter.addRoute(appRoutes);
  }
}
