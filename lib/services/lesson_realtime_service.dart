import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';

import '../app/app.locator.dart';
import '../ui/common/app_constants.dart';
import 'secure_storage_service.dart';

class _LessonWatch {
  _LessonWatch(this.moduleId, this.refresh, this.reset, this.setForeground);
  final int moduleId;
  final void Function() refresh;
  final void Function() reset;
  final void Function(bool) setForeground;
}

/// A single foreground connection, shared by LMS and exam-prep lesson lists.
class LessonRealtimeService with WidgetsBindingObserver {
  LessonRealtimeService({
    Future<String?> Function()? getToken,
    Future<WebSocket> Function(String)? connect,
  })  : _getToken = getToken ??
            (() => locator<SecureStorageService>().getString('accessToken')),
        _connectSocket = connect ?? WebSocket.connect;

  final Future<String?> Function() _getToken;
  final Future<WebSocket> Function(String) _connectSocket;
  final Map<String, _LessonWatch> _watches = {};
  final Map<String, Timer> _subscriptionRetries = {};
  WebSocket? _socket;
  StreamSubscription<dynamic>? _subscription;
  Timer? _retryTimer;
  int _generation = 0;
  int? _connectingGeneration;
  int _attempt = 0;
  bool _foreground = true;
  bool _disposed = false;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    final state = WidgetsBinding.instance.lifecycleState;
    _foreground = state == null || state == AppLifecycleState.resumed;
  }

  void watch(
    String domain,
    int moduleId, {
    required void Function() refresh,
    required void Function() reset,
    required void Function(bool) setForeground,
  }) {
    if (_disposed) return;
    final previous = _watches[domain];
    final watch = _LessonWatch(moduleId, refresh, reset, setForeground);
    _watches[domain] = watch;
    setForeground(_foreground);
    if (previous?.moduleId != moduleId && _socket != null) {
      _subscriptionRetries.remove(domain)?.cancel();
      if (previous != null) {
        _send('unsubscribe', domain, previous.moduleId);
      }
      _send('subscribe', domain, moduleId);
    }
    unawaited(_connect());
  }

  void credentialsUpdated() {
    _disconnect();
    _attempt = 0;
    unawaited(_connect());
  }

  void reset() {
    _disconnect();
    for (final watch in _watches.values) {
      watch.reset();
    }
    _watches.clear();
    _attempt = 0;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    for (final watch in _watches.values) {
      watch.setForeground(_foreground);
    }
    if (_foreground) {
      unawaited(_connect());
    } else {
      _disconnect();
    }
  }

  void _send(String type, String domain, int moduleId) {
    _socket?.add(
        jsonEncode({'type': type, 'domain': domain, 'module_id': moduleId}));
  }

  Future<void> _connect() async {
    if (_disposed ||
        !_foreground ||
        _watches.isEmpty ||
        _socket != null ||
        _connectingGeneration != null) {
      return;
    }
    _retryTimer?.cancel();
    final generation = _generation;
    _connectingGeneration = generation;
    try {
      final token = await _getToken();
      if (generation != _generation || token == null || token.isEmpty) return;
      final base = Uri.parse(kBaseUrl);
      final uri = base.replace(
        scheme: base.scheme == 'https' ? 'wss' : 'ws',
        path: '/$kApiUrl/$kApiVersionUrl/ws/connect',
        queryParameters: {'token': token},
      );
      final socket = await _connectSocket(uri.toString());
      if (generation != _generation || !_foreground || _disposed) {
        await socket.close();
        return;
      }
      _socket = socket;
      socket.pingInterval = const Duration(seconds: 25);
      _attempt = 0;
      _subscription = socket.listen(
        (data) => _message(data, generation),
        onError: (Object error) => _lost(generation),
        onDone: () => _lost(generation),
        cancelOnError: true,
      );
      for (final entry in _watches.entries) {
        _send('subscribe', entry.key, entry.value.moduleId);
      }
    } catch (_) {
      if (generation == _generation) {
        // REST refresh uses the app's existing 401/token-refresh interceptor.
        for (final watch in _watches.values) {
          watch.refresh();
        }
        _scheduleReconnect();
      }
    } finally {
      if (_connectingGeneration == generation) _connectingGeneration = null;
    }
  }

  void _message(dynamic data, int generation) {
    if (generation != _generation || data is! String) return;
    try {
      final message = jsonDecode(data);
      if (message is! Map<String, dynamic>) return;
      final watch = _watches[message['domain']];
      if (watch == null || watch.moduleId != message['module_id']) return;
      if (message['type'] == 'lessons.changed' ||
          message['type'] == 'subscribed' ||
          message['type'] == 'subscription.denied') {
        watch.refresh();
      }
      final domain = message['domain'] as String;
      if (message['type'] == 'subscribed') {
        _subscriptionRetries.remove(domain)?.cancel();
      } else if (message['type'] == 'subscription.denied') {
        _subscriptionRetries.remove(domain)?.cancel();
        _subscriptionRetries[domain] = Timer(const Duration(seconds: 30), () {
          // Reopening the same module replaces its callbacks, not its scope.
          if (generation == _generation &&
              _watches[domain]?.moduleId == watch.moduleId) {
            _send('subscribe', domain, watch.moduleId);
          }
        });
      }
    } catch (_) {/* Ignore unrelated/malformed messages. */}
  }

  void _lost(int generation) {
    if (generation != _generation) return;
    _disconnect();
    // Also recovers auth when the backend closes an expired connection.
    for (final watch in _watches.values) {
      watch.refresh();
    }
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_disposed || !_foreground || _watches.isEmpty) return;
    _retryTimer?.cancel();
    final seconds = min(30, 1 << min(_attempt++, 5));
    _retryTimer = Timer(
      Duration(milliseconds: seconds * 1000 + Random().nextInt(500)),
      () => unawaited(_connect()),
    );
  }

  void _disconnect() {
    _generation++;
    _connectingGeneration = null;
    _retryTimer?.cancel();
    unawaited(_subscription?.cancel());
    for (final timer in _subscriptionRetries.values) {
      timer.cancel();
    }
    _subscriptionRetries.clear();
    _subscription = null;
    final socket = _socket;
    _socket = null;
    if (socket != null) unawaited(socket.close());
  }

  void dispose() {
    _disposed = true;
    reset();
    WidgetsBinding.instance.removeObserver(this);
  }
}
