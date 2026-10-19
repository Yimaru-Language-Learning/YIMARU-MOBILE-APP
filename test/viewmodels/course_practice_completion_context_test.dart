import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/course_practice.dart';
import 'package:yimaru_app/models/parent.dart';
import 'package:yimaru_app/services/cache_image_service.dart';
import 'package:yimaru_app/services/course_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

import '../helpers/practice_completion_fakes.dart';

class _ExamApi extends CompletionApi {
  final rows = const [
    CoursePractice(id: 52, parents: [
      Parent(parentId: 61, parentKind: 'LESSON'),
      Parent(parentId: 100, parentKind: 'LESSON'),
    ])
  ];
  @override
  Future<List<CoursePractice>> getCourseCatalogPractices(int id) async => rows;
  @override
  Future<List<CoursePractice>> getCourseUnitPractices(int id) async => rows;
  @override
  Future<List<CoursePractice>> getCourseLessonPractices(int id) async => rows;
}

class _Course extends Mock implements CourseService {
  @override
  Future<void> getCourseProgress() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // These tests exercise request context, not the exam instruction translations.
  EasyLocalization.logger.enableLevels = [];
  tearDown(() => locator.reset());

  for (final kind in CoursePractices.values) {
    test(
        'shared API still sends the opened exam $kind location, not first link',
        () async {
      final api = _ExamApi();
      final fixture = CompletionFixture(api: api);
      final unusedLearnModel = fixture.register();
      unusedLearnModel.dispose();
      locator.registerSingleton<CourseService>(_Course());
      locator.registerSingleton<CacheImageService>(CacheImageService());
      final model = CoursePracticeViewModel();
      await model.getCoursePractices(id: 100, practice: kind);
      await model.completeCoursePractice(model.practices.single);
      expect(api.payloads.single, {
        'parent_kind': kind == CoursePractices.courseCatalog
            ? 'CATALOG_COURSE'
            : kind == CoursePractices.unit
                ? 'UNIT'
                : 'LESSON',
        'parent_id': 100,
      });
      model.dispose();
    });
  }
}
