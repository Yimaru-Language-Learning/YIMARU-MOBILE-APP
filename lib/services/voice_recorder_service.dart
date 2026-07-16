import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import 'permission_handler_service.dart';

class VoiceRecorderService with ListenableServiceMixin {
  final _permissionHandlerService = locator<PermissionHandlerService>();

  // Recording states
  VoiceRecordingState _recordingState = VoiceRecordingState.pending;

  VoiceRecordingState get recordingState => _recordingState;

  // Voice recorder controller
  final WaveformRecorderController _waveController =
      WaveformRecorderController();

  WaveformRecorderController get waveController => _waveController;

  final bool _isRecording = false;

  bool get isRecording => _isRecording;

  // Start voice recording
  Future<bool> startRecording() async {
    final status = await _permissionHandlerService
        .requestPermission(Permission.microphone);
    if (!status.isGranted) return false;

    try {
      await _waveController.startRecording();
      _recordingState = VoiceRecordingState.recording;
      notifyListeners();
      return true;
    } catch (_) {
      _recordingState = VoiceRecordingState.pending;
      notifyListeners();
      return false;
    }
  }

  // Stop voice recording
  Future<void> stopRecording() async {
    if (_waveController.isRecording) {
      await _waveController.stopRecording();
      _recordingState = VoiceRecordingState.pending;
      notifyListeners();
    }
  }

  // Get recorded audio
  Future<String?> getRecordedAudio() async {
    final recorded = _waveController.file;
    if (recorded == null) return null;

    final generator = Random();

    int random = generator.nextInt(100);

    final dir = await getTemporaryDirectory();

    final playable = File('${dir.path}/temp_audio_$random.aac');

    await playable.writeAsBytes(await recorded.readAsBytes(), flush: true);

    return playable.path;
  }
}
