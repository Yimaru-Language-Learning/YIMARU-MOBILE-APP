import 'dart:io';
import 'package:dio/dio.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../models/access.dart';
import '../models/user.dart';
import '../ui/common/enmus.dart';
import '../ui/common/translations/locale_keys.g.dart';
import '../ui/widgets/premium_phone_dialog.dart';
import 'api_service.dart';
import 'authentication_service.dart';
import 'ios_premium_checkout_flow.dart';

// Only intercept subscription locks. Sequential/prerequisite locks keep their
// existing handling; inherited FREE and OPEN_LEARNER content stays accessible.
// Practice Start separately preserves the subscription-only check on Android
// and iOS; FREE parent metadata does not bypass that check.
Future<bool> interceptIosPremium(SubscriptionType type,
    {String? effectiveAccessTier,
    Access? access,
    BuildContext? context,
    bool? isIOS}) async {
  if (!(isIOS ?? Platform.isIOS) ||
      effectiveAccessTier?.toUpperCase() != 'PREMIUM' ||
      access?.isAccessible == false) {
    return false;
  }
  final user = locator<AuthenticationService>().user;
  if (user?.userId == null) return true;
  final subscribed = switch (type) {
    SubscriptionType.learn => user?.learn ?? false,
    SubscriptionType.duolingo => user?.duolingo ?? false,
    SubscriptionType.ielts => user?.ielts ?? false,
  };
  if (subscribed) return false;
  // A web purchase may have activated since the last profile refresh. Do not
  // replace the whole cached profile here: account changes must remain isolated.
  final auth = locator<AuthenticationService>();
  final generation = auth.sessionGeneration;
  final profile = await _readAccess<User>(
      context: context,
      isCurrent: () =>
          generation == auth.sessionGeneration &&
          (context == null ||
              (context.mounted && ModalRoute.of(context)?.isCurrent != false)),
      read: () async {
        final response =
            await locator<ApiService>().getProfileData(user!.userId);
        final data = response['data'];
        if (response['status'] != ResponseStatus.success || data is! User) {
          throw StateError('Could not verify subscription');
        }
        return data;
      });
  if (generation != auth.sessionGeneration ||
      (context != null &&
          (!context.mounted || ModalRoute.of(context)?.isCurrent == false))) {
    return true;
  }
  if (profile == null) {
    return true; // Unknown access never authorizes navigation.
  }
  final category = switch (type) {
    SubscriptionType.learn => 'LEARN_ENGLISH',
    SubscriptionType.duolingo => 'DUOLINGO',
    SubscriptionType.ielts => 'IELTS',
  };
  if (profile.activeSubscriptions?.any((subscription) =>
          subscription.category == category &&
          subscription.status == 'ACTIVE') ??
      false) {
    return false;
  }
  final phone = profile.phoneNumber?.trim();
  if ((auth.user?.phoneNumber?.trim().isEmpty ?? true) &&
      phone != null &&
      phone.isNotEmpty) {
    final saved = await _readAccess<bool>(
        context: context,
        isCurrent: () =>
            generation == auth.sessionGeneration &&
            (context == null ||
                (context.mounted &&
                    ModalRoute.of(context)?.isCurrent != false)),
        read: () async {
          await auth.saveContactPhone(phone,
              expectedSessionGeneration: generation);
          return true;
        });
    if (saved != true) return true;
    if (generation != auth.sessionGeneration ||
        (context != null &&
            (!context.mounted || ModalRoute.of(context)?.isCurrent == false))) {
      return true;
    }
  }
  await locator<PremiumPurchaseService>().open(type, context: context);
  return true;
}

class PremiumPurchaseService {
  PremiumPurchaseService({bool? isIOS}) : _isIOS = isIOS ?? Platform.isIOS;
  final bool _isIOS;
  final _flow = IosPremiumCheckoutFlow();

