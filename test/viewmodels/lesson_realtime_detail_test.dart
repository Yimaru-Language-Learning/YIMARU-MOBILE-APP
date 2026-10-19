import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/access.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/course_service.dart';
import 'package:yimaru_app/services/learn_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/services/vimeo_service.dart';
import 'package:yimaru_app/ui/views/course_lesson_detail/course_lesson_detail_viewmodel.dart';
import 'package:yimaru_app/ui/views/learn_lesson_detail/learn_lesson_detail_viewmodel.dart';

class _Api implements ApiService {
  List<LearnLesson> learn = [];
  List<CourseLesson> exam = [];
  @override
  Future<List<LearnLesson>> getLearnLessons(int id) async => learn;
  @override
  Future<List<CourseLesson>> getCourseLessons(int id) async => exam;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Auth implements AuthenticationService {
  @override
  User? get user => null;
  @override
  void addListener(void Function() listener) {}
  @override
  void removeListener(void Function() listener) {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Navigation implements NavigationService {
  int pops = 0;
  @override
  bool back<T>({dynamic result, int? id}) {
    pops++;
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Vimeo implements VimeoService {
  int calls = 0;
  @override
  Future<String?> getVideoUrl(String url) async {
    calls++;
    return null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Status implements StatusCheckerService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _Api api;
  late _Navigation navigation;
  late _Vimeo vimeo;
  setUp(() {
    api = _Api();
    navigation = _Navigation();
    vimeo = _Vimeo();
    locator.registerSingleton<ApiService>(api);
    locator.registerSingleton<AuthenticationService>(_Auth());
    locator.registerSingleton<NavigationService>(navigation);
    locator.registerSingleton<VimeoService>(vimeo);
    locator.registerSingleton<StatusCheckerService>(_Status());
    locator.registerSingleton<LearnService>(LearnService());
    locator.registerSingleton<CourseService>(CourseService());
  });
  tearDown(() => locator.reset());

  testWidgets(
      'LMS detail follows full refreshed data without reloading the player',
      (tester) async {
    const initial = LearnLesson(
        id: 1,
        moduleId: 45,
        title: 'Old',
        description: 'Old description',
        videoUrl: 'old-video',
        hasPractice: false,
        access: Access(isAccessible: true));
    api.learn = [initial];
    final service = locator<LearnService>();
    await service.getLearnLessons(45);
    final viewModel = LearnLessonDetailViewModel()..bindLesson(initial);
    addTearDown(viewModel.dispose);
    api.learn = [
      initial.copyWith(
          title: 'New',
          description: 'New description',
          videoUrl: 'replacement-video',
          hasPractice: true)
    ];
    await service.lessonSync.refresh();
    expect(viewModel.currentLesson?.title, 'New');
    expect(viewModel.currentLesson?.description, 'New description');
    expect(viewModel.currentLesson?.hasPractice, isTrue);
    expect(vimeo.calls, 0);
    final reopened = LearnLessonDetailViewModel()..bindLesson(initial);
    expect(reopened.currentLesson?.videoUrl, 'replacement-video');
    reopened.dispose();
    api.learn = [];
    await service.lessonSync.refresh();
    await tester.pump();
    expect(navigation.pops, 1);
  });

  testWidgets(
      'exam-prep detail refreshes metadata and exits when access is revoked',
      (tester) async {
    const initial = CourseLesson(
        id: 1,
        unitModuleId: 45,
        title: 'Old',
        videoUrl: 'old-video',
        access: Access(isAccessible: true));
    api.exam = [initial];
    final service = locator<CourseService>();
    await service.getCourseLessons(45);
    final viewModel = CourseLessonDetailViewmodel()..bindLesson(initial);
    addTearDown(viewModel.dispose);
    api.exam = [
      initial.copyWith(
          title: 'New',
          description: 'Updated',
          thumbnail: 'new-image',
          hasPractice: true,
          videoUrl: 'replacement-video')
    ];
    await service.lessonSync.refresh();
    expect(viewModel.currentLesson?.title, 'New');
    expect(viewModel.currentLesson?.thumbnail, 'new-image');
    expect(viewModel.currentLesson?.hasPractice, isTrue);
    expect(vimeo.calls, 0);
    api.exam = [initial.copyWith(access: const Access(isAccessible: false))];
    await service.lessonSync.refresh();
    await tester.pump();
    expect(navigation.pops, 1);
  });
}
