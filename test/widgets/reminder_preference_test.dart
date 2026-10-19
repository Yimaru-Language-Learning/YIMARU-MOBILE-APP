import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/localization_service.dart';
import 'package:yimaru_app/ui/views/account_privacy/account_privacy_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:yimaru_app/ui/common/translations/codegen_loader.g.dart';

class _Api implements ApiService {
  bool enabled = true;
  bool failLoad = false;
  bool failSave = false;
  @override
  Future<bool> getReminderPreference() async {
    if (failLoad) throw StateError('offline');
    return enabled;
  }

  @override
  Future<bool> setReminderPreference(bool value) async {
    if (failSave) throw StateError('offline');
    return enabled = value;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Localization with ListenableServiceMixin implements LocalizationService {
  @override
  Map<String, dynamic> get selectedLanguage =>
      {'language': 'English', 'code': 'en'};
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Navigation implements NavigationService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Dialog implements DialogService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Authentication implements AuthenticationService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _app(String language, {double textScale = 1}) => EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('am')],
    startLocale: Locale(language),
    saveLocale: false,
    path: 'assets/translations',
    assetLoader: const CodegenLoader(),
    child: Builder(
        builder: (context) => MaterialApp(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(textScale)),
                child: child!),
            home: const AccountPrivacyView())));
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/shared_preferences'),
            (call) async =>
                call.method == 'getAll' ? <String, dynamic>{} : true);
    await EasyLocalization.ensureInitialized();
  });
  tearDownAll(() => TestDefaultBinaryMessengerBinding
      .instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/shared_preferences'), null));
  late _Api api;
  setUp(() {
    api = _Api();
    locator.registerSingleton<ApiService>(api);
    locator.registerSingleton<LocalizationService>(_Localization());
    locator.registerSingleton<NavigationService>(_Navigation());
    locator.registerSingleton<DialogService>(_Dialog());
    locator.registerSingleton<AuthenticationService>(_Authentication());
  });
  tearDown(() => locator.reset());
  for (final language in ['en', 'am']) {
    testWidgets('opt-out control is localized and can save in $language',
        (tester) async {
      await tester.pumpWidget(_app(language));
      await tester.pumpAndSettle();
      expect(
          find.text(language == 'en' ? 'Automated reminders' : 'ራስ-ሰር ማስታወሻዎች'),
          findsOneWidget);
      final tile = find.byType(SwitchListTile);
      await tester.ensureVisible(tile);
      await tester.tap(tile);
      await tester.pumpAndSettle();
      expect(api.enabled, isFalse);
      expect(tester.widget<SwitchListTile>(tile).value, isFalse);
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('failed loads have Retry; failed saves preserve the old setting',
      (tester) async {
    api.failLoad = true;
    await tester.pumpWidget(_app('en'));
    await tester.pumpAndSettle();
    expect(find.text('Retry'), findsOneWidget);
    api.failLoad = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    api.failSave = true;
    final tile = find.byType(SwitchListTile);
    await tester.ensureVisible(tile);
    await tester.tap(tile);
    await tester.pumpAndSettle();
    expect(tester.widget<SwitchListTile>(tile).value, isTrue);
    expect(find.text('Could not save your preference. Please try again.'),
        findsOneWidget);
  });
  testWidgets('settings remain scrollable on a small screen with larger text',
      (tester) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(_app('en', textScale: 1.6));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(SwitchListTile));
    expect(tester.takeException(), isNull);
  });
}
