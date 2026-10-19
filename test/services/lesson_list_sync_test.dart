import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/services/lesson_list_sync.dart';

void main() {
  testWidgets(
      'burst events coalesce and failed refreshes preserve the snapshot',
      (tester) async {
    var calls = 0;
    var fail = false;
    var snapshot = <int>[];
    final sync = LessonListSync<int>(
      fetch: (_) async {
        calls++;
        if (fail) throw StateError('offline');
        return [calls];
      },
      apply: (rows) => snapshot = rows,
    );
    addTearDown(sync.reset);
    await sync.load(45);
    expect(snapshot, [1]);
    sync.changed();
    sync.changed();
    sync.changed();
    await tester.pump(const Duration(milliseconds: 299));
    expect(calls, 1);
    await tester.pump(const Duration(milliseconds: 1));
    expect(calls, 2);
    expect(snapshot, [2]);
    fail = true;
    await sync.refresh();
    expect(snapshot, [2]);
    expect(sync.lastError, isA<StateError>());
    fail = false;
    await tester.pump(const Duration(seconds: 2));
    expect(snapshot, [4]);
    expect(sync.lastError, isNull);
  });

  testWidgets('an edit during a fetch runs one follow-up without overlapping',
      (tester) async {
    final first = Completer<List<int>>();
    final next = Completer<List<int>>();
    var calls = 0;
    var snapshot = <int>[];
    final sync = LessonListSync<int>(
      fetch: (_) {
        calls++;
        return calls == 1 ? first.future : next.future;
      },
      apply: (rows) => snapshot = rows,
    );
    addTearDown(sync.reset);
    final load = sync.load(1);
    sync.changed();
    sync.changed();
    await tester.pump(const Duration(seconds: 1));
    expect(calls, 1);
    first.complete([1]);
    await tester.pump();
    expect(calls, 2);
    next.complete([2]);
    await tester.pump();
    await load;
    expect(snapshot, [2]);
  });

  testWidgets(
      'old module and old session responses cannot overwrite current data',
      (tester) async {
    final old = Completer<List<int>>();
    var snapshot = <int>[];
    final sync = LessonListSync<int>(
      fetch: (id) => id == 1 ? old.future : Future.value([id]),
      apply: (rows) => snapshot = rows,
    );
    addTearDown(sync.reset);
    final previous = sync.load(1);
    await sync.load(2);
    old.complete([1]);
    await tester.pump();
    await previous;
    expect(snapshot, [2]);
    expect(sync.loadedModuleId, 2);
    final session = Completer<List<int>>();
    final sessionSync = LessonListSync<int>(
        fetch: (_) => session.future, apply: (rows) => snapshot = rows);
    final pending = sessionSync.load(1);
    sessionSync.reset();
    session.complete([99]);
    await tester.pump();
    await pending;
    expect(snapshot, isEmpty);
    expect(sessionSync.loadedModuleId, isNull);
  });

  testWidgets(
      'empty success clears data; background pauses retry and refresh work',
      (tester) async {
    var calls = 0;
    var snapshot = <int>[];
    final sync = LessonListSync<int>(
        fetch: (_) async {
          calls++;
          return calls == 1 ? [1] : [];
        },
        apply: (rows) => snapshot = rows);
    addTearDown(sync.reset);
    await sync.load(1);
    sync.setForeground(false);
    sync.changed();
    await sync.refresh();
    await tester.pump(const Duration(seconds: 5));
    expect(calls, 1);
    sync.setForeground(true);
    await sync.refresh();
    expect(snapshot, isEmpty);
  });
}
