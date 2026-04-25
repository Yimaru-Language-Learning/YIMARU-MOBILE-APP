import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/learn_program.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnProgramViewModel extends ReactiveViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Learn programs
  List<LearnProgram> _learnPrograms = [];

  List<LearnProgram> get learnPrograms => _learnPrograms;

  // Navigation
  Future<void> navigateToLearnCourse(int id) async =>
      _navigationService.navigateToLearnCourseView(id: id);

  // Remote api call

  // Learn programs
  Future<void> getLearnPrograms() async =>
      await runBusyFuture(_getLearnPrograms(),
          busyObject: StateObjects.learnPrograms);

  Future<void> _getLearnPrograms() async {
    if (_learnPrograms.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _learnPrograms = await _apiService.getLearnPrograms();
        _learnPrograms
            .sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
      }
    }
  }
}
