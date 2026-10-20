import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/services/ios_premium_checkout_flow.dart';

void main() {
  test('missing phone is saved before notice, then sends exactly once',
      () async {
    final calls = <String>[];
    var missing = true;
    await IosPremiumCheckoutFlow().run(
      isCurrent: () => true,
      needsPhone: () => missing,
      collectPhone: () async {
        calls.add('phone');
        missing = false;
        return true;
      },
      confirmHardcopy: () async {
        calls.add('hardcopy');
        return true;
      },
      sendLink: () async {
        calls.add('send');
      },
    );
    expect(calls, ['phone', 'hardcopy', 'send']);
  });

  for (final stage in ['contact', 'notice', 'account', 'unsaved']) {
    test('$stage cancellation prevents sending', () async {
      var current = true;
      var missing = stage != 'notice';
      var sends = 0;
      await IosPremiumCheckoutFlow().run(
        isCurrent: () => current,
        needsPhone: () => missing,
        collectPhone: () async {
          if (stage == 'contact') return false;
          if (stage == 'account') current = false;
          if (stage != 'unsaved') missing = false;
          return true;
        },
        confirmHardcopy: () async => false,
        sendLink: () async {
          sends++;
        },
      );
      expect(sends, 0);
    });
  }

  test('account changes while notice is open prevent delivery', () async {
    var current = true;
    var sends = 0;
    await IosPremiumCheckoutFlow().run(
      isCurrent: () => current,
      needsPhone: () => false,
      collectPhone: () async => fail('must not collect existing phone'),
      confirmHardcopy: () async {
        current = false;
        return true;
      },
      sendLink: () async {
        sends++;
      },
    );
    expect(sends, 0);
  });

  test('multiple entry points cannot open duplicate sequences', () async {
    final flow = IosPremiumCheckoutFlow();
    final notice = Completer<bool>();
    var notices = 0;
    var sends = 0;
    Future<void> open() => flow.run(
          isCurrent: () => true,
          needsPhone: () => false,
          collectPhone: () async => false,
          confirmHardcopy: () {
            notices++;
            return notice.future;
          },
          sendLink: () async {
            sends++;
          },
        );
    final first = open();
    await open();
    expect(notices, 1);
    notice.complete(true);
    await first;
    expect(sends, 1);
  });

  test('failure releases the guard without retrying delivery', () async {
    final flow = IosPremiumCheckoutFlow();
    var sends = 0;
    Future<void> open() => flow.run(
          isCurrent: () => true,
          needsPhone: () => false,
          collectPhone: () async => false,
          confirmHardcopy: () async => true,
          sendLink: () async {
            sends++;
            throw StateError('offline');
          },
        );
    await expectLater(open(), throwsStateError);
    expect(sends, 1);
    await expectLater(open(), throwsStateError);
    expect(sends, 2);
  });

  test(
      'new session supersedes pending old delivery; late old finally cannot unlock it',
      () async {
    final flow = IosPremiumCheckoutFlow();
    final oldDelivery = Completer<void>();
    final newDelivery = Completer<void>();
    var session = 1;
    var notices = 0;
    var cancelledOld = false;
    final old = flow.run(
        isCurrent: () => session == 1,
        needsPhone: () => false,
        collectPhone: () async => false,
        confirmHardcopy: () async => true,
        sendLink: () => oldDelivery.future,
        onSuperseded: () => cancelledOld = true);
    await Future<void>.delayed(Duration.zero);
    session = 2;
    Future<void> open() => flow.run(
        isCurrent: () => session == 2,
        needsPhone: () => false,
        collectPhone: () async => false,
        confirmHardcopy: () async {
          notices++;
          return true;
        },
        sendLink: () => newDelivery.future);
    final next = open();
    await Future<void>.delayed(Duration.zero);
    expect(cancelledOld, isTrue);
    expect(notices, 1);
    oldDelivery.complete();
    await old;
    await open(); // Must not start a duplicate while session 2 is still pending.
    expect(notices, 1);
    newDelivery.complete();
    await next;
  });
}
