import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/dependency_injection.dart';

void main() {
  var app = DependencyInjection().setupDIContainer();
  app.build();

  runApp(MainApp(appRouter: app.navigationManager.router));
}

class MainApp extends StatelessWidget {
  final GoRouter appRouter;

  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
