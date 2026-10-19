import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/learn_subscription_request.dart';
import 'package:yimaru_app/models/subscription.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/codegen_loader.g.dart';
import 'package:yimaru_app/ui/views/payment/payment_redirect.dart';
import 'package:yimaru_app/ui/views/payment/payment_view.dart';
import 'package:yimaru_app/ui/views/payment/payment_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/manual_payment_dialog.dart';

class TestApi extends Mock implements ApiService {
  Map<String, dynamic> response = {
    'status': ResponseStatus.success,
    'data': const LearnSubscriptionRequest(
        paymentUrl: 'https://checkout.example.com/pay',
        sessionId: 'session-123'),
  };
  int requests = 0;
  String? paymentStatus;
  String? verifiedSession;
  bool throwOnStart = false;

  @override
  Future<Map<String, dynamic>> createSubscriptionRequest(
      Map<String, dynamic> data) async {
    requests++;
    if (throwOnStart) throw StateError('Lost response');
    return response;
  }

  @override
  Future<Map<String, dynamic>> createDirectPaymentRequest(
          Map<String, dynamic> data) =>
      createSubscriptionRequest(data);

  @override
  Future<String?> getCheckoutPaymentStatus(String sessionId) async {
    verifiedSession = sessionId;
    return paymentStatus;
  }
}

class TestStatusChecker extends Mock implements StatusCheckerService {
  bool connected = true;
  @override
  Future<bool> checkConnection() async => connected;
}

class TestAuth extends Mock implements AuthenticationService {}

