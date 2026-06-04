import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:yimaru_app/app/app.bottomsheets.dart';
import 'package:yimaru_app/app/app.dialogs.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yimaru_app/services/push_notification_service.dart';
import 'package:yimaru_app/ui/common/translations/codegen_loader.g.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await locator<PushNotificationService>().initialize();
  await EasyLocalization.ensureInitialized();
  setupDialogUi();
  setupBottomSheetUi();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale(
          'am',
        ),
      ],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => _buildMaterialWrapper(context);

  Widget _buildMaterialWrapper(BuildContext context) => ToastificationWrapper(
        child: _buildMaterialApp(context),
      );

  Widget _buildMaterialApp(BuildContext context) => MaterialApp(
        locale: context.locale,
        initialRoute: Routes.startupView,
        theme: ThemeData(fontFamily: 'Aeonik'),
        navigatorKey: StackedService.navigatorKey,
        supportedLocales: context.supportedLocales,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorObservers: [StackedService.routeObserver],
        localizationsDelegates: context.localizationDelegates,
      );
}
