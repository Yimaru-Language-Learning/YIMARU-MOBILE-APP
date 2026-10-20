import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/models/active_subscription.dart';
import 'package:yimaru_app/models/my_subscription.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/premium_purchase_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/codegen_loader.g.dart';
import 'package:yimaru_app/ui/views/my_subscription/my_subscription_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/my_subscription_card.dart';

class _Navigation extends NavigationService {
  final categories = <SubscriptionType>[];
  @override
  Future<T?>? navigateTo<T>(String routeName,
      {dynamic arguments,
      int? id,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      RouteTransitionsBuilder? transition}) async {
    expect(routeName, Routes.subscriptionView);
    categories.add((arguments as SubscriptionViewArguments).type);
    return null;
  }
}

class _Status implements StatusCheckerService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Auth implements AuthenticationService {
  @override
  int sessionGeneration = 1;
  @override
  User? user = const User(userId: 7);
  @override
  Future<void> saveContactPhone(String phone,
      {required int expectedSessionGeneration}) async {
    if (sessionGeneration == expectedSessionGeneration) {
      user = user?.copyWith(phoneNumber: phone);
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Api implements ApiService {
  final events = <String>[];
  bool failSave = false;
  bool conflictSave = false;
  Completer<String>? delayedSave;
  Completer<Map<String, dynamic>>? delayedDelivery;
  Completer<Map<String, dynamic>>? delayedProfile;
  final tokens = <CancelToken?>[];
  bool failRead = false;
  bool? phoneVerified;
  bool failPhoneStatus = false;
  bool failCodeSend = false;
  int codeSends = 0;
  final verifiedCodes = <String>[];
  bool loseVerificationResponse = false;
  Map<String, dynamic>? serverPhone;
  @override
  Future<Map<String, dynamic>> getCheckoutPhone(
      {CancelToken? cancelToken}) async {
    if (failPhoneStatus) throw StateError('status unavailable');
    if (serverPhone != null) return serverPhone!;
    final phone =
        locator<AuthenticationService>().user?.phoneNumber?.trim() ?? '';
    return {
      'phone_number': phone,
      'verified': phoneVerified ?? phone.isNotEmpty
    };
  }

  @override
  Future<void> sendCheckoutPhoneCode(String phone,
      {CancelToken? cancelToken}) async {
    codeSends++;
    if (failCodeSend) throw StateError('SMS unavailable');
  }

  @override
  Future<String> verifyCheckoutPhone(String phone, String code,
      {CancelToken? cancelToken}) async {
    verifiedCodes.add(code);
    if (code != '123456') throw StateError('invalid code');
    if (loseVerificationResponse) {
      serverPhone = {'phone_number': phone, 'verified': true};
      throw DioException(
          requestOptions: RequestOptions(path: '/verify'),
          type: DioExceptionType.receiveTimeout);
    }
    return addContactPhone(phone, cancelToken: cancelToken);
  }

  bool malformedRead = false;
  User profile = const User(userId: 7);
  Map<String, dynamic> result = {
    'status': ResponseStatus.success,
    'channel': 'sms'
  };
  @override
  Future<String> addContactPhone(String phone,
      {CancelToken? cancelToken}) async {
    events.add('save:$phone');
    if (failSave) throw StateError('offline');
    if (conflictSave) {
      final request = RequestOptions(path: '/user/contact-phone');
      throw DioException(
          requestOptions: request,
          response: Response(requestOptions: request, statusCode: 409));
    }
    return delayedSave == null ? phone : await delayedSave!.future;
  }

  @override
  Future<Map<String, dynamic>> iosCheckout(Map<String, dynamic> data,
      {CancelToken? cancelToken}) async {
    tokens.add(cancelToken);
    events.add('send:${data['category']}');
    return delayedDelivery == null ? result : await delayedDelivery!.future;
  }

  @override
  Future<Map<String, dynamic>> getProfileData(int? id) async {
    events.add('profile');
    if (delayedProfile != null) return delayedProfile!.future;
    if (malformedRead) throw const FormatException('private response');
    return {
      'status': failRead ? ResponseStatus.failure : ResponseStatus.success,
      'data': profile
    };
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

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
  late _Auth auth;
  late _Api api;
  late PremiumPurchaseService service;
  setUp(() {
    auth = _Auth();
    api = _Api();
    service = PremiumPurchaseService(isIOS: true);
    locator.registerSingleton<AuthenticationService>(auth);
    locator.registerSingleton<ApiService>(api);
    locator.registerSingleton<PremiumPurchaseService>(service);
  });
  tearDown(() => locator.reset());

  Future<void> open(WidgetTester tester,
      {SubscriptionType type = SubscriptionType.learn,
      String language = 'en',
      double scale = 1,
      bool checkAccess = false,
      bool invalidOrigin = false,
      bool subscriptionCard = false}) async {
    MySubscriptionViewModel? subscriptions;
    if (subscriptionCard) {
      locator.registerSingleton<NavigationService>(_Navigation());
      locator.registerSingleton<StatusCheckerService>(_Status());
      subscriptions = MySubscriptionViewModel();
      addTearDown(subscriptions.dispose);
    }
    await tester.pumpWidget(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('am')],
      startLocale: Locale(language),
      saveLocale: false,
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: Builder(
          builder: (context) => MaterialApp(
                navigatorKey: StackedService.navigatorKey,
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.linear(scale)),
                    child: child!),
                home: Scaffold(
                    body: Builder(
                        builder: (context) => subscriptionCard
                            ? MySubscriptionCard(
                                    subscription: MySubscription(
                                        category: switch (type) {
                                          SubscriptionType.learn =>
                                            'LEARN_ENGLISH',
                                          SubscriptionType.ielts => 'IELTS',
                                          SubscriptionType.duolingo =>
                                            'DUOLINGO',
                                        },
                                        planName: 'Test plan',
                                        status: 'EXPIRED',
                                        startsAt: '2026-10-01',
                                        expiresAt: '2026-10-10'))
                                .build(context, subscriptions!)
                            : TextButton(
                                onPressed: () async {
                                  if (checkAccess) {
                                    final allowed = !await interceptIosPremium(
                                        type,
                                        effectiveAccessTier: 'PREMIUM',
                                        context: context,
                                        isIOS: true);
                                    if (allowed && context.mounted) {
                                      unawaited(Navigator.of(context)
                                          .push<void>(MaterialPageRoute(
                                              builder: (_) => const Scaffold(
                                                  body: Text(
                                                      'Content opened')))));
                                    }
                                  } else {
                                    await service.open(type,
                                        context: invalidOrigin
                                            ? StackedService
                                                .navigatorKey!.currentContext
                                            : context);
                                  }
                                },
                                child: const Text('Premium')))),
              )),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text(subscriptionCard ? 'Resubscribe' : 'Premium'));
    await tester.pumpAndSettle();
  }

  Future<void> continueDialog(WidgetTester tester) async {
    final send = find.widgetWithText(TextButton, 'Send verification code');
    if (send.evaluate().isNotEmpty) {
      await tester.ensureVisible(send);
      await tester.tap(send);
      await tester.pumpAndSettle();
      if (find.widgetWithText(TextButton, 'Verify number').evaluate().isEmpty) {
        return;
      }
    }
    final verify = find.widgetWithText(TextButton, 'Verify number');
    if (verify.evaluate().isNotEmpty) {
      await tester.enterText(find.byType(TextFormField).last, '123456');
      await tester.ensureVisible(verify);
      await tester.tap(verify);
      await tester.pumpAndSettle();
      return;
    }
    await tester.ensureVisible(find.widgetWithText(TextButton, 'Continue'));
    await tester.tap(find.widgetWithText(TextButton, 'Continue'));
    await tester.pumpAndSettle();
  }

  testWidgets(
      'missing phone → saved phone → hardcopy → SMS; reopening skips phone',
      (tester) async {
    await open(tester);
    expect(find.text('Profile completion'), findsOneWidget);
    expect(api.events, isEmpty);
    await tester.enterText(find.byType(TextFormField), '912345678');
    await continueDialog(tester);
    expect(api.events, ['save:251912345678']);
    expect(find.textContaining('arrange delivery'), findsOneWidget);
    await continueDialog(tester);
    expect(api.events.last, 'send:LEARN_ENGLISH');
    expect(find.textContaining('sent by SMS'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Close'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Premium'));
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNothing);
    expect(find.textContaining('arrange delivery'), findsOneWidget);
  });

