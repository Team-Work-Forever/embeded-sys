import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/providers/auth_provider.dart';
import 'package:mobile/core/providers/language_provider.dart';
import 'package:mobile/core/providers/park_sense_provider.dart';
import 'package:mobile/core/view_model.dart';
import 'package:mobile/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load dotenv config
  await dotenv.load(fileName: '.env');

  var app = DependencyInjection().setupDIContainer();
  app.build();

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
        ChangeNotifierProvider(
          create:
              (context) =>
                  DependencyInjection.locator<LanguageProvider>() as ViewModel,
        ),
      ],
      child: MainApp(appRouter: app.navigationManager.router),
    ),
  );
}

class MainApp extends StatefulWidget {
  final GoRouter appRouter;

  const MainApp({super.key, required this.appRouter});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  late final LanguageProvider _languageProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    DependencyInjection.locator<LanguageProvider>().initializeLanguage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageProvider = DependencyInjection.locator<LanguageProvider>();
    _languageProvider.initializeLanguage();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _languageProvider.deviceLanguage();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return StreamBuilder<Locale>(
      stream: DependencyInjection.locator<LanguageProvider>().localeStream,
      initialData: const Locale('en'),
      builder: (context, localeSnapshot) {
        return MaterialApp.router(
          theme: ThemeData(fontFamily: 'Lato'),
          debugShowCheckedModeBanner: false,
          routerConfig: widget.appRouter,
          locale: localeSnapshot.data,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
