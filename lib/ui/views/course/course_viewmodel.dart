import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/course.dart';
import '../../../models/course_detail.dart';
import '../../../services/course_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseViewModel extends BaseViewModel {
  // Dependency injection
  final _courseService = locator<CourseService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Subcourse with progress
  List<CourseDetail> _courseDetail = [];

  List<CourseDetail> get courseDetail => _courseDetail;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCoursePractice(int id) =>
      _navigationService.navigateToCoursePracticeView(id: id);

  Future<void> navigateToCoursePayment(Course course) async =>
      _navigationService.navigateToCoursePaymentView(course: course);

  // Remote api call

  // Course detail
  Future<void> getCourseDetails(int id) async =>
      await runBusyFuture(_getCourseDetails(id),
          busyObject: StateObjects.courses);

  Future<void> _getCourseDetails(int id) async {
    if (await _statusChecker.checkConnection()) {
      _courseDetail = await _courseService.getCoursesDetail(id);
      // _courseDetail.sort((a, b) =>
      //     (a.course?.displayOrder ?? 0).compareTo(b.course?.displayOrder ?? 0));
    }
  }
}
