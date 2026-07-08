import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';

import '../models/course_catalog.dart';
import '../models/course_lesson.dart';
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
  final List<CourseModule> _modules = [];

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
