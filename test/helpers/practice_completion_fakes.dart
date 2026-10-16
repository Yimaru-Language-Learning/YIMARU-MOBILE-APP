import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/learn_practice.dart';
import 'package:yimaru_app/models/parent.dart';
import 'package:yimaru_app/models/practice_question.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/audio_player_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/learn_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/services/voice_recorder_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

class CompletionApi extends Mock implements ApiService {
  bool succeed = true;
  bool throwOnSave = false;
  Completer<void>? saveGate;
  final payloads = <Map<String, dynamic>>[];
  final practiceIds = <int>[];
  List<LearnPractice> practices = const [
    LearnPractice(id: 52, questionSetId: 117, parents: [
      Parent(parentKind: 'LESSON', parentId: 61),
      Parent(parentKind: 'LESSON', parentId: 100),
    ]),
  ];
  List<PracticeQuestion> questions = const [PracticeQuestion(id: 1)];

  @override
  Future<Map<String, dynamic>> getProfileData(int? id) async =>
      {'status': ResponseStatus.failure};
  @override
  Future<List<LearnPractice>> getLearnLessonPractices(int id) async =>
      practices;
  @override
  Future<List<LearnPractice>> getLearnModulePractices(int id) async =>
      practices;
  @override
  Future<List<LearnPractice>> getLearnCoursePractices(int id) async =>
      practices;
  @override
  Future<List<PracticeQuestion>> getLearnQuestions(int id) async => questions;
  @override
  Future<Map<String, dynamic>> completePractice(
      {required int id, required Map<String, dynamic> data}) async {
    practiceIds.add(id);
    payloads.add(Map<String, dynamic>.from(data));
    await saveGate?.future;
    if (throwOnSave) throw StateError('private server details');
    return {
      'status': succeed ? ResponseStatus.success : ResponseStatus.failure,
      'message': succeed ? 'Practice completed' : 'private server details',
    };
  }
}

class CompletionAudio extends Mock implements AudioPlayerService {
  @override
  Stream<Duration> get durationStream => const Stream.empty();
  @override
  Stream<Duration> get positionStream => const Stream.empty();
  @override
  Stream<PlayerState> get stateStream => const Stream.empty();
  @override
  Future<void> stop() async {}
}

class CompletionLearn extends Mock implements LearnService {
  int refreshes = 0;
  bool fail = false;
  @override
  Future<void> getLearnProgress() async {
    refreshes++;
    if (fail) throw StateError('progress refresh failed');
  }
}

class CompletionStatus extends Mock implements StatusCheckerService {
  bool online = true;
  @override
  Future<bool> checkConnection() async => online;
}

class CompletionAuth extends Mock implements AuthenticationService {
  int generation = 0;
  @override
  int get sessionGeneration => generation;
  @override
  User? get user => null;
}

class _Voice extends Mock implements VoiceRecorderService {}

class _Navigation extends Mock implements NavigationService {}

class _Dialog extends Mock implements DialogService {}

class CompletionFixture {
  CompletionFixture({CompletionApi? api}) : api = api ?? CompletionApi();

  final CompletionApi api;
  final learn = CompletionLearn();
  final status = CompletionStatus();
  final auth = CompletionAuth();

  LearnPracticeViewModel register() {
    locator.registerSingleton<ApiService>(api);
    locator.registerSingleton<LearnService>(learn);
    locator.registerSingleton<AudioPlayerService>(CompletionAudio());
    locator.registerSingleton<StatusCheckerService>(status);
    locator.registerSingleton<AuthenticationService>(auth);
    locator.registerSingleton<VoiceRecorderService>(_Voice());
    locator.registerSingleton<NavigationService>(_Navigation());
    locator.registerSingleton<DialogService>(_Dialog());
    return LearnPracticeViewModel();
  }
}
