import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/access.dart';
import 'package:yimaru_app/models/course_progress.dart';
import 'package:yimaru_app/models/module_progress.dart';
import 'package:yimaru_app/models/learn_program.dart';
import 'package:yimaru_app/models/progress_summary.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/learn_service.dart';

class _Api implements ApiService {
  bool fail = false;
  Completer<void>? gate;
  List<ProgressSummary> summaries = const [
    ProgressSummary(
      access: Access(totalCount: 10, completedCount: 2, progressPercent: 20),
      courses: [
        CourseProgress(
          access: Access(totalCount: 5, completedCount: 1),
          modules: [
            ModuleProgress(access: Access(totalCount: 3, completedCount: 1)),
          ],
        ),
      ],
    ),
  ];

  @override
  Future<List<ProgressSummary>> getProgressSummary() async {
    await gate?.future;
    if (fail) throw StateError('server unavailable');
    return summaries;
  }

  @override
  Future<List<LearnProgram>> getLearnPrograms() async => [
        const LearnProgram(id: 1, access: Access(isAccessible: false)),
      ];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Auth implements AuthenticationService {
  int generation = 0;
  @override
  int get sessionGeneration => generation;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  tearDown(() => locator.reset());

  test('late completion refresh cannot overwrite a new account access flags',
      () async {
    final api = _Api()
      ..summaries = const [
        ProgressSummary(id: 1, access: Access(isAccessible: true))
      ];
    final auth = _Auth();
    locator.registerSingleton<ApiService>(api);
    locator.registerSingleton<AuthenticationService>(auth);
    final service = LearnService();
    await service.getLearnPrograms();
    api.gate = Completer<void>();
    final pending = service.getLearnProgress();
    auth.generation++;
    api.gate!.complete();
    await pending;
    expect(service.programs.single.access!.isAccessible, isFalse);
    await service.getLearnProgress();
    expect(service.programs.single.access!.isAccessible, isTrue);
  });

  test('progress retries replace totals and preserve them on failed reads',
      () async {
    final api = _Api();
    locator.registerSingleton<ApiService>(api);
    final service = LearnService();

    await service.getProgressSummary();
    await service.getProgressSummary();
    expect(service.totalCount, 18);
    expect(service.completedCount, 4);
    expect(service.totalProgress, 20);

    api.fail = true;
    await expectLater(service.getProgressSummary(), throwsStateError);
    expect(service.totalCount, 18);
    expect(service.completedCount, 4);

    api.fail = false;
    await service.getProgressSummary();
    expect(service.totalCount, 18);
    expect(service.completedCount, 4);

    api.summaries = [];
    await service.getProgressSummary();
    expect(service.totalCount, 0);
    expect(service.completedCount, 0);
    expect(service.totalProgress, 0);
  });
}