  Future<void> open(SubscriptionType type, {BuildContext? context}) async {
    if (!_isIOS) {
      await locator<NavigationService>().navigateToSubscriptionView(type: type);
      return;
    }
    // A navigator's context outlives its pages and cannot identify the caller.
    // Never let that fallback keep an obsolete purchase flow alive.
    final origin = context;
    if (origin == null || !origin.mounted) return;
    final route = ModalRoute.of(origin);
    if (route == null || !route.isCurrent) return;
    final auth = locator<AuthenticationService>();
    final generation = auth.sessionGeneration;
    final userId = auth.user?.userId;
    if (userId == null) return;
    final cancellation = CancelToken();
    ModalRoute<dynamic>? ownedDialog;
    bool current() =>
        origin.mounted &&
        route.isActive &&
        (route.isCurrent || ownedDialog?.isCurrent == true) &&
        auth.sessionGeneration == generation &&
        auth.user?.userId == userId;
    try {
      await _flow.run(
        isCurrent: current,
        onSuperseded: () => cancellation.cancel('Purchase flow superseded'),
        needsPhone: () => auth.user?.phoneNumber?.trim().isEmpty ?? true,
        collectPhone: () async =>
            await showDialog<bool>(
              context: origin,
              builder: (dialogContext) {
                ownedDialog = ModalRoute.of(dialogContext);
                return PremiumPhoneDialog(
                  isCurrent: current,
                  savePhone: (phone) async {
                    if (!current()) return false;
                    final api = locator<ApiService>();
                    String saved;
                    try {
                      saved = await api.addContactPhone(phone,
                          cancelToken: cancellation);
                    } on DioException catch (error) {
                      if (error.response?.statusCode != 409 || !current()) {
                        rethrow;
                      }
                      // Another device may have filled the missing contact.
                      // Recover our own saved phone; never overwrite it or
                      // adopt a number belonging to a different account.
                      final response = await api.getProfileData(userId);
                      if (!current()) return false;
                      final profile = response['data'];
                      if (response['status'] != ResponseStatus.success ||
                          profile is! User ||
                          (profile.userId != null &&
                              profile.userId != userId) ||
                          (profile.phoneNumber?.trim().isEmpty ?? true)) {
                        throw StateError('Could not recover saved contact');
                      }
                      saved = profile.phoneNumber!.trim();
                    }
                    if (!current()) return false;
                    await auth.saveContactPhone(saved,
                        expectedSessionGeneration: generation);
                    return current();
                  },
                );
              },
            ) ??
            false,
        confirmHardcopy: () async =>
            await showDialog<bool>(
              context: origin,
              builder: (dialogContext) {
                ownedDialog = ModalRoute.of(dialogContext);
                return AlertDialog(
                  title: Text(LocaleKeys.notice.tr()),
                  content: SingleChildScrollView(
                      child: Text(LocaleKeys.ios_purchase.tr())),
                  actions: [
                    TextButton(
                        onPressed: () => _closeDialog(dialogContext, false),
                        child: Text(LocaleKeys.cancel.tr())),
                    TextButton(
                        onPressed: () => _closeDialog(dialogContext, true),
                        child: Text(LocaleKeys.cont.tr())),
                  ],
                );
              },
            ) ??
            false,
        sendLink: () async {
          final result = await locator<ApiService>().iosCheckout({
            'category': switch (type) {
              SubscriptionType.learn => 'LEARN_ENGLISH',
              SubscriptionType.duolingo => 'DUOLINGO',
              SubscriptionType.ielts => 'IELTS',
            },
          }, cancelToken: cancellation);
          if (!origin.mounted || !current()) return;
          final String message;
          if (result['status'] == ResponseStatus.success) {
            message = result['channel'] == 'sms'
                ? 'checkout_link_sms'
                : 'checkout_link_email';
          } else {
            message = switch (result['statusCode']) {
              429 => 'checkout_link_recent',
              409 => 'checkout_already_subscribed',
              _ => 'checkout_link_uncertain',
            };
          }
          await showDialog<void>(
              context: origin,
              builder: (dialogContext) {
                ownedDialog = ModalRoute.of(dialogContext);
                return AlertDialog(
                  title: Text(LocaleKeys.notice.tr()),
                  content: SingleChildScrollView(child: Text(message.tr())),
                  actions: [
                    TextButton(
                        onPressed: () => _closeDialog<void>(dialogContext),
                        child: Text(LocaleKeys.close.tr()))
                  ],
                );
              });
        },
      );
    } finally {
      cancellation.cancel('Purchase flow finished');
    }
  }

  void _closeDialog<T>(BuildContext context, [T? result]) {
    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.pop(context, result);
    }
  }
}

// Retry only the read, never the checkout-link POST. Returning null means the
// caller must stay put (cancelled, obsolete, or still unable to verify access).
Future<T?> _readAccess<T>(
    {BuildContext? context,
    required bool Function() isCurrent,
    required Future<T> Function() read}) async {
  while (isCurrent()) {
    try {
      final result = await read();
      return isCurrent() ? result : null;
    } catch (_) {
      if (!isCurrent()) return null;
      final origin = context;
      if (origin == null || !origin.mounted) return null;
      final retry = await showDialog<bool>(
          context: origin,
          builder: (dialogContext) => AlertDialog(
                title: Text(LocaleKeys.load_error_title.tr()),
                content: SingleChildScrollView(
                    child: Text('checkout_access_failed'.tr())),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (ModalRoute.of(dialogContext)?.isCurrent == true) {
                          Navigator.pop(dialogContext, false);
                        }
                      },
                      child: Text(LocaleKeys.close.tr())),
                  TextButton(
                      onPressed: () {
                        if (ModalRoute.of(dialogContext)?.isCurrent == true) {
                          Navigator.pop(dialogContext, true);
                        }
                      },
                      child: Text(LocaleKeys.retry.tr())),
                ],
              ));
      if (retry != true) return null;
    }
  }
  return null;
}
