import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:play_install_referrer/play_install_referrer.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

class ReferralService {
  static const String _kPendingReferralCode = 'pending_referral_code';
  static const String _kPendingAttributionType = 'pending_attribution_type';
  static const String _kReferralAttributedDone = 'referral_attributed_done';
  static const String _kPlayReferrerChecked = 'play_referrer_checked';

  final _secureStorage = locator<SecureStorageService>();
  final _apiService = locator<ApiService>();

  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  ReferralService() {
    _appLinks = AppLinks();
  }

  /// Initialize deep link listeners and check the Google Play Install Referrer.
  Future<void> initialize() async {
    try {
      await _checkInstallReferrer();
    } catch (e) {
      debugPrint('[ReferralService] Error checking install referrer: $e');
    }

    try {
      await _initDeepLinks();
    } catch (e) {
      debugPrint('[ReferralService] Error initializing deep links: $e');
    }
  }

  /// 1. Android Google Play Install Referrer
  Future<void> _checkInstallReferrer() async {
    if (!Platform.isAndroid) return;

    final isDone = await isAttributed();
    if (isDone) return;

    final alreadyChecked =
        await _secureStorage.getBool(_kPlayReferrerChecked) ?? false;
    if (alreadyChecked) return;

    try {
      final referrerDetails = await PlayInstallReferrer.installReferrer;
      await _secureStorage.setBool(_kPlayReferrerChecked, true);

      final rawReferrer = referrerDetails.installReferrer;
      if (rawReferrer == null || rawReferrer.trim().isEmpty) return;

      // The raw referrer is typically url-encoded: "utm_source=referral&utm_campaign=BEZA20"
      final uri = Uri.parse('https://dummy/?$rawReferrer');
      final campaignCode = uri.queryParameters['utm_campaign'] ??
          uri.queryParameters['ref'] ??
          uri.queryParameters['referral_code'];

      if (campaignCode != null && campaignCode.trim().isNotEmpty) {
        final cleanCode = campaignCode.trim().toUpperCase();
        await savePendingReferral(cleanCode,
            attributionType: 'PLAY_REFERRER');
        debugPrint(
            '[ReferralService] Captured Play Store install referrer: $cleanCode');
      }
    } catch (e) {
      debugPrint('[ReferralService] PlayInstallReferrer exception: $e');
    }
  }

  /// 2. Deep Links (App Links on Android & Universal Links on iOS)
  Future<void> _initDeepLinks() async {
    // Check if app was launched via a deep link
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleIncomingUri(initialUri);
      }
    } catch (e) {
      debugPrint('[ReferralService] Failed to get initial link: $e');
    }

    // Listen for incoming deep links while app is foregrounded or backgrounded
    _linkSubscription?.cancel();
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        _handleIncomingUri(uri);
      },
      onError: (err) {
        debugPrint('[ReferralService] uriLinkStream error: $err');
      },
    );
  }

  void _handleIncomingUri(Uri uri) {
    debugPrint('[ReferralService] Received incoming URI: $uri');
    String? extractedCode;

    // Pattern 1: https://api.yimaruacademy.com/r/:code or yimaru://r/:code
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'r') {
      if (uri.pathSegments.length >= 2) {
        extractedCode = uri.pathSegments[1];
      }
    } else if (uri.host == 'r' && uri.pathSegments.isNotEmpty) {
      // e.g. yimaru://r/CODE
      extractedCode = uri.pathSegments.first;
    } else if (uri.queryParameters.containsKey('ref')) {
      // Pattern 2: ?ref=:code
      extractedCode = uri.queryParameters['ref'];
    } else if (uri.queryParameters.containsKey('referral_code')) {
      extractedCode = uri.queryParameters['referral_code'];
    } else if (uri.queryParameters.containsKey('utm_campaign')) {
      extractedCode = uri.queryParameters['utm_campaign'];
    }

    if (extractedCode != null && extractedCode.trim().isNotEmpty) {
      final cleanCode = extractedCode.trim().toUpperCase();
      savePendingReferral(cleanCode, attributionType: 'DEEP_LINK');
    }
  }

  /// Saves pending referral code and attribution type in secure storage.
  Future<void> savePendingReferral(String code,
      {String attributionType = 'PROMO_CODE'}) async {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode.isEmpty) return;

    final isDone = await isAttributed();
    if (isDone) return;

    await _secureStorage.setString(_kPendingReferralCode, cleanCode);
    await _secureStorage.setString(_kPendingAttributionType, attributionType);
    debugPrint(
        '[ReferralService] Saved pending referral: $cleanCode ($attributionType)');
  }

  /// Returns current pending referral code if any.
  Future<String?> getPendingReferralCode() async {
    return await _secureStorage.getString(_kPendingReferralCode);
  }

  /// Returns current pending attribution type.
  Future<String> getPendingAttributionType() async {
    return await _secureStorage.getString(_kPendingAttributionType) ??
        'PROMO_CODE';
  }

  /// Checks if this device/user has already completed attribution.
  Future<bool> isAttributed() async {
    return await _secureStorage.getBool(_kReferralAttributedDone) ?? false;
  }

  /// Clears any pending referral code.
  Future<void> clearPendingReferral() async {
    await _secureStorage.delete(_kPendingReferralCode);
    await _secureStorage.delete(_kPendingAttributionType);
  }

  /// Marks attribution complete so future links don't overwrite.
  Future<void> markAttributedDone() async {
    await _secureStorage.setBool(_kReferralAttributedDone, true);
    await clearPendingReferral();
  }

  /// Verifies a referral code in real-time against backend.
  Future<Map<String, dynamic>> verifyReferralCode(String code) async {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode.isEmpty) {
      return {
        'status': ResponseStatus.failure,
        'message': 'Please enter a referral code',
      };
    }
    return await _apiService.verifyReferralCode(cleanCode);
  }

  /// Attributes a user directly via POST /referral/attribute.
  Future<bool> attributeUser(String code,
      {String attributionType = 'PROMO_CODE'}) async {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode.isEmpty) return false;

    try {
      final response = await _apiService.attributeReferral({
        'referral_code': cleanCode,
        'attribution_type': attributionType,
      });

      if (response['status'] == ResponseStatus.success) {
        await markAttributedDone();
        debugPrint(
            '[ReferralService] User attributed successfully to code: $cleanCode');
        return true;
      }
    } catch (e) {
      debugPrint('[ReferralService] Attribution error: $e');
    }
    return false;
  }

  /// Attributes the pending referral code if one exists.
  Future<bool> attributePendingIfAny() async {
    final pendingCode = await getPendingReferralCode();
    if (pendingCode == null || pendingCode.isEmpty) return false;

    final attrType = await getPendingAttributionType();
    return await attributeUser(pendingCode, attributionType: attrType);
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
