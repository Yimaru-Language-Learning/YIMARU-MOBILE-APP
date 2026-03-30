import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/course.dart';

import '../../../app/app.locator.dart';

class CoursePaymentViewModel extends BaseViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCourseLesson(Course course) async =>
      await _navigationService.navigateToCourseLessonView(course: course);
}
