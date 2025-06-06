import 'package:go_router/go_router.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/navigation/app_route.dart';
import 'package:mobile/core/navigation/application_navigation.dart';
import 'package:mobile/core/navigation/navigation_guard.dart';
import 'package:mobile/core/navigation/navigation_manager.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:mobile/interface/auth_routes.dart';
import 'package:mobile/interface/protected_routes.dart';

final class ApplicationRouter<TView extends LinearView> {
  final ApplicationNavigation router = NavigationGuard(
    route: AppRoute.root,
    view: (context, state) {
      LocaleContext.setContext(context);
      return LinearView.of<TView>();
    },
    routes: [],
    redirectPages: (context, state) {
      var authProvider = DependencyInjection.locator<AuthProvider>();

      if (!authProvider.isAuthenticated) {
        if (state.fullPath != AuthRoutes.login.navigationPath) {
          return null;
        }

        return AuthRoutes.login;
      }

      if (state.fullPath == AppRoute.root.navigationPath) {
        return ProtectedRoutes.home;
      }

      return null;
    },
  );

  final NavigationManager _navigationManager = NavigationManager(
    GoRouter(routes: []),
  );

  NavigationManager get navigationManager => _navigationManager;

  ApplicationRouter addRoute(ApplicationNavigation route) {
    router.routes.add(route);

    return this;
  }

  ApplicationRouter addRoutes(List<ApplicationNavigation> routes) {
    router.routes.addAll(routes);

    return this;
  }

  void build() {
    _navigationManager.setRouter(
      GoRouter(
        debugLogDiagnostics: true,
        navigatorKey: AppRoute.root.key,
        routes: [router.build(null)],
      ),
    );
  }
}
