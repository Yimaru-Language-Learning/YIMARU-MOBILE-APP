import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

  final bool _isRecording = false;

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

    await _saveRecordedAudio(file);

   // return file.path;
    String? voice = await _saveRecordedAudio(file);
    return voice;
  }

  Future<String?> _saveRecordedAudio(XFile? file) async {
    late File voice;
    final voiceName = basename(file?.name ?? '');
    final Directory appDir = await getApplicationDocumentsDirectory();

    final localImagePath = join(appDir.path, voiceName);
    voice = File(localImagePath);
    //voice.writeAsBytes(await file?.);
    return voice.path;
  }
}
