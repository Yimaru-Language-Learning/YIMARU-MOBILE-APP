import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/course_practice.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/premium_purchase_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/codegen_loader.g.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/course_practices_screens.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_intro_screen.dart';

class _Auth implements AuthenticationService {
  @override
  User? user = const User(userId: 7);
  @override
  int sessionGeneration = 1;
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
  @override
  Future<Map<String, dynamic>> getCheckoutPhone(
          {CancelToken? cancelToken}) async =>
      {'phone_number': '251912345678', 'verified': true};
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

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

// Keep the production Start-button callbacks and purchase service; only replace
// question loading and external services. Unexpected API calls fail the test.
class _LearnModel extends ReactiveViewModel implements LearnPracticeViewModel {
  int starts = 0;
  @override
  User? get user => locator<AuthenticationService>().user;
  @override
  void goTo(int page) {
    expect(page, 1);
    starts++;
  }

  @override
  Future<void> navigateToLearnSubscription({BuildContext? context}) =>
      locator<PremiumPurchaseService>()
          .open(SubscriptionType.learn, context: context);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ExamModel extends ReactiveViewModel implements CoursePracticeViewModel {
  int starts = 0;
  @override
  User? get user => locator<AuthenticationService>().user;
  @override
  List<CoursePractice> get practices =>
      const [CoursePractice(id: 52, questionSetId: 91, title: 'Test practice')];
  @override
  Future<void> updatePaymentStatus() async {}
  @override
  void resetValues() {}
  @override
  Future<void> getCoursePracticeQuestions(
      {required int id, required BuildContext context}) async {
    expect(id, 91);
    starts++;
  }

  @override
  Future<void> navigateToCourseSubscription(SubscriptionType type,
          {BuildContext? context}) =>
      locator<PremiumPurchaseService>().open(type, context: context);
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
  tearDownAll(() => TestDefaultBinaryMessengerBinding
      .instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/shared_preferences'), null));

  for (final isIOS in [false, true]) {
    for (final type in SubscriptionType.values) {
      for (final subscribed in [false, true]) {
        testWidgets(
            '${isIOS ? 'iOS' : 'Android'} $type Start requires category subscription ($subscribed)',
            (tester) async {
          final auth = _Auth();
          // Another category subscription must not grant access to this one.
          auth.user = User(
              userId: 7,
              phoneNumber: '251912345678',
              learn: type == SubscriptionType.learn ? subscribed : true,
              ielts: type == SubscriptionType.ielts ? subscribed : true,
              duolingo: type == SubscriptionType.duolingo ? subscribed : true);
          final api = _Api();
          final navigation = _Navigation();
          final learn = _LearnModel();
          final exam = _ExamModel();
          final phone = TextEditingController();
          final practice = TextEditingController();
          locator.registerSingleton<AuthenticationService>(auth);
          locator.registerSingleton<ApiService>(api);
          locator.registerSingleton<NavigationService>(navigation);
          locator.registerSingleton<PremiumPurchaseService>(
              PremiumPurchaseService(isIOS: isIOS));
          addTearDown(() async {
            learn.dispose();
            exam.dispose();
            phone.dispose();
            practice.dispose();
            await locator.reset();
          });

          await tester.pumpWidget(EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('am')],
            startLocale: const Locale('en'),
            saveLocale: false,
            path: 'assets/translations',
            assetLoader: const CodegenLoader(),
            child: Builder(
                builder: (context) => MaterialApp(
                      locale: context.locale,
                      supportedLocales: context.supportedLocales,
                      localizationsDelegates: context.localizationDelegates,
                      home: Builder(
                          builder: (context) => type == SubscriptionType.learn
                              ? LearnPracticeIntroScreen(
                                      label: 'Start',
                                      title: 'Test practice',
                                      subtitle: 'Practice',
                                      practice: LearnPractices.lesson,
                                      phoneNumberController: phone)
                                  .build(context, learn)
                              : CoursePracticesScreens(
                                      type: type,
                                      practiceController: practice,
                                      phoneNumberController: phone)
                                  .build(context, exam)),
                    )),
          ));
          await tester.pumpAndSettle();
          final start = find.text(type == SubscriptionType.learn
              ? 'Start'
              : tr(LocaleKeys.take_assessment));
          await tester.ensureVisible(start);
          await tester.tap(start);
          await tester.pumpAndSettle();
          expect(learn.starts + exam.starts, subscribed ? 1 : 0);
          expect(api.events, isEmpty);
          if (subscribed) {
            expect(navigation.categories, isEmpty);
            expect(find.byType(AlertDialog), findsNothing);
          } else if (isIOS) {
            expect(navigation.categories, isEmpty);
            expect(find.textContaining('arrange delivery'), findsOneWidget);
            await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
            await tester.pumpAndSettle();
            expect(learn.starts + exam.starts, 0);
            expect(find.byType(AlertDialog), findsNothing);
          } else {
            expect(navigation.categories, [type]);
            expect(find.byType(AlertDialog), findsNothing);
          }
          expect(tester.takeException(), isNull);
        });
      }
    }
  }
}
