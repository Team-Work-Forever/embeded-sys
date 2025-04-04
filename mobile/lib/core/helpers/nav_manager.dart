import 'package:mobile/core/navigation/app_route.dart';

abstract class INavigationManager {
  Future pushAsync<T>(AppRoute route, {T? extras});
  void push<T>(AppRoute route, {T? extras});
  void replaceTop<T>(AppRoute route, {T? extras});
  Future replaceTopAsync<T>(AppRoute route, {T? extras});
  void pop();
}
