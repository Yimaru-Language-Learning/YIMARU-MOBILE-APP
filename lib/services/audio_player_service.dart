import 'package:audioplayers/audioplayers.dart';
import 'package:stacked/stacked.dart';

import '../ui/common/helper_functions.dart';

class AudioPlayerService with ListenableServiceMixin {
  // Player initialization
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  AudioPlayerService() {
    _player.setReleaseMode(ReleaseMode.stop);
  }

  // Streams
  Stream<Duration> get positionStream => _player.onPositionChanged;
  Stream<Duration> get durationStream => _player.onDurationChanged;

  // Optional: player state
  Stream<PlayerState> get stateStream => _player.onPlayerStateChanged;

  Future<void> playUrl(String url) async {
    final playableUrl = getReadableUrl(url);

    if (playableUrl == null) {
      throw Exception("Invalid audio URL");
    }

    await _player.play(UrlSource(playableUrl));
  }

  Future<void> playLocal(String url) async {
    await _player.play(UrlSource(url));
  }

  Future<void> pause() async => await _player.pause();

  Future<void> seek(Duration position) async => await _player.seek(position);
}