class TestNavigation extends NavigationService {
  int backs = 0;
  @override
  bool back<T>({dynamic result, int? id}) {
    backs++;
    return true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const plan = Subscription(id: 2, price: 300, currency: 'ETB');
  late TestApi api;
  late TestStatusChecker status;
  late TestNavigation navigation;

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

  setUp(() {
    api = TestApi();
    status = TestStatusChecker();
    navigation = TestNavigation();
    locator.registerSingleton<ApiService>(api);
    locator.registerSingleton<StatusCheckerService>(status);
    locator.registerSingleton<AuthenticationService>(TestAuth());
    locator.registerSingleton<NavigationService>(navigation);
  });
  tearDown(() => locator.reset());

  Future<PaymentViewModel> start(
      [PaymentMethod method = PaymentMethod.sdk]) async {
    final model = PaymentViewModel();
    addTearDown(model.dispose);
    await model.initiate(
        phone: '911234567', method: method, subscription: plan);
    return model;
  }

  for (final method in PaymentMethod.values) {
    test('valid $method checkout opens without a fallback', () async {
      final model = await start(method);
      expect(model.request?.paymentUrl, 'https://checkout.example.com/pay');
      expect(model.startFailure, isNull);
    });
    test('rejected $method initiation enables manual payment', () async {
      api.response = {
        'status': ResponseStatus.failure,
        'payment_outcome_unknown': false,
      };
      final model = await start(method);
      expect(model.request, isNull);
      expect(model.startFailure, PaymentFailure.failed);
    });
  }

  test('offline initiation does not send a payment request', () async {
    status.connected = false;
    final model = await start();
    expect(api.requests, 0);
    expect(model.startFailure, PaymentFailure.failed);
  });

  test('lost response requires checking before a second payment', () async {
    api.response = {
      'status': ResponseStatus.failure,
      'payment_outcome_unknown': true,
    };
    final model = await start();
    expect(model.startFailure, PaymentFailure.uncertain);
    expect(model.request, isNull);
  });

  test('unexpected initiation exception is handled as uncertain', () async {
    api.throwOnStart = true;
    expect((await start()).startFailure, PaymentFailure.uncertain);
  });

  for (final url in [null, '', 'not-a-url', 'javascript:alert(1)']) {
    test('unusable checkout URL $url does not open a blank WebView', () async {
      api.response = {
        'status': ResponseStatus.success,
        'data': LearnSubscriptionRequest(paymentUrl: url),
      };
      final model = await start();
      expect(model.request, isNull);
      expect(model.startFailure, PaymentFailure.uncertain);
    });
  }

  final outcomes = <String?, CheckoutOutcome>{
    'SUCCESS': CheckoutOutcome.success,
    'FAILED': CheckoutOutcome.failed,
    'EXPIRED': CheckoutOutcome.failed,
    'CANCELLED': CheckoutOutcome.cancelled,
    'PENDING': CheckoutOutcome.uncertain,
    'PROCESSING': CheckoutOutcome.uncertain,
    null: CheckoutOutcome.uncertain,
  };
  for (final entry in outcomes.entries) {
    test('verified ${entry.key} checkout maps to ${entry.value}', () async {
      final model = await start();
      api.paymentStatus = entry.key;
      expect(await model.checkCheckoutOutcome(), entry.value);
      expect(api.verifiedSession, 'session-123');
    });
  }

  test('repeated callbacks cannot display duplicate dialogs', () async {
    final model = await start();
    expect(model.beginCheckoutResult(), isTrue);
    expect(model.beginCheckoutResult(), isFalse);
    expect(model.claimFailureDialog(), isTrue);
    expect(model.claimFailureDialog(), isFalse);
  });

  final redirects = <String, PaymentRedirect>{
    'https://api.yimaruacademy.com/payment/error': PaymentRedirect.failure,
    'https://api.yimaruacademy.com/payment/success': PaymentRedirect.success,
    'https://api.yimaruacademy.com/payment/cancel': PaymentRedirect.cancelled,
    'https://api.yimaruacademy.com/payment/error?status=cancelled':
        PaymentRedirect.cancelled,
    'https://api.yimaruacademy.com/payment/success?status=canceled':
        PaymentRedirect.cancelled,
    'https://other.example/payment/error': PaymentRedirect.none,
    'https://other.example/?next=https://api.yimaruacademy.com/payment/error':
        PaymentRedirect.none,
    'https://api.yimaruacademy.com/payment/error-extra': PaymentRedirect.none,
  };
  for (final entry in redirects.entries) {
    test('redirect ${entry.key}', () {
      expect(classifyPaymentRedirect(Uri.parse(entry.key)), entry.value);
    });
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

  testWidgets('manual popup displays the supplied bank details',
      (tester) async {
    await tester.pumpWidget(localized(const ManualPaymentDialog()));
    await tester.pumpAndSettle();
    expect(find.text('1000322464669'), findsOneWidget);
    expect(find.text('Endrias Israel Mulugeta'), findsOneWidget);
    expect(find.text('Commercial Bank of Ethiopia'), findsOneWidget);
    expect(find.text('Open Telegram'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('uncertain popup does not offer a second payment',
      (tester) async {
    await tester.pumpWidget(
        localized(const ManualPaymentDialog(paymentUncertain: true)));
    await tester.pumpAndSettle();
    expect(find.text('1000322464669'), findsNothing);
    expect(find.textContaining('Do not pay again yet'), findsOneWidget);
    expect(find.text('Open Telegram'), findsOneWidget);
  });

  testWidgets('popup fits a small screen with larger text', (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(localized(const ManualPaymentDialog()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Amharic popup uses regenerated translations', (tester) async {
    await tester.pumpWidget(localized(const ManualPaymentDialog(), 'am'));
    await tester.pumpAndSettle();
    expect(find.text('ቴሌግራም ክፈት'), findsOneWidget);
    expect(find.text('1000322464669'), findsOneWidget);
  });

  testWidgets('failed initiation shows popup automatically on payment page',
      (tester) async {
    status.connected = false;
    await tester.pumpWidget(localized(const PaymentView(
        phone: '911234567', method: PaymentMethod.sdk, subscription: plan)));
    await tester.pumpAndSettle();
    expect(find.byType(ManualPaymentDialog), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(navigation.backs, 1);
    expect(api.requests, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Telegram launch uses the supplied support URL', (tester) async {
    const channel = MethodChannel('plugins.flutter.io/url_launcher');
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel,
        (call) async {
      calls.add(call);
      return true;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null));
    await tester.pumpWidget(localized(const ManualPaymentDialog()));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Open Telegram'));
    await tester.tap(find.text('Open Telegram'));
    await tester.pumpAndSettle();
    expect(calls.single.arguments['url'], 'https://t.me/yimarusup');
  });
}