  for (final type in [SubscriptionType.ielts, SubscriptionType.duolingo]) {
    testWidgets('$type existing phone → hardcopy → correct category/SMS',
        (tester) async {
      auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
      api.result['channel'] = 'sms';
      await open(tester, type: type);
      expect(find.byType(TextFormField), findsNothing);
      await continueDialog(tester);
      expect(api.events,
          ['send:${type == SubscriptionType.ielts ? 'IELTS' : 'DUOLINGO'}']);
      expect(find.textContaining('sent by SMS'), findsOneWidget);
    });
  }

  testWidgets('invalid phone and failed save do not advance or change profile',
      (tester) async {
    await open(tester);
    await tester.enterText(find.byType(TextFormField), '123');
    await continueDialog(tester);
    expect(find.textContaining('9-digit'), findsOneWidget);
    expect(api.events, isEmpty);
    api.failSave = true;
    await tester.enterText(find.byType(TextFormField), '712345678');
    await continueDialog(tester);
    expect(find.textContaining('Could not verify this code'), findsOneWidget);
    expect(auth.user?.phoneNumber, isNull);
    expect(find.textContaining('arrange delivery'), findsNothing);
    api.failSave = false;
    await continueDialog(tester);
    expect(find.textContaining('arrange delivery'), findsOneWidget);
  });

