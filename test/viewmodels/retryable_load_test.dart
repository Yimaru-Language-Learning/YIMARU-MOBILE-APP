import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/retryable_load.dart';

void main() {
  test('failed reads record an error; successful retry clears it', () async {
    final model = BaseViewModel();
    addTearDown(model.dispose);
    await model.runReadLoad(() async => throw StateError('server failed'),
        busyObject: 'content');
    expect(model.hasErrorForKey('content'), isTrue);
    expect(model.busy('content'), isFalse);
    await model.runReadLoad(() async {}, busyObject: 'content');
    expect(model.hasErrorForKey('content'), isFalse);
    expect(model.busy('content'), isFalse);
  });

  test('repeated taps do not start concurrent reads', () async {
    final model = BaseViewModel();
    addTearDown(model.dispose);
    final pending = Completer<void>();
    var calls = 0;
    Future<void> load() {
      calls++;
      return pending.future;
    }

    final first = model.runReadLoad(load, busyObject: 'content');
    await model.runReadLoad(load, busyObject: 'content');
    expect(calls, 1);
    expect(model.busy('content'), isTrue);
    pending.complete();
    await first;
    expect(model.busy('content'), isFalse);
  });

  test('synchronous failures are captured too', () async {
    final model = BaseViewModel();
    addTearDown(model.dispose);
    await model.runReadLoad(() => throw StateError('synchronous error'),
        busyObject: 'content');
    expect(model.hasErrorForKey('content'), isTrue);
    expect(model.busy('content'), isFalse);
  });

  test('independent read keys do not block one another', () async {
    final model = BaseViewModel();
    addTearDown(model.dispose);
    final pending = Completer<void>();
    final first = model.runReadLoad(() => pending.future, busyObject: 1);
    var ran = false;
    await model.runReadLoad(() async => ran = true, busyObject: 2);
    expect(ran, isTrue);
    pending.complete();
    await first;
  });

  test('disposed models cannot start another read', () async {
    final model = BaseViewModel()..dispose();
    var calls = 0;
    await model.runReadLoad(() async => calls++, busyObject: 'content');
    expect(calls, 0);
  });
}
