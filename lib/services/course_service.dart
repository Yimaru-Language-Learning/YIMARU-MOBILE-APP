import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/course_progress.dart';
import 'package:yimaru_app/services/api_service.dart';

import '../models/course_detail.dart';

class CourseService {
  final _apiService = locator<ApiService>();

  Future<List<CourseDetail>> getCoursesDetail(int id) async {
    final courses = await _apiService.getCourses(id);
    final progress = await _apiService.getCourseProgress(id);

    final progressMap = {
      for (var p in progress.whereType<CourseProgress>()) p.courseId: p
    };

    return courses.map((course) {
      return CourseDetail(
        course: course,
        courseProgress: progressMap[course.id],
      );
    }).toList();
  }
}
