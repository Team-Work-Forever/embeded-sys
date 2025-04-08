import 'package:mobile/core/navigation/app_route.dart';
import 'package:mobile/core/navigation/navigation_route.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/interface/login/login_view.dart';

extension AuthRoutes on AppRoute {
  static final AppRoute auth = AppRoute(path: "auth");
  static final AppRoute login = AppRoute(path: "login");
}

final NavigationRoute appRoutes = NavigationRoute(
  route: AuthRoutes.auth,
  routes: [
    NavigationRoute(
      route: AuthRoutes.login,
      view: (context, state) => LinearView.of<LoginView>(),
    ),
  ],
);
