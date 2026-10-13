import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../app/app.locator.dart';
import 'api_service.dart';
import 'authentication_service.dart';

/// Only foreground use counts; startup and navigation never wait for this call.
class ReminderActivityService with WidgetsBindingObserver {
  ReminderActivityService(
      {Future<int?> Function()? getUserId,
      Future<void> Function(CancelToken)? sendActivity,
      DateTime Function()? now})
      : _getUserId = getUserId ??
            (() async {
              final auth = locator<AuthenticationService>();
              return await auth.getAccessToken() == null
                  ? null
                  : auth.getUserId();
            }),
        _sendActivity = sendActivity ??
            ((token) => locator<ApiService>().recordReminderActivity(token)),
        _now = now ?? DateTime.now;
  final Future<int?> Function() _getUserId;
  final Future<void> Function(CancelToken) _sendActivity;
  final DateTime Function() _now;
  Timer? _timer;
  CancelToken? _cancellation;
  int? _userId;
  int _generation = 0;
  int? _busyGeneration;
  bool _foreground = true;
  bool _disposed = false;
  DateTime? _lastSuccess;
  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    _foreground = WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
    unawaited(_restore(_generation));
  }

  Future<void> _restore(int generation) async {
    try {
      final id = await _getUserId();
      if (!_disposed && generation == _generation && id != null) {
        beginSession(id);
      }
    } catch (_) {/* Login/resume can recover. */}
  }

  void beginSession(int id) {
    if (_disposed) return;
    if (_userId != id) {
      endSession();
      _userId = id;
    }
    unawaited(ping());
  }

  void endSession() {
    _generation++;
    _timer?.cancel();
    _cancellation?.cancel();
    _userId = null;
    _lastSuccess = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    if (!_foreground) {
      _generation++;
      _timer?.cancel();
      _cancellation?.cancel();
    } else if (_userId != null) {
      unawaited(ping());
    } else {
      unawaited(_restore(_generation));
    }
  }

  Future<void> ping() async {
    if (_disposed ||
        !_foreground ||
        _userId == null ||
        _busyGeneration == _generation) {
      return;
    }
    if (_lastSuccess != null &&
        _now().difference(_lastSuccess!) < const Duration(minutes: 1)) {
      _schedule(const Duration(minutes: 1));
      return;
    }
    final generation = _generation;
    final id = _userId;
    final cancellation = CancelToken();
    _cancellation = cancellation;
    _busyGeneration = generation;
    var delay = const Duration(minutes: 5);
    try {
      final current = await _getUserId();
      if (_disposed ||
          generation != _generation ||
          !_foreground ||
          id != current) {
        if (generation == _generation && id != current) endSession();
        return;
      }
      await _sendActivity(cancellation);
      if (generation == _generation) _lastSuccess = _now();
    } catch (_) {
      delay = const Duration(minutes: 1);
    } finally {
      if (_busyGeneration == generation) {
        _busyGeneration = null;
      }
      if (generation == _generation) {
        _schedule(delay);
      }
    }
  }

  void _schedule(Duration delay) {
    _timer?.cancel();
    if (!_disposed && _foreground && _userId != null) {
      _timer = Timer(delay, () => unawaited(ping()));
    }
  }

  void dispose() {
    _disposed = true;
    endSession();
    WidgetsBinding.instance.removeObserver(this);
  }
}
