import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../models/learn_course.dart';
import '../models/learn_lesson.dart';
import '../models/learn_module.dart';
import '../models/learn_program.dart';
import 'api_service.dart';

class LearnService with ListenableServiceMixin {
  // Dependency injection
  final _apiService = locator<ApiService>();

  // Initialization
  LearnLessonService() {
    listenToReactiveValues([_programs, _lessons]);
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
}
