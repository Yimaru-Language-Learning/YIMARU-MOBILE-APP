import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Session-scoped mobile registration. All triggers share one upload worker.
/// Dependencies are callbacks so recovery can be tested without Firebase/HTTP.
class DeviceTokenSync {
  DeviceTokenSync({
    required Future<String?> Function() getToken,
    required Future<int?> Function() getAuthenticatedUserId,
    required Future<void> Function(String token, CancelToken cancellation)
        registerToken,
  })  : _getToken = getToken,
        _getAuthenticatedUserId = getAuthenticatedUserId,
        _registerToken = registerToken;

  final Future<String?> Function() _getToken;
  final Future<int?> Function() _getAuthenticatedUserId;
  final Future<void> Function(String, CancelToken) _registerToken;

  static const _retryDelays = [
    Duration(seconds: 5),
    Duration(seconds: 30),
    Duration(seconds: 120),
  ];

  int? _userId;
  int _sessionGeneration = 0;
  int _tokenRevision = 0;
  int _credentialRevision = 0;
  String? _latestToken;
  String? _registeredToken;
  String? _rejectedToken;
  bool _pending = false;
  bool _needsTokenLookup = true;
  bool _running = false;
  bool _rerun = false;
  bool _foreground = true;
  bool _disposed = false;
  int _retryIndex = 0;
  Timer? _retryTimer;
  CancelToken? _uploadCancellation;

  bool get hasPendingSync => _pending;
  String? get currentToken => _latestToken;

  void _log(String message) {
    if (kDebugMode) debugPrint('[FCM Sync] $message');
  }

  /// Only called once credentials are fully saved/restored. A fresh service
  /// always registers once, even if the backend previously disabled its token.
  void beginSession(int userId) {
    if (_disposed || userId <= 0) return;
    if (_userId == userId) return;
    endSession();
    _userId = userId;
    requestSync();
  }

  void endSession() {
    _sessionGeneration++;
    _userId = null;
    _cancelRetry();
    if (_uploadCancellation != null && !_uploadCancellation!.isCancelled) {
      _log('Backend registration cancellation requested: session ended');
    }
    _uploadCancellation?.cancel('Device registration session ended');
    _registeredToken = null;
    _rejectedToken = null;
    _pending = false;
    _needsTokenLookup = true;
    _rerun = false;
    _retryIndex = 0;
    // Keep the installation's latest token; a subsequent login fetches it again.
  }

  void receiveToken(String token) {
    if (_disposed || token.trim().isEmpty) return;
    final next = token.trim();
    if (_latestToken == next) {
      _log(next == _registeredToken
          ? 'Registration skipped: token already registered'
          : 'Unchanged token event ignored');
      return;
    }
    _latestToken = next;
    _tokenRevision++;
    _needsTokenLookup = false;
    _pending = next != _registeredToken;
    _rejectedToken = null;
    _retryIndex = 0;
    _cancelRetry();
    _kick();
  }

  /// Called on resume/connectivity recovery; it does not prompt for permission.
  void requestSync() {
    if (_disposed) return;
    if (_userId == null) {
      _log('Registration deferred: no authenticated session');
      return;
    }
    _needsTokenLookup = true;
    _pending = true;
    _retryIndex = 0;
    _cancelRetry();
    _kick();
  }

  void credentialsUpdated() {
    if (_disposed || _userId == null) return;
    _credentialRevision++;
    _rejectedToken = null;
    requestSync();
  }

  void setForeground(bool foreground) {
    if (_disposed) return;
    final resumed = !_foreground && foreground;
    _foreground = foreground;
    if (!foreground) {
      _cancelRetry();
    } else if (resumed) {
      requestSync();
    }
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    endSession();
  }

  void _kick() {
    if (_disposed || !_pending) return;
    if (!_foreground || _userId == null) {
      _log(_userId == null
          ? 'Registration deferred: no authenticated session'
          : 'Registration deferred: app is backgrounded');
      return;
    }
    if (_running) {
      _rerun = true;
      return;
    }
    _running = true;
    unawaited(_drain());
  }

  Future<void> _drain() async {
    try {
      do {
        _rerun = false;
        await _attempt();
      } while (_rerun && !_disposed && _foreground && _userId != null);
    } finally {
      _running = false;
    }
  }

  bool _isCurrent(int generation) =>
      !_disposed && generation == _sessionGeneration && _userId != null;

