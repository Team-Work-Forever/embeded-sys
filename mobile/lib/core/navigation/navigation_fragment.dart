import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/fragment_view.dart';
import 'package:mobile/core/navigation/app_route.dart';
import 'package:mobile/core/navigation/application_navigation.dart';

class NavigationFragment<TView extends FragmentView>
    extends ApplicationNavigation {
  final Widget Function(BuildContext context, GoRouterState state, Widget view)
  view;

  NavigationFragment({super.routes, required this.view, required super.route});

  @override
  RouteBase build(AppRoute? parentRoute) {
    route.parent = parentRoute;

    return ShellRoute(
      parentNavigatorKey: AppRoute.root.key,
      navigatorKey: route.key,
      builder: (context, state, child) => view(context, state, child),
      routes: getRoutes(),
    );
  }
}
