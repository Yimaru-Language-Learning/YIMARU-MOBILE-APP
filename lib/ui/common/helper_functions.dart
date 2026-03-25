// Split full name
import 'dart:math';
import 'dart:ui';

import 'app_colors.dart';

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