  Future<void> _attempt() async {
    final generation = _sessionGeneration;
    final userId = _userId;
    final tokenRevision = _tokenRevision;
    final credentialRevision = _credentialRevision;
    String? attemptedToken;
    CancelToken? cancellation;
    try {
      if (_needsTokenLookup) {
        _needsTokenLookup = false;
        final revision = _tokenRevision;
        _log('Token lookup started');
        final token =
            (await _getToken().timeout(const Duration(seconds: 15)))?.trim();
        if (!_isCurrent(generation)) return;
        _log(token == null || token.isEmpty
            ? 'Token lookup completed: no token available'
            : 'Token lookup completed: token available');
        // A refresh event received during getToken() wins over its older result.
        if (_tokenRevision == revision) {
          _latestToken = token == null || token.isEmpty ? null : token;
        }
      }
      if (!_isCurrent(generation) || !_foreground) return;
      attemptedToken = _latestToken;
      if (attemptedToken == null) {
        _log('Registration deferred: no token available');
        _needsTokenLookup = true;
        _scheduleRetry();
        return;
      }
      if (attemptedToken == _registeredToken) {
        _log('Registration skipped: token already registered');
        _pending = false;
        _cancelRetry();
        return;
      }
      // Rejections wait for a new token, new credentials, or a new session.
      if (attemptedToken == _rejectedToken) {
        _log('Registration deferred: previously rejected token');
        return;
      }

      final authenticatedUserId = await _getAuthenticatedUserId();
      if (!_isCurrent(generation) || !_foreground) return;
      if (authenticatedUserId != userId) {
        _log('Registration stopped: authenticated session no longer matches');
        endSession();
        return;
      }
      // A newer event may have arrived while checking credentials.
      if (attemptedToken != _latestToken) {
        _rerun = true;
        return;
      }
      cancellation = CancelToken();
      _uploadCancellation = cancellation;
      _log('Backend registration started');
      await _registerToken(attemptedToken, cancellation);
      if (!_isCurrent(generation)) return;
      _log('Backend registration succeeded');
      _registeredToken = attemptedToken;
      _retryIndex = 0;
      _cancelRetry();
      _pending = _latestToken != _registeredToken;
      if (_pending) _rerun = true;
    } catch (error) {
      if (!_isCurrent(generation) || cancellation?.isCancelled == true) return;
      _pending = true;
      // Never print the exception message: it may contain request credentials.
      final status = error is DioException ? error.response?.statusCode : null;
      final stage = cancellation != null
          ? 'Backend registration failed'
          : attemptedToken == null
              ? 'Token lookup failed'
              : 'Registration credential check failed';
      _log('$stage '
          '(${error.runtimeType}${status == null ? '' : ', HTTP $status'}).');
      // A new refresh event remains usable even if the older lookup failed.
      if (attemptedToken == null &&
          _tokenRevision != tokenRevision &&
          _latestToken != null) {
        _needsTokenLookup = false;
        _rerun = true;
        return;
      }
      if (status == 401 && _credentialRevision != credentialRevision) {
        _rerun = true;
        return;
      }
      if (attemptedToken != null && attemptedToken != _latestToken) {
        _rerun = true;
        return;
      }
      if (_isRetryable(error)) {
        _needsTokenLookup = true;
        _scheduleRetry();
      } else {
        _rejectedToken = attemptedToken;
      }
    } finally {
      if (identical(_uploadCancellation, cancellation)) {
        _uploadCancellation = null;
      }
    }
  }

  bool _isRetryable(Object error) {
    if (error is! DioException) {
      return true; // Token acquisition, bounded below.
    }
    if (error.type == DioExceptionType.cancel ||
        error.type == DioExceptionType.badCertificate) {
      return false;
    }
    final status = error.response?.statusCode;
    return status == null || status == 408 || status == 429 || status >= 500;
  }

  void _scheduleRetry() {
    if (_disposed ||
        !_foreground ||
        _userId == null ||
        _retryTimer != null ||
        _retryIndex >= _retryDelays.length) {
      if (!_disposed &&
          _foreground &&
          _userId != null &&
          _retryTimer == null &&
          _retryIndex >= _retryDelays.length) {
        _log('Retry limit reached: waiting for a recovery trigger');
      }
      return;
    }
    _log('Retry scheduled in ${_retryDelays[_retryIndex].inSeconds}s');
    _retryTimer = Timer(_retryDelays[_retryIndex++], () {
      _retryTimer = null;
      _needsTokenLookup = true;
      _kick();
    });
  }

  void _cancelRetry() {
    _retryTimer?.cancel();
    _retryTimer = null;
  }
}