  for (final hasPhone in [false, true]) {
    testWidgets('cancel with existing phone=$hasPhone never sends',
        (tester) async {
      if (hasPhone) {
        auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
      }
      await open(tester);
      await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      await tester.pumpAndSettle();
      expect(api.events, isEmpty);
      expect(find.byType(AlertDialog), findsNothing);
    });
  }

  testWidgets('navigator/root or missing context cannot launch iOS checkout',
      (tester) async {
    auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
    await open(tester, invalidOrigin: true);
    expect(find.byType(AlertDialog), findsNothing);
    await service.open(SubscriptionType.learn);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(api.events, isEmpty);
  });

  for (final type in SubscriptionType.values) {
    testWidgets('Android My Subscriptions $type keeps normal navigation',
        (tester) async {
      service = PremiumPurchaseService(isIOS: false);
      locator.unregister<PremiumPurchaseService>();
      locator.registerSingleton<PremiumPurchaseService>(service);
      await open(tester, type: type, subscriptionCard: true);
      expect((locator<NavigationService>() as _Navigation).categories, [type]);
      expect(find.byType(AlertDialog), findsNothing);
      expect(api.events, isEmpty);
    });

    testWidgets('My Subscriptions $type tracks its originating screen',
        (tester) async {
      auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
      api.delayedDelivery = Completer<Map<String, dynamic>>();
      await open(tester, type: type, subscriptionCard: true);
      expect(find.textContaining('arrange delivery'), findsOneWidget);
      await continueDialog(tester);
      final navigator = StackedService.navigatorKey!.currentState!;
      unawaited(navigator.push<void>(MaterialPageRoute(
          builder: (_) => const Scaffold(body: Text('Another page')))));
      await tester.pumpAndSettle();
      api.delayedDelivery!.complete(api.result);
      await tester.pumpAndSettle();
      expect(find.text('Another page'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      expect(api.events, [
        switch (type) {
          SubscriptionType.learn => 'send:LEARN_ENGLISH',
          SubscriptionType.ielts => 'send:IELTS',
          SubscriptionType.duolingo => 'send:DUOLINGO',
        }
      ]);
    });
  }

  testWidgets('a new screen can supersede a pending old-screen checkout',
      (tester) async {
    auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
    final oldReply = Completer<Map<String, dynamic>>();
    api.delayedDelivery = oldReply;
    await open(tester);
    await continueDialog(tester);
    api.delayedDelivery = null;
    unawaited(StackedService.navigatorKey!.currentState!.push<void>(
        MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Builder(
                    builder: (context) => TextButton(
                        onPressed: () => service.open(SubscriptionType.ielts,
                            context: context),
                        child: const Text('New purchase')))))));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New purchase'));
    await tester.pumpAndSettle();
    expect(api.tokens.single?.isCancelled, isTrue);
    expect(find.textContaining('arrange delivery'), findsOneWidget);
    await continueDialog(tester);
    oldReply.complete({'status': ResponseStatus.success, 'channel': 'email'});
    await tester.pumpAndSettle();
    expect(find.textContaining('sent by email'), findsNothing);
    expect(find.textContaining('sent by SMS'), findsOneWidget);
    expect(api.events, ['send:LEARN_ENGLISH', 'send:IELTS']);
  });

