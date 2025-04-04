import 'package:get_it/get_it.dart';
import 'package:mobile/application_router.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/interface/login/login_view.dart';
import 'package:mobile/interface/login/login_view_model.dart';
import 'package:mobile/interface/routes.dart';
import 'package:mobile/services/greet_service/greet_service.dart';

extension InterfaceInjection on DependencyInjection {
  _addViewModels(GetIt it) {
    var greetService = it<GreetService>();

    it.registerFactory(() => LoginViewModel(greetService));
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
