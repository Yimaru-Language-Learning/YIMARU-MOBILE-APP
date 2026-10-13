import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/faq.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/translations/codegen_loader.g.dart';
import 'package:yimaru_app/ui/views/faqs/faqs_view.dart';
import 'package:yimaru_app/ui/widgets/retryable_content.dart';

class _Api implements ApiService {
  int calls = 0;
  bool fail = true;
  @override
  Future<List<Faq>> getFaqs() async {
    calls++;
    if (fail) throw StateError('server failed');
    return [const Faq(question: 'Recovered FAQ', answer: 'Answer')];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Status implements StatusCheckerService {
  @override
  Future<bool> checkConnection() async => true;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Navigation implements NavigationService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget localized(Widget child, [String language = 'en']) => EasyLocalization(
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
                home: Scaffold(body: child),
              )),
    );

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
  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/shared_preferences'), null);
  });
  tearDown(() => locator.reset());

  for (final language in ['en', 'am']) {
    testWidgets('error and Retry are localized in $language', (tester) async {
      await tester.pumpWidget(
          localized(LoadErrorIndicator(onRetry: () async {}), language));
      await tester.pumpAndSettle();
      expect(find.text(language == 'en' ? 'Something went wrong' : 'ችግር ተፈጥሯል'),
          findsOneWidget);
      expect(
          find.text(language == 'en' ? 'Retry' : 'እንደገና ሞክር'), findsOneWidget);
    });
  }

  testWidgets('repeated taps start one retry and disable the button',
      (tester) async {
    final pending = Completer<void>();
    var calls = 0;
    await tester.pumpWidget(localized(LoadErrorIndicator(onRetry: () {
      calls++;
      return pending.future;
    })));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Retry'));
    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(calls, 1);
    expect(tester.widget<OutlinedButton>(find.byType(OutlinedButton)).onPressed,
        isNull);
    pending.complete();
    await tester.pumpAndSettle();
    expect(tester.widget<OutlinedButton>(find.byType(OutlinedButton)).onPressed,
        isNotNull);
  });

  testWidgets('another failed retry keeps the button available',
      (tester) async {
    await tester.pumpWidget(localized(LoadErrorIndicator(
        onRetry: () async => throw StateError('secret server details'))));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Retry'), findsOneWidget);
    expect(find.textContaining('secret'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('successful empty content is not treated as an error',
      (tester) async {
    await tester.pumpWidget(localized(RetryableContent(
      isLoading: false,
      hasError: false,
      onRetry: () async {},
      builder: () => const Text('No content yet'),
    )));
    await tester.pumpAndSettle();
    expect(find.text('No content yet'), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
  });

  testWidgets('background failure can retain the previously loaded content',
      (tester) async {
    await tester.pumpWidget(localized(RetryableContent(
      isLoading: false,
      hasError: true,
      keepContentOnError: true,
      onRetry: () async {},
      builder: () => const Text('Existing lessons'),
    )));
    await tester.pumpAndSettle();
    expect(find.text('Existing lessons'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('loading does not build the stale/error content', (tester) async {
    await tester.pumpWidget(localized(RetryableContent(
      isLoading: true,
      hasError: true,
      loading: const Text('Loading data'),
      onRetry: () async {},
      builder: () => throw StateError('must not build during loading'),
    )));
    await tester.pumpAndSettle();
    expect(find.text('Loading data'), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'leaving while retry is pending does not update a disposed widget',
      (tester) async {
    final pending = Completer<void>();
    await tester.pumpWidget(
        localized(LoadErrorIndicator(onRetry: () => pending.future)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Retry'));
    await tester.pumpWidget(const SizedBox());
    pending.complete();
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('FAQ screen retries its failed read without leaving the page',
      (tester) async {
    final api = _Api();
    locator.registerSingleton<ApiService>(api);
    locator.registerSingleton<StatusCheckerService>(_Status());
    locator.registerSingleton<NavigationService>(_Navigation());
    await tester.pumpWidget(localized(const FaqsView()));
    await tester.pumpAndSettle();
    expect(find.text('Something went wrong'), findsOneWidget);
    api.fail = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(api.calls, 2);
    expect(find.text('Recovered FAQ'), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
