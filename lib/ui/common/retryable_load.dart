import 'package:stacked/stacked.dart';

extension RetryableLoad on BaseViewModel {
  /// Reuse Stacked's error/loading state, without starting duplicate requests.
  /// Pass a factory so the request starts only after the busy/disposed guard.
  Future<void> runReadLoad(Future<void> Function() load,
      {required Object busyObject}) async {
    if (disposed || busy(busyObject)) return;
    await runBusyFuture(Future<void>.sync(load), busyObject: busyObject);
  }
}
