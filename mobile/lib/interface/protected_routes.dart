import 'package:mobile/core/navigation/app_route.dart';
import 'package:mobile/core/navigation/navigation_route.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/interface/auth/home/home_view.dart';
import 'package:mobile/interface/auth/profile/profile_view.dart';
import 'package:mobile/interface/auth/schedule/add_reserve/add_reserve_view.dart';
import 'package:mobile/interface/auth/schedule/schedule_view.dart';

extension ProtectedRoutes on AppRoute {
  static final AppRoute protected = AppRoute(path: "protected");
  static final AppRoute home = AppRoute(path: "home");
  static final AppRoute profile = AppRoute(path: "profile");
  static final AppRoute schedule = AppRoute(path: "schedule");
  static final AppRoute addReserve = AppRoute(path: "addReserve");
}

final NavigationRoute protectedRoutes = NavigationRoute(
  route: ProtectedRoutes.protected,
  routes: [
    NavigationRoute(
      route: ProtectedRoutes.home,
      view: (context, state) => LinearView.of<HomeView>(),
    ),
    NavigationRoute(
      route: ProtectedRoutes.profile,
      view: (context, state) => LinearView.of<ProfileView>(),
    ),
    NavigationRoute(
      route: ProtectedRoutes.schedule,
      view: (context, state) => LinearView.of<ScheduleView>(),
    ),
    NavigationRoute(
      route: ProtectedRoutes.addReserve,
      view: (context, state) => LinearView.of<AddReserveView>(),
    ),
  ],
);
