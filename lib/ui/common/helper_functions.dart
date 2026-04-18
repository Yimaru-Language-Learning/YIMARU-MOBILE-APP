import 'dart:math';
import 'dart:ui';

import 'app_colors.dart';

// Split full name
Map<String, String> splitFullName(String fullName) {
  final parts = fullName.trim().split(RegExp(r'\s+'));

  if (parts.length == 1) {
    return {
      'last_name': '',
      'nick_name': parts[0],
      'first_name': parts[0],
    };
  }

  return {
    'nick_name': parts.first,
    'first_name': parts.first,
    'last_name': parts.sublist(1).join(' '),
  };
}

// Get random color
Color getColor() {
  final generator = Random();
  int random = generator.nextInt(8);
  if (random == 1) {
    return kcRed.withValues(alpha: 0.2);
  } else if (random == 2) {
    return kcPrimaryColor.withValues(alpha: 0.2);
  } else if (random == 3) {
    return kcOrange.withValues(alpha: 0.2);
  } else if (random == 4) {
    return kcGreen.withValues(alpha: 0.2);
  } else if (random == 5) {
    return kcBlue.withValues(alpha: 0.2);
  } else if (random == 6) {
    return kcSkyBlue.withValues(alpha: 0.2);
  } else if (random == 7) {
    return kcIndigo.withValues(alpha: 0.2);
  } else {
    return kcAquamarine.withValues(alpha: 0.2);
  }
}

// Get playable url
String? getPlayableUrl(String url) {
  try {
    // Case 1: /file/d/FILE_ID/view
    final fileIdRegex = RegExp(r'/file/d/([a-zA-Z0-9_-]+)');
    final match1 = fileIdRegex.firstMatch(url);

    if (match1 != null) {
      final fileId = match1.group(1);
      return "https://drive.google.com/uc?export=download&id=$fileId";
    }

    // Case 2: open?id=FILE_ID
    final uri = Uri.parse(url);
    if (uri.queryParameters.containsKey('id')) {
      final fileId = uri.queryParameters['id'];
      return "https://drive.google.com/uc?export=download&id=$fileId";
    }

    // Already converted or normal URL
    return url;
  } catch (e) {
    return null;
  }
}
