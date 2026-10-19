import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

/// Installed-build diagnostics only; never used for authentication or access.
class AppRequestMetadata {
  AppRequestMetadata({
    Future<PackageInfo> Function()? loadPackageInfo,
    String? platform,
    DateTime Function()? now,
    this.timeout = const Duration(seconds: 1),
    this.retryDelay = const Duration(seconds: 30),
  })  : _loadPackageInfo = loadPackageInfo ?? PackageInfo.fromPlatform,
        _now = now ?? DateTime.now {
    final installedPlatform = platform ?? Platform.operatingSystem;
    _cached = Map.unmodifiable({
      if (installedPlatform == 'android' || installedPlatform == 'ios')
        'X-App-Platform': installedPlatform,
    });
  }

  final Future<PackageInfo> Function() _loadPackageInfo;
  final DateTime Function() _now;
  final Duration timeout;
  final Duration retryDelay;
  late Map<String, String> _cached;
  Future<Map<String, String>>? _attempt;
  DateTime? _retryAt;
  bool _complete = false;
  bool _started = false;
  bool _waitForAttempt = true;

  Future<Map<String, String>> get headers {
    if (_complete || (_retryAt != null && _now().isBefore(_retryAt!))) {
      return Future.value(_cached);
    }
    // A timed-out native call remains single-flight. Its late result is still
    // useful; subsequent requests reuse the resolved fallback without waiting.
    if (_attempt != null) {
      return _waitForAttempt ? _attempt! : Future.value(_cached);
    }
    final firstAttempt = !_started;
    _started = true;
    _waitForAttempt = firstAttempt;
    _attempt = _load().timeout(timeout, onTimeout: () => _cached);
    // Only the first lookup may wait. Recovery lookups are request-triggered,
    // throttled, and background-only; they never delay content or token refresh.
    return firstAttempt ? _attempt! : Future.value(_cached);
  }

  Future<Map<String, String>> _load() async {
    try {
      final info = await Future<PackageInfo>.sync(_loadPackageInfo);
      final headers = Map<String, String>.from(_cached);
      final safeValue = RegExp(r'^[A-Za-z0-9._+-]{1,64}$');
      bool valid(String value) =>
          value.isNotEmpty &&
          safeValue.matchAsPrefix(value)?.end == value.length;
      if (valid(info.version)) {
        headers['X-App-Version'] = info.version;
      }
      if (valid(info.buildNumber)) {
        headers['X-App-Build'] = info.buildNumber;
      }
      _cached = Map.unmodifiable(headers);
      _complete = headers.containsKey('X-App-Version') &&
          headers.containsKey('X-App-Build');
    } catch (_) {
      // Optional diagnostics must not prevent login, content loads, or refresh.
    } finally {
      _retryAt = _now().add(retryDelay);
      _attempt = null;
    }
    return _cached;
  }
}
