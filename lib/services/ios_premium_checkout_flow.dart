/// Serializes the entire contact → notice → delivery sequence across entry points.
/// A dismissed dialog or an account/navigation change must never trigger delivery.
class IosPremiumCheckoutFlow {
  Object? _owner;
  bool Function()? _isCurrent;
  void Function()? _onSuperseded;

  Future<void> run({
    required bool Function() isCurrent,
    required bool Function() needsPhone,
    required Future<bool> Function() collectPhone,
    required Future<bool> Function() confirmHardcopy,
    required Future<void> Function() sendLink,
    void Function()? onSuperseded,
  }) async {
    if (!isCurrent()) return;
    if (_owner != null && (_isCurrent?.call() ?? false)) return;
    // An obsolete screen/session must not hold the next account's flow hostage.
    _onSuperseded?.call();
    final owner = Object();
    _owner = owner;
    _isCurrent = isCurrent;
    _onSuperseded = onSuperseded;
    try {
      if (needsPhone() && !await collectPhone()) return;
      if (!isCurrent() || needsPhone()) return;
      if (!await confirmHardcopy() || !isCurrent()) return;
      await sendLink();
    } finally {
      // A late old response must never unlock a newer in-flight sequence.
      if (identical(_owner, owner)) {
        _owner = null;
        _isCurrent = null;
        _onSuperseded = null;
      }
    }
  }
}
