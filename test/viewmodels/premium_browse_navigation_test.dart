import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/access.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/models/course_module.dart';
import 'package:yimaru_app/models/learn_course.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/models/learn_program.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/course_service.dart';
import 'package:yimaru_app/services/in_app_notification_service.dart';
import 'package:yimaru_app/services/learn_service.dart';
import 'package:yimaru_app/services/premium_purchase_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_catalog/course_catalog_viewmodel.dart';
import 'package:yimaru_app/ui/views/course_unit/course_unit_viewmodel.dart';
import 'package:yimaru_app/ui/views/learn_course/learn_course_viewmodel.dart';
import 'package:yimaru_app/ui/views/learn_module/learn_module_viewmodel.dart';
import 'package:yimaru_app/ui/views/learn_program/learn_program_viewmodel.dart';

class _Navigation extends NavigationService {
  final routes = <String>[];
  final arguments = <dynamic>[];
  @override
  Future<T?>? navigateTo<T>(String routeName,
      {dynamic arguments,
      int? id,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      RouteTransitionsBuilder? transition}) async {
    routes.add(routeName);
    this.arguments.add(arguments);
    return null;
  }
}

class _Learn extends Mock implements LearnService {
  @override
  List<LearnProgram> programs = [];
}

class _Course extends Mock implements CourseService {}

class _Status extends Mock implements StatusCheckerService {}

class _Notifications extends Mock implements InAppNotificationService {}

class _Auth extends Mock implements AuthenticationService {
  @override
  User get user =>
      const User(userId: 7, learn: false, ielts: false, duolingo: false);
  @override
  int get sessionGeneration => 1;
}

class _Api extends Mock implements ApiService {
  @override
  Future<Map<String, dynamic>> getProfileData(int? id) async =>
      throw StateError(
          'Browsing must not check subscription or contact details');
}

class _Purchase extends PremiumPurchaseService {
  _Purchase() : super(isIOS: true);
  @override
  Future<void> open(SubscriptionType type, {BuildContext? context}) async =>
      throw StateError('Browsing must not open checkout');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _Navigation navigation;
  late _Learn learn;
  setUp(() {
    navigation = _Navigation();
    learn = _Learn();
    locator.registerSingleton<NavigationService>(navigation);
    locator.registerSingleton<LearnService>(learn);
    locator.registerSingleton<CourseService>(_Course());
    locator.registerSingleton<StatusCheckerService>(_Status());
    locator.registerSingleton<AuthenticationService>(_Auth());
    locator.registerSingleton<InAppNotificationService>(_Notifications());
    locator.registerSingleton<ApiService>(_Api());
    locator.registerSingleton<PremiumPurchaseService>(_Purchase());
  });
  tearDown(() => locator.reset());

  for (final tier in ['FREE', 'PREMIUM']) {
    for (final first in [false, true]) {
      test('Start Learning browses $tier ancestry, preserving first=$first',
          () async {
        learn.programs = [
          LearnProgram(
              id: 1,
              name: 'Beginner',
              effectiveAccessTier: tier,
              access: const Access(isAccessible: true))
        ];
        final course = LearnCourse(
            id: 2,
            programId: 1,
            effectiveAccessTier: tier,
            access: const Access(isAccessible: true));
        final module = LearnModule(
            id: 3,
            courseId: 2,
            effectiveAccessTier: tier,
            access: const Access(isAccessible: true));
        final programs = LearnProgramViewModel();
        final courses = LearnCourseViewModel();
        final modules = LearnModuleViewModel();
        addTearDown(programs.dispose);
        addTearDown(courses.dispose);
        addTearDown(modules.dispose);
        await programs.navigateToLearnCourse(id: 1, first: first);
        await courses.navigateToLearnModule(first: first, course: course);
        await modules.navigateToLearnLesson(first: first, module: module);
        expect(navigation.routes, [
          Routes.learnCourseView,
          Routes.learnModuleView,
          Routes.learnLessonView
        ]);
        final courseArgs = navigation.arguments[0] as LearnCourseViewArguments;
        final moduleArgs = navigation.arguments[1] as LearnModuleViewArguments;
        final lessonArgs = navigation.arguments[2] as LearnLessonViewArguments;
        expect(courseArgs.id, 1);
        expect(courseArgs.first, first);
        expect(moduleArgs.course, same(course));
        expect(moduleArgs.first, first);
        expect(lessonArgs.module, same(module));
        expect(lessonArgs.first, first);
      });
    }
    for (final type in [SubscriptionType.ielts, SubscriptionType.duolingo]) {
      test('$type browses $tier catalogue and module without checkout',
          () async {
        final catalog = CourseCatalog(
            id: 4,
            effectiveAccessTier: tier,
            access: const Access(isAccessible: true));
        final module = CourseModule(
            id: 6,
            unitId: 5,
            effectiveAccessTier: tier,
            access: const Access(isAccessible: true));
        final catalogs = CourseCatalogViewModel();
        final units = CourseUnitViewModel();
        addTearDown(catalogs.dispose);
        addTearDown(units.dispose);
        await catalogs.navigateToCourseUnit(type: type, catalog: catalog);
        await units.navigateToCourseModule(
            first: true, module: module, type: type, catalog: catalog);
        expect(navigation.routes,
            [Routes.courseUnitView, Routes.courseModuleView]);
        final unitArgs = navigation.arguments[0] as CourseUnitViewArguments;
        final moduleArgs = navigation.arguments[1] as CourseModuleViewArguments;
        expect(unitArgs.catalog, same(catalog));
        expect(unitArgs.type, type);
        expect(moduleArgs.catalog, same(catalog));
        expect(moduleArgs.module, same(module));
        expect(moduleArgs.type, type);
        expect(moduleArgs.first, isTrue);
      });
    }
  }
}
