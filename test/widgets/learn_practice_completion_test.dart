import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/codegen_loader.g.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_result_screen.dart';

import '../helpers/practice_completion_fakes.dart';

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

  late CompletionFixture fixture;
  late LearnPracticeViewModel model;
  setUp(() {
    fixture = CompletionFixture();
    model = fixture.register();
  });
  tearDown(() async {
    if (!model.disposed) model.dispose();
    await locator.reset();
  });

  Future<void> mount(WidgetTester tester,
      {String language = 'en',
      LearnPractices kind = LearnPractices.lesson,
      double textScale = 1}) async {
    await model.getLearnPractices(id: 100, practice: kind);
    model.goTo(3);
    await tester.pumpWidget(EasyLocalization(
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
                home: ViewModelBuilder<LearnPracticeViewModel>.reactive(
                  viewModelBuilder: () => model,
                  disposeViewModel: false,
                  builder: (context, viewModel, _) => viewModel.currentPage >= 4
                      ? const Scaffold(body: Text('Confirmed completion'))
                      : LearnPracticeResultScreen(practice: kind),
                ),
              )),
    ));
    await tester.pumpAndSettle();
  }

  Future<void> tap(WidgetTester tester, String label) async {
    final button = find.text(label);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  for (final language in ['en', 'am']) {
    testWidgets(
        'failed save stays on results and Retry saves existing attempt in $language',
        (tester) async {
      fixture.api.succeed = false;
      await mount(tester, language: language);
      await tap(tester, tr(LocaleKeys.cont));
      expect(find.text('Confirmed completion'), findsNothing);
      expect(
          find.text(tr(LocaleKeys.practice_completion_failed)), findsOneWidget);
      expect(find.text('private server details'), findsNothing);
      fixture.api.succeed = true;
      await tap(tester, tr(LocaleKeys.retry));
      expect(find.text('Confirmed completion'), findsOneWidget);
      expect(fixture.api.payloads, hasLength(2));
      expect(fixture.api.payloads.last['parent_id'], 100);
      expect(tester.takeException(), isNull);
    });
  }

  for (final kind in [LearnPractices.module, LearnPractices.course]) {
    testWidgets('$kind advances only after successful save', (tester) async {
      await mount(tester, kind: kind);
      await tap(tester, tr(LocaleKeys.cont));
      expect(model.currentPage, kind == LearnPractices.module ? 5 : 6);
      expect(find.text('Confirmed completion'), findsOneWidget);
    });
  }

  testWidgets('saved progress with failed refresh offers read-only Retry',
      (tester) async {
    fixture.learn.fail = true;
    await mount(tester);
    await tap(tester, tr(LocaleKeys.cont));
    expect(find.text(tr(LocaleKeys.practice_progress_refresh_failed)),
        findsOneWidget);
    expect(find.text(tr(LocaleKeys.practice_again)), findsNothing);
    fixture.learn.fail = false;
    await tap(tester, tr(LocaleKeys.retry));
    expect(find.text('Confirmed completion'), findsOneWidget);
    expect(fixture.api.payloads, hasLength(1));
    expect(fixture.learn.refreshes, 2);
  });

  testWidgets(
      'leaving the screen while saving does not navigate on a late response',
      (tester) async {
    await mount(tester);
    fixture.api.saveGate = Completer<void>();
    await tester.ensureVisible(find.text(tr(LocaleKeys.cont)));
    await tester.tap(find.text(tr(LocaleKeys.cont)));
    await tester.pump();
    await tester.pumpWidget(const MaterialApp(home: Text('Other screen')));
    model.dispose();
    fixture.api.saveGate!.complete();
    await tester.pumpAndSettle();
    expect(find.text('Other screen'), findsOneWidget);
    expect(find.text('Confirmed completion'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  for (final language in ['en', 'am']) {
    testWidgets(
        'failure and Retry remain reachable with large text in $language',
        (tester) async {
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      fixture.api.succeed = false;
      await mount(tester, language: language, textScale: 1.6);
      await tap(tester, tr(LocaleKeys.cont));
      await tester.ensureVisible(find.text(tr(LocaleKeys.retry)));
      expect(
          find.text(tr(LocaleKeys.practice_completion_failed)), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