  testWidgets(
      'account switch during phone save cannot send or overwrite new account',
      (tester) async {
    api.delayedSave = Completer<String>();
    await open(tester);
    await tester.enterText(find.byType(TextFormField), '912345678');
    await continueDialog(tester);
    auth.sessionGeneration++;
    auth.user = const User(userId: 8, phoneNumber: '251712345678');
    api.delayedSave!.complete('251912345678');
    await tester.pumpAndSettle();
    expect(auth.user?.phoneNumber, '251712345678');
    expect(api.events, ['save:251912345678']);
    expect(find.textContaining('arrange delivery'), findsNothing);
  });

  testWidgets('blank phone is missing; Amharic dialog scrolls with large text',
      (tester) async {
    auth.user = auth.user?.copyWith(phoneNumber: '  ');
    tester.view.physicalSize = const Size(375, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await open(tester, language: 'am', scale: 1.6);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('የመገለጫ ማጠናቀቂያ'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final hasPhone in [false, true]) {
    testWidgets('outside dismissal with phone=$hasPhone never sends',
        (tester) async {
      if (hasPhone) {
        auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
      }
      await open(tester);
      await tester.tapAt(const Offset(4, 4));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(api.events, isEmpty);
    });
  }

  testWidgets(
      'leaving during link delivery never opens feedback on another page',
      (tester) async {
    auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
    api.delayedDelivery = Completer<Map<String, dynamic>>();
    await open(tester);
    await continueDialog(tester);
    final navigator =
        tester.state<NavigatorState>(find.byType(Navigator).first);
    unawaited(navigator.push<void>(MaterialPageRoute(
        builder: (_) => const Scaffold(body: Text('Another page')))));
    await tester.pumpAndSettle();
    api.delayedDelivery!.complete(api.result);
    await tester.pumpAndSettle();
    expect(find.text('Another page'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(api.events, ['send:LEARN_ENGLISH']);
  });

  for (final status in [409, 429, 503]) {
    testWidgets(
        'checkout HTTP $status shows feedback without claiming delivery',
        (tester) async {
      auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
      api.result = {'status': ResponseStatus.failure, 'statusCode': status};
      await open(tester);
      await continueDialog(tester);
      expect(find.textContaining('sent by SMS'), findsNothing);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(api.events, ['send:LEARN_ENGLISH']);
    });
  }

  for (final malformed in [false, true]) {
    testWidgets(
        'failed/malformed access check blocks video; Retry only rechecks access ($malformed)',
        (tester) async {
      api.failRead = !malformed;
      api.malformedRead = malformed;
      await open(tester, checkAccess: true);
      expect(find.text('Content opened'), findsNothing);
      expect(
          find.textContaining('could not check your access'), findsOneWidget);
      expect(find.textContaining('arrange delivery'), findsNothing);
      expect(api.events, ['profile']);
      await tester.tap(find.widgetWithText(TextButton, 'Retry'));
      await tester.pumpAndSettle();
      expect(find.text('Content opened'), findsNothing);
      expect(api.events, ['profile', 'profile']);
      api.failRead = false;
      api.malformedRead = false;
      api.profile = const User(userId: 7, activeSubscriptions: [
        ActiveSubscription(category: 'LEARN_ENGLISH', status: 'ACTIVE')
      ]);
      await tester.tap(find.widgetWithText(TextButton, 'Retry'));
      await tester.pumpAndSettle();
      expect(find.text('Content opened'), findsOneWidget);
      expect(api.events, ['profile', 'profile', 'profile']);
    });
  }

  testWidgets(
      'closing a failed access check cannot open content or send a link',
      (tester) async {
    api.failRead = true;
    await open(tester, checkAccess: true);
    await tester.tap(find.widgetWithText(TextButton, 'Close'));
    await tester.pumpAndSettle();
    expect(find.text('Content opened'), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(api.events, ['profile']);
  });

  testWidgets(
      'new account starts immediately while old delivery is pending; old result stays hidden',
      (tester) async {
    auth.user = auth.user?.copyWith(phoneNumber: '251912345678');
    final oldReply = Completer<Map<String, dynamic>>();
    api.delayedDelivery = oldReply;
    await open(tester);
    await continueDialog(tester);
    auth.sessionGeneration++;
    auth.user = const User(userId: 8, phoneNumber: '251712345678');
    api.delayedDelivery = null;
    await tester.tap(find.text('Premium'));
    await tester.pumpAndSettle();
    expect(find.textContaining('arrange delivery'), findsOneWidget);
    expect(api.tokens.single?.isCancelled, isTrue);
    await continueDialog(tester);
    expect(find.textContaining('sent by SMS'), findsOneWidget);
    oldReply.complete({'status': ResponseStatus.success, 'channel': 'email'});
    await tester.pumpAndSettle();
    expect(find.textContaining('sent by email'), findsNothing);
    expect(find.textContaining('sent by SMS'), findsOneWidget);
    expect(api.events, ['send:LEARN_ENGLISH', 'send:LEARN_ENGLISH']);
  });

  testWidgets('an existing unverified phone still requires an SMS code',
      (tester) async {
    auth.user = auth.user
        ?.copyWith(phoneNumber: '251712345678', email: 'verified@example.test');
    api.phoneVerified = false;
    await open(tester);
    expect(find.text('Profile completion'), findsOneWidget);
    expect(find.textContaining('arrange delivery'), findsNothing);
    await continueDialog(tester);
    expect(api.codeSends, 1);
    expect(api.verifiedCodes, ['123456']);
    expect(find.textContaining('arrange delivery'), findsOneWidget);
    expect(api.events.where((e) => e.startsWith('send:')), isEmpty);
  });

  testWidgets(
      'bad code and premature resend never advance or send a checkout link',
      (tester) async {
    await open(tester);
    await tester.enterText(find.byType(TextFormField), '712345678');
    await tester.tap(find.widgetWithText(TextButton, 'Send verification code'));
    await tester.pumpAndSettle();
    expect(auth.user?.phoneNumber, isNull);
    await tester.enterText(find.byType(TextFormField).last, '000000');
    await tester.tap(find.widgetWithText(TextButton, 'Verify number'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Could not verify this code'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Resend code'));
    await tester.pumpAndSettle();
    expect(api.codeSends, 1);
    expect(find.textContaining('60 seconds'), findsOneWidget);
    expect(api.events, isEmpty);
  });

  testWidgets(
      'verification SMS failure leaves the phone unchanged and never sends a link',
      (tester) async {
    api.failCodeSend = true;
    await open(tester);
    await tester.enterText(find.byType(TextFormField), '912345678');
    await continueDialog(tester);
    expect(find.textContaining('Could not confirm the verification SMS'),
        findsOneWidget);
    expect(api.codeSends, 1);
    expect(api.verifiedCodes, isEmpty);
    expect(auth.user?.phoneNumber, isNull);
    expect(api.events, isEmpty);
  });

  testWidgets(
      'phone status failure retries only its GET before showing verification',
      (tester) async {
    api.failPhoneStatus = true;
    await open(tester);
    expect(find.text('Retry'), findsOneWidget);
    api.failPhoneStatus = false;
    await tester.tap(find.widgetWithText(TextButton, 'Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Profile completion'), findsOneWidget);
    expect(api.codeSends, 0);
    expect(api.events, isEmpty);
  });

  testWidgets(
      'a lost verification response is reconciled by a GET, never another SMS',
      (tester) async {
    api.loseVerificationResponse = true;
    await open(tester);
    await tester.enterText(find.byType(TextFormField), '712345678');
    await continueDialog(tester);
    expect(api.codeSends, 1);
    expect(api.verifiedCodes, ['123456']);
    expect(auth.user?.phoneNumber, '251712345678');
    expect(find.textContaining('arrange delivery'), findsOneWidget);
    expect(api.events, isEmpty);
  });
}
