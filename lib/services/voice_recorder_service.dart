import 'package:stacked/stacked.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

class VoiceRecorderService with ListenableServiceMixin {
  // Recording states
  VoiceRecordingState _recordingState = VoiceRecordingState.pending;

  VoiceRecordingState get recordingState => _recordingState;

  // Voice recorder controller
  final WaveformRecorderController _waveController =
      WaveformRecorderController();

  WaveformRecorderController get waveController => _waveController;

  bool _isRecording = false;

  bool get isRecording => _isRecording;

  // Start voice recording
  Future<void> startRecording() async {
    await _waveController.startRecording();
    _recordingState = VoiceRecordingState.recording;
    notifyListeners();
  }

  // Stop voice recording
  Future<void> stopRecording() async {
    await _waveController.stopRecording();
    _recordingState = VoiceRecordingState.pending;
    notifyListeners();
  }

  // Get recorded audio
  Future<String?> getRecordedAudio() async {
    final file = _waveController.file;
    print('RECORDED $file');
    if (file == null) return null;
    return file.path;
  }
}
