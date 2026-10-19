import 'dart:async';

/// One module snapshot, with coalesced refreshes and stale-response protection.
class LessonListSync<T> {
  LessonListSync({required this.fetch, required this.apply, this.onError});

  final Future<List<T>> Function(int moduleId) fetch;
  final void Function(List<T>) apply;
  final void Function(Object error)? onError;
  int? moduleId;
  int? loadedModuleId;
  Object? lastError;
  int _generation = 0;
  Future<void>? _running;
  Timer? _timer;
  bool _pending = false;
  bool _foreground = true;
  int _retry = 0;

  Future<void> load(int id) {
    if (moduleId != id) {
      reset();
      moduleId = id;
    }
    return refresh();
  }

  void reset() {
    _generation++;
    _timer?.cancel();
    _running = null;
    _pending = false;
    _retry = 0;
    moduleId = null;
    loadedModuleId = null;
    lastError = null;
    apply([]);
  }

  void setForeground(bool value) {
    _foreground = value;
    if (!value) _timer?.cancel();
  }

  void changed() {
    _timer?.cancel();
    if (!_foreground || moduleId == null) return;
    // Changes during a fetch must be followed by another authoritative fetch.
    if (_running != null) {
      _pending = true;
      return;
    }
    _timer = Timer(const Duration(milliseconds: 300), refresh);
  }

  Future<void> refresh() {
    if (moduleId == null || !_foreground) return Future.value();
    _timer?.cancel();
    _pending = true;
    if (_running != null) return _running!;
    final generation = _generation;
    final completer = Completer<void>();
    _running = completer.future;
    unawaited(_run(generation).then((_) {
      if (_generation == generation) _running = null;
      completer.complete();
    }, onError: (Object error, StackTrace stack) {
      if (_generation == generation) _running = null;
      completer.completeError(error, stack);
    }));
    return completer.future;
  }

  Future<void> _run(int generation) async {
    while (_pending && _generation == generation && _foreground) {
      _pending = false;
      final id = moduleId!;
      List<T> lessons;
      try {
        lessons = await fetch(id);
      } catch (error) {
        if (_generation != generation) return;
        lastError = error;
        onError?.call(error);
        // Keep the snapshot; transient failures never become an empty list.
        const delays = [2, 5, 15, 30];
        final delay = delays[_retry.clamp(0, delays.length - 1)];
        _retry++;
        if (_foreground) _timer = Timer(Duration(seconds: delay), refresh);
        return;
      }
      if (_generation != generation) return;
      loadedModuleId = id;
      lastError = null;
      _retry = 0;
      apply(lessons);
    }
  }
}
