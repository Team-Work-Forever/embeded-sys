import 'package:go_router/go_router.dart';
import 'package:mobile/core/navigation/app_route.dart';
import 'package:mobile/core/navigation/application_navigation.dart';
import 'package:mobile/core/navigation/navigation_guard.dart';
import 'package:mobile/core/navigation/navigation_manager.dart';
import 'package:mobile/core/view.dart';

final class ApplicationRouter<TView extends LinearView> {
  final ApplicationNavigation router = NavigationGuard(
    route: AppRoute.root,
    view: (context, state) {
      return LinearView.of<TView>();
    },
    routes: [],
    redirectPages: (context, state) {
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
