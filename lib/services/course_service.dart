import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';

import '../models/access.dart';
import '../models/course_catalog.dart';
import '../models/course_lesson.dart';
import '../models/course_module.dart';
import '../models/course_progress.dart';
import '../models/course_unit.dart';
import '../models/progress_summary.dart';

class CourseService with ListenableServiceMixin {
  // Dependency injection
  final _apiService = locator<ApiService>();

  // Initialization
  courseService() {
    listenToReactiveValues([_catalogs]);
  }

  // Completed count
  int _completedCount = 0;

  int get completedCount => _completedCount;

  // Total count
  int _totalCount = 0;

  int get totalCount => _totalCount;

  // Total progress
  int _totalProgress = 0;

  int get totalProgress => _totalProgress;

  // Course catalogs
  List<CourseCatalog> _catalogs = [];

  List<CourseCatalog> get catalogs => _catalogs;

  // Course units
  List<CourseUnit> _units = [];

  List<CourseUnit> get units => _units;

  // Course modules
  List<CourseModule> _modules = [];

  List<CourseModule> get modules => _modules;

  // Course lessons
  List<CourseLesson> _lessons = [];

  List<CourseLesson> get lessons => _lessons;

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
  Future<void> getCourseModules({
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

  // Course units
  Future<void> getCourseLessons(int id) async {
    _lessons = await _apiService.getCourseLessons(id);
    _lessons.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
    notifyListeners();
  }

  // Learn progress
  Future<void> getCourseProgress() async {
    final summaries = await _apiService.getProgressSummary();

    /// CATALOG ACCESS MAP
    final Map<int, Access?> catalogAccessMap = {};

    /// UNIT ACCESS MAP
    final Map<int, Access?> unitAccessMap = {};

    /// MODULE ACCESS MAP
    final Map<int, Access?> moduleAccessMap = {};

    /// LESSON ACCESS MAP
    final Map<int, Access?> lessonAccessMap = {};

    // Build maps
    for (final summary in summaries) {
      if (summary.id != null) {
        catalogAccessMap[summary.id!] = summary.access;
      }

      for (final course in summary.courses ?? []) {
        if (course.id != null) {
          unitAccessMap[course.id!] = course.access;
        }

        for (final module in course.modules ?? []) {
          if (module.id != null) {
            moduleAccessMap[module.id!] = module.access;
          }

          for (final lesson in module.lessons ?? []) {
            if (lesson.id != null) {
              lessonAccessMap[lesson.id!] = lesson.access;
            }
          }
        }
      }
    }

    /// UPDATE CATALOG
    _catalogs = _catalogs.map((catalog) {
      return catalog.copyWith(
        access: catalogAccessMap[catalog.id] ?? catalog.access,
      );
    }).toList();

    /// UPDATE UNIT
    _units = _units.map((unit) {
      return unit.copyWith(
        access: unitAccessMap[unit.id] ?? unit.access,
      );
    }).toList();

    /// UPDATE MODULES
    _modules = _modules.map((module) {
      return module.copyWith(
        access: moduleAccessMap[module.id] ?? module.access,
      );
    }).toList();

    /// UPDATE LESSONS
    _lessons = _lessons.map((lesson) {
      return lesson.copyWith(
        access: lessonAccessMap[lesson.id] ?? lesson.access,
      );
    }).toList();

    notifyListeners();
  }

/*Future<String?> refreshObject(String url) async {
    Map<String, dynamic> data = {'reference': url};
    Map<String, dynamic> response = await _apiService.refreshObject(data);

    if (response['status'] == ResponseStatus.success) {
      RefreshObject object = response['data'] as RefreshObject;

      return object.url ?? '';
    }
    return null;
  }*/
}
