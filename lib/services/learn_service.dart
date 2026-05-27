import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/refresh_object.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../app/app.locator.dart';
import '../models/access.dart';
import '../models/learn_course.dart';
import '../models/learn_lesson.dart';
import '../models/learn_module.dart';
import '../models/learn_program.dart';
import '../models/progress_summary.dart';
import 'api_service.dart';

class LearnService with ListenableServiceMixin {
  // Dependency injection
  final _apiService = locator<ApiService>();

  // Initialization
  learnService() {
    listenToReactiveValues([_programs, _lessons, _modules]);
  }

  // Learn program
  List<LearnProgram> _programs = [];

  List<LearnProgram> get programs => _programs;

  // Learn course
  List<LearnCourse> _courses = [];

  List<LearnCourse> get courses => _courses;

  // Learn module
  List<LearnModule> _modules = [];

  List<LearnModule> get modules => _modules;

  // Learn lesson
  List<LearnLesson> _lessons = [];

  List<LearnLesson> get lessons => _lessons;

  // Learn progress
  final List<ProgressSummary> _summaries = [];

  List<ProgressSummary> get summaries => _summaries;

  // Learn programs
  Future<String?> refreshObject(String url) async {
    Map<String, dynamic> data = {'reference': url};
    Map<String, dynamic> response = await _apiService.refreshObject(data);

    if (response['status'] == ResponseStatus.success) {
      RefreshObject object = response['data'] as RefreshObject;

      return object.url ?? '';
    }
    return null;
  }

  // Learn programs
  Future<void> getLearnPrograms() async {
    _programs = await _apiService.getLearnPrograms();
    _programs.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
    notifyListeners();
  }

  // Learn modules
  Future<void> getLearnCourses(int id) async {
    _courses = await _apiService.getLearnCourses(id);
    _courses.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
    notifyListeners();
  }

  // Learn modules
  Future<void> getLearnModules(int id) async {
    _modules = await _apiService.getLearnModules(id);
    _modules.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
    notifyListeners();
  }

  // Learn lessons
  Future<void> getLearnLessons(int id) async {
    _lessons = await _apiService.getLearnLessons(id);
    _lessons.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
    notifyListeners();
  }

  // Learn progress
  Future<void> getLearnProgressSummary() async {
    final summaries = await _apiService.getProgressSummary();
    print('MY SUMMARIES: ${summaries.length}');

    /// PROGRAM ACCESS MAP
    final Map<int, Access?> programAccessMap = {};

    /// COURSE ACCESS MAP
    final Map<int, Access?> courseAccessMap = {};

    /// MODULE ACCESS MAP
    final Map<int, Access?> moduleAccessMap = {};

    /// LESSON ACCESS MAP
    final Map<int, Access?> lessonAccessMap = {};

    // Build maps
    for (final summary in summaries) {
      if (summary.id != null) {
        programAccessMap[summary.id!] = summary.access;
      }

      for (final course in summary.courses ?? []) {
        if (course.id != null) {
          courseAccessMap[course.id!] = course.access;
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

    /// UPDATE PROGRAMS
    _programs = _programs.map((program) {
      return program.copyWith(
        access: programAccessMap[program.id] ?? program.access,
      );
    }).toList();

    /// UPDATE COURSES
    _courses = _courses.map((course) {
      return course.copyWith(
        access: courseAccessMap[course.id] ?? course.access,
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
}
