import 'dart:async';

import 'package:async/async.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:stacked/stacked.dart';

import '../ui/common/helper_functions.dart';

class AudioPlayerService with ListenableServiceMixin {
  // Player initialization
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  final _durationController = StreamController<Duration>.broadcast();

  AudioPlayerService() {
    _player.setReleaseMode(ReleaseMode.stop);
  }

  // Streams
  Stream<Duration> get durationStream => StreamGroup.merge([
        _player.onDurationChanged,
        _durationController.stream,
      ]);

  Stream<Duration> get positionStream => _player.onPositionChanged;

  // Optional: player state
  Stream<PlayerState> get stateStream => _player.onPlayerStateChanged;

  Future<void> playUrl(String url) async {
    final playableUrl = getReadableUrl(url);

    if (playableUrl == null) {
      throw Exception("Invalid audio URL");
    }

    await _player.play(UrlSource(playableUrl));

    // 👇 Force duration fetch
    final dur = await _player.getDuration();
    if (dur != null) {
      _durationController.add(dur);
    }
  }

  Future<void> playLocal(String url) async {
    await _player.play(DeviceFileSource(url));
  }

  Future<void> stop() async => await _player.stop();

  Future<void> pause() async => await _player.pause();

  Future<void> seek(Duration position) async => await _player.seek(position);
}
