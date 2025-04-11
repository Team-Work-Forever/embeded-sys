import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/helpers/network_helper.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/core/view_model.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  var app = DependencyInjection().setupDIContainer();
  app.build();

  var networkHelper = DependencyInjection.locator<NetWorkHelper>();

  if (await networkHelper.canUseNetwork()) {
    var authProvider = DependencyInjection.locator<AuthProvider>();

    try {
      await authProvider.checkAuth();
    } catch (e) {
      debugPrint("it's not authenticated!");
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) =>
                  DependencyInjection.locator<AuthProvider>() as ViewModel,
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  DependencyInjection.locator<ParkSenseProvider>() as ViewModel,
        ),
      ],
      child: MainApp(appRouter: app.navigationManager.router),
    ),
  );
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
