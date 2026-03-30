import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/models/practice.dart';

import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CoursePracticeViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Course practices
  List<Practice> _coursePractices = [];

  List<Practice> get coursePractices => _coursePractices;

  // Navigation
  void pop() => _navigationService.back();

  // Remote api call

  // Courses
  Future<void> getCoursePractice(int id) async =>
      await runBusyFuture(_getCoursePractice(id),
          busyObject: StateObjects.coursePractice);

  Future<void> _getCoursePractice(int id) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> data = {'owner_id': id, 'owner_type': 'SUB_COURSE'};
      _coursePractices = await _apiService.getCoursePractices(data);

      rebuildUi();
    }
  }
}
