import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/learn_program.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnProgramViewModel extends ReactiveViewModel {
  // Dependency injection

  final _learnService = locator<LearnService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_learnService, _authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Learn programs
  List<LearnProgram> get _learnPrograms => _learnService.programs;

  List<LearnProgram> get learnPrograms => _learnPrograms;

  // Navigation
  Future<void> navigateToLearnCourse({required int id,required bool first}) async =>
      _navigationService.navigateToLearnCourseView(id: id,first: first);

  // Remote api call

  // Learn programs
  Future<void> getLearnPrograms() async =>
      await runBusyFuture(_getLearnPrograms(),
          busyObject: StateObjects.learnPrograms);

  Future<void> _getLearnPrograms() async {
    if (await _statusChecker.checkConnection()) {
      await _learnService.getLearnPrograms();
    }
  }
}
