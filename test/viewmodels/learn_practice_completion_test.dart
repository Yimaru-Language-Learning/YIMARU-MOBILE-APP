import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../helpers/practice_completion_fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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

  Future<void> load(
          [int id = 61, LearnPractices kind = LearnPractices.lesson]) =>
      model.getLearnPractices(id: id, practice: kind);

  for (final kind in LearnPractices.values) {
    for (final location in [61, 100]) {
      test('$kind completion uses navigation parent $location, not first link',
          () async {
        await load(location, kind);
        expect(await model.completeLearnPractice(), isTrue);
        expect(fixture.api.practiceIds, [52]);
        expect(fixture.api.payloads.single,
            {'parent_kind': kind.name.toUpperCase(), 'parent_id': location});
        expect(fixture.learn.refreshes, 1);
        expect(model.completionFailed, isFalse);
      });
    }
  }

  test('rejected completion stays on results and preserves answers for retry',
      () async {
    await load();
    model.goTo(3);
    model.answers.add({'recorded_voice_answer': 'local-answer.m4a'});
    fixture.api.succeed = false;
    expect(await model.completeLearnPractice(), isFalse);
    expect(model.currentPage, 3);
    expect(model.completionFailed, isTrue);
    expect(model.completionSaved, isFalse);
    expect(model.answers.single['recorded_voice_answer'], 'local-answer.m4a');
    expect(fixture.learn.refreshes, 0);
    fixture.api.succeed = true;
    expect(await model.completeLearnPractice(), isTrue);
    expect(fixture.api.payloads.length, 2);
    expect(fixture.api.payloads[0], fixture.api.payloads[1]);
    expect(model.completionFailed, isFalse);
    expect(model.answers, hasLength(1));
  });

  test('offline completion does not falsely succeed or send a request',
      () async {
    await load();
    fixture.status.online = false;
    expect(await model.completeLearnPractice(), isFalse);
    expect(model.completionFailed, isTrue);
    expect(fixture.api.payloads, isEmpty);
    fixture.status.online = true;
    expect(await model.completeLearnPractice(), isTrue);
  });

  test('unexpected transport failure is recoverable and clears busy state',
      () async {
    await load();
    fixture.api.throwOnSave = true;
    expect(await model.completeLearnPractice(), isFalse);
    expect(model.busy(StateObjects.completeLearnPractice), isFalse);
    expect(model.completionFailed, isTrue);
    fixture.api.throwOnSave = false;
    expect(await model.completeLearnPractice(), isTrue);
  });

  test('concurrent taps send one POST and cannot reset or reload the attempt',
      () async {
    await load();
    model.answers.add({'recorded_voice_answer': 'keep.m4a'});
    fixture.api.saveGate = Completer<void>();
    final first = model.completeLearnPractice();
    expect(model.busy(StateObjects.completeLearnPractice), isTrue);
    expect(await model.completeLearnPractice(), isFalse);
    await model.reset();
    await load(100);
    await Future<void>.delayed(Duration.zero);
    expect(fixture.api.payloads, hasLength(1));
    expect(model.answers, hasLength(1));
    fixture.api.saveGate!.complete();
    expect(await first, isTrue);
    expect(fixture.api.payloads.single['parent_id'], 61);
    expect(fixture.learn.refreshes, 1);
  });

  test('confirmed save followed by failed refresh retries only the read',
      () async {
    await load();
    fixture.learn.fail = true;
    expect(await model.completeLearnPractice(), isFalse);
    expect(model.completionSaved, isTrue);
    expect(model.completionFailed, isTrue);
    expect(fixture.api.payloads, hasLength(1));
    fixture.learn.fail = false;
    expect(await model.completeLearnPractice(), isTrue);
    expect(fixture.api.payloads, hasLength(1));
    expect(fixture.learn.refreshes, 2);
  });

  test('missing or empty loaded practice cannot record stale completion',
      () async {
    expect(await model.completeLearnPractice(), isFalse);
    await load();
    fixture.api.practices = [];
    await load(100);
    expect(await model.completeLearnPractice(), isFalse);
    expect(fixture.api.payloads, isEmpty);
    expect(model.practices, isEmpty);
  });

  test('an empty question list cannot record completion', () async {
    fixture.api.questions = [];
    await load();
    expect(await model.completeLearnPractice(), isFalse);
    expect(fixture.api.payloads, isEmpty);
  });

  test(
      'deliberately practicing again starts a new attempt, not a stale saved state',
      () async {
    await load();
    expect(await model.completeLearnPractice(), isTrue);
    model.answers.add({'recorded_voice_answer': 'previous.m4a'});
    await model.reset();
    expect(model.currentPage, 0);
    expect(model.answers, isEmpty);
    expect(model.completionSaved, isFalse);
    expect(await model.completeLearnPractice(), isTrue);
    expect(fixture.api.payloads, hasLength(2));
  });

  test('a different login cannot complete the previous account attempt',
      () async {
    await load();
    fixture.auth.generation++;
    expect(await model.completeLearnPractice(), isFalse);
    expect(fixture.api.payloads, isEmpty);
  });

  test(
      'late save response after logout cannot refresh or advance another session',
      () async {
    await load();
    fixture.api.saveGate = Completer<void>();
    final pending = model.completeLearnPractice();
    await Future<void>.delayed(Duration.zero);
    fixture.auth.generation++;
    fixture.api.saveGate!.complete();
    expect(await pending, isFalse);
    expect(fixture.learn.refreshes, 0);
    expect(model.completionSaved, isFalse);
  });

  test(
      'leaving during save ignores the late response without notifying disposed UI',
      () async {
    await load();
    fixture.api.saveGate = Completer<void>();
    final pending = model.completeLearnPractice();
    await Future<void>.delayed(Duration.zero);
    model.dispose();
    fixture.api.saveGate!.complete();
    expect(await pending, isFalse);
    expect(fixture.learn.refreshes, 0);
  });
}
