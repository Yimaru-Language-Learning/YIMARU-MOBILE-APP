import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_device/safe_device.dart';
import 'package:stacked/stacked.dart';

class DeveloperModeService with ListenableServiceMixin {
  DeveloperModeService() {
    _init();
  }

  final _statusController = StreamController<bool>.broadcast();

  final ReactiveValue<bool> _developerModeEnabled = ReactiveValue<bool>(false);

  Timer? _pollTimer;

  bool _isDisposed = false;

  AppLifecycleListener? _lifecycleListener;

  static const _pollInterval = Duration(seconds: 3);

  Stream<bool> get statusStream => _statusController.stream;

  bool get developerModeEnabled => _developerModeEnabled.value;

  void _init() {
    listenToReactiveValues([_developerModeEnabled]);
    // Allow development on devices with Developer Options enabled.
    if (kDebugMode) return;

    _check();
    _pollTimer = Timer.periodic(_pollInterval, (_) => _check());

    _lifecycleListener = AppLifecycleListener(onResume: () => _check());
  }

  void dispose() {
    _isDisposed = true;
    _pollTimer?.cancel();
    _lifecycleListener?.dispose();
    _statusController.close();
  }

  Future<void> _check() async {
    if (kDebugMode || _isDisposed) return;
    try {
      final currentlyEnabled = await SafeDevice.isDevelopmentModeEnable;

      if (_developerModeEnabled.value != currentlyEnabled) {
        _developerModeEnabled.value = currentlyEnabled;
        _statusController.add(currentlyEnabled);
      }
    } catch (e) {
      return;
    }
  }

  Future<void> checkNow() => _check();

  void exitApp() {
    SystemNavigator.pop();
  }
}
