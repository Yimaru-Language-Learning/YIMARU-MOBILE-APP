import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:yimaru_app/app/app.bottomsheets.dart';
import 'package:yimaru_app/app/app.dialogs.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => _buildMaterialWrapper();

  Widget _buildMaterialWrapper() => ToastificationWrapper(
        child: _buildMaterialApp(),
      );

  Widget _buildMaterialApp() => MaterialApp(
        initialRoute: Routes.startupView,
        theme: ThemeData(fontFamily: 'Aeonik'),
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorObservers: [StackedService.routeObserver],
      );
}
