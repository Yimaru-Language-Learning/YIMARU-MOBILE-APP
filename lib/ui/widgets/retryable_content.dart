import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/translations/locale_keys.g.dart';
import 'custom_circular_progress_indicator.dart';

/// A failed read is distinct from a successfully loaded, empty result.
class RetryableContent extends StatelessWidget {
  const RetryableContent({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.onRetry,
    required this.builder,
    this.loading,
    this.keepContentOnError = false,
  });

  final bool isLoading;
  final bool hasError;
  final Future<void> Function() onRetry;
  final Widget Function() builder;
  final Widget? loading;
  final bool keepContentOnError;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loading ??
          const Center(
              child: CustomCircularProgressIndicator(color: kcPrimaryColor));
    }
    if (hasError) {
      final error = LoadErrorIndicator(onRetry: onRetry);
      if (!keepContentOnError) return error;
      return Column(
          mainAxisSize: MainAxisSize.min, children: [error, builder()]);
    }
    return builder();
  }
}

class LoadErrorIndicator extends StatefulWidget {
  const LoadErrorIndicator({super.key, required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  State<LoadErrorIndicator> createState() => _LoadErrorIndicatorState();
}

class _LoadErrorIndicatorState extends State<LoadErrorIndicator> {
  bool _retrying = false;

  Future<void> _retry() async {
    if (_retrying) return;
    setState(() => _retrying = true);
    try {
      await widget.onRetry();
    } catch (_) {
      // Keep the recovery control available; don't expose raw server errors.
    } finally {
      if (mounted) setState(() => _retrying = false);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: kcPrimaryColor, size: 32),
            const SizedBox(height: 12),
            Text(LocaleKeys.load_error_title.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(LocaleKeys.load_error_description.tr(),
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _retrying ? null : _retry,
              icon: _retrying
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.refresh),
              label: Text(LocaleKeys.retry.tr()),
            ),
          ],
        ),
      );
}
