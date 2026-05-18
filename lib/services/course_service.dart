import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/course_progress.dart';
import 'package:yimaru_app/services/api_service.dart';

import '../models/course_catalog.dart';
import '../models/course_detail.dart';
import '../models/course_module.dart';
import '../models/course_unit.dart';

class CourseService with ListenableServiceMixin {
  // Dependency injection
  final _apiService = locator<ApiService>();

  // Initialization
  courseService() {
    listenToReactiveValues([_catalogs]);
  }

  // Course catalogs
  List<CourseCatalog> _catalogs = [];

  List<CourseCatalog> get catalogs => _catalogs;

  // Course units
  List<CourseUnit> _units = [];

  List<CourseUnit> get units => _units;

  // Course modules
  List<CourseModule> _modules = [];

  List<CourseModule> get modules => _modules;

  // Course catalogs
  Future<void> getCourseCatalogs() async {
    _catalogs = await _apiService.getCourseCatalogs();
    _catalogs.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
    notifyListeners();
  }

  // Course units
  Future<void> getCourseUnits(int id) async {
    _units = await _apiService.getCourseUnits(id);
    _units.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
    notifyListeners();
  }

  // Course modules
  Future<void> getCourseUnitModule({
    required int id,
    required int index,
  }) async {
    List<CourseModule> modules = await _apiService.getCourseModules(id);

    modules.sort(
      (a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0),
    );

    final updatedUnit = _units[index].copyWith(
      modules: modules,
    );

    _units[index] = updatedUnit;

    notifyListeners();
  }

  Future<void> getCourseModules(int id) async {
    _modules = await _apiService.getCourseModules(id);
    _modules.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
    notifyListeners();
  }

  // Get course detail
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
