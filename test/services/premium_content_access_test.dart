import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/access.dart';
import 'package:yimaru_app/models/active_subscription.dart';
import 'package:yimaru_app/models/learn_course.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/models/learn_program.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/premium_purchase_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

class _Auth implements AuthenticationService {
  @override
  User? user = const User(userId: 7);
  @override
  int sessionGeneration = 1;
  @override
  Future<void> saveContactPhone(String phone,
      {required int expectedSessionGeneration}) async {
    if (expectedSessionGeneration == sessionGeneration) {
      user = user?.copyWith(phoneNumber: phone);
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Purchase extends PremiumPurchaseService {
  final calls = <SubscriptionType>[];
  @override
  Future<void> open(SubscriptionType type, {BuildContext? context}) async {
    calls.add(type);
  }
}

class _Api implements ApiService {
  User profile = const User(userId: 7);
  bool failRead = false;
  Completer<void>? readGate;
  @override
  Future<Map<String, dynamic>> getProfileData(int? id) async {
    await readGate?.future;
    return {
      'status': failRead ? ResponseStatus.failure : ResponseStatus.success,
      'data': profile,
    };
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _Auth auth;
  late _Purchase purchase;
  late _Api api;
  setUp(() {
    auth = _Auth();
    purchase = _Purchase();
    api = _Api();
    locator.registerSingleton<AuthenticationService>(auth);
    locator.registerSingleton<PremiumPurchaseService>(purchase);
    locator.registerSingleton<ApiService>(api);
  });
  tearDown(() => locator.reset());

  for (final type in SubscriptionType.values) {
    test('$type premium opens shared flow; free/prerequisite/subscribed do not',
        () async {
      Future<bool> tap(
              {bool isIOS = true,
              String? tier = 'PREMIUM',
              bool accessible = true}) =>
          interceptIosPremium(type,
              effectiveAccessTier: tier,
              access: Access(isAccessible: accessible),
              isIOS: isIOS);
      expect(await tap(), isTrue);
      expect(purchase.calls, [type]);
      expect(await tap(tier: 'FREE'), isFalse);
      expect(await tap(tier: null), isFalse);
      expect(await tap(accessible: false), isFalse);
      expect(await tap(isIOS: false), isFalse);
      auth.user = User(
          userId: 7,
          learn: type == SubscriptionType.learn,
          ielts: type == SubscriptionType.ielts,
          duolingo: type == SubscriptionType.duolingo);
      expect(await tap(), isFalse);
      expect(purchase.calls, [type]);
    });
  }

  test(
      'a web subscription beats stale local flags; phone cache is recovered only for its account',
      () async {
    api.profile = const User(userId: 7, activeSubscriptions: [
      ActiveSubscription(category: 'LEARN_ENGLISH', status: 'ACTIVE'),
    ]);
    expect(
        await interceptIosPremium(SubscriptionType.learn,
            effectiveAccessTier: 'PREMIUM', isIOS: true),
        isFalse);
    expect(purchase.calls, isEmpty);
    api.profile = const User(userId: 7, phoneNumber: '251912345678');
    expect(
        await interceptIosPremium(SubscriptionType.learn,
            effectiveAccessTier: 'PREMIUM', isIOS: true),
        isTrue);
    expect(auth.user?.phoneNumber, '251912345678');
    expect(purchase.calls, [SubscriptionType.learn]);
  });

  test(
      'a failed entitlement read blocks navigation without advertising a purchase',
      () async {
    api.failRead = true;
    expect(
        await interceptIosPremium(SubscriptionType.learn,
            effectiveAccessTier: 'PREMIUM', isIOS: true),
        isTrue);
    expect(purchase.calls, isEmpty);
  });

  test('Learn models retain inherited effective tier on decoding/copy/encoding',
      () {
    const payload = {'id': 1, 'effective_access_tier': 'PREMIUM'};
    final objects = [
      LearnProgram.fromJson(payload).copyWith(),
      LearnCourse.fromJson(payload).copyWith(),
      LearnModule.fromJson(payload).copyWith(),
      LearnLesson.fromJson(payload).copyWith(),
    ];
    for (final dynamic model in objects) {
      expect(model.effectiveAccessTier, 'PREMIUM');
      expect(model.toJson()['effective_access_tier'], 'PREMIUM');
    }
    expect(LearnLesson.fromJson({'id': 1}).effectiveAccessTier, isNull);
  });

  test('account change during entitlement check cancels the old tap', () async {
    api.readGate = Completer<void>();
    final request = interceptIosPremium(SubscriptionType.learn,
        effectiveAccessTier: 'PREMIUM', isIOS: true);
    auth.sessionGeneration++;
    auth.user = const User(userId: 8);
    api.readGate!.complete();
    expect(await request, isTrue);
    expect(auth.user?.phoneNumber, isNull);
    expect(purchase.calls, isEmpty);
  });
}
