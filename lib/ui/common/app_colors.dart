import 'package:flutter/material.dart';

// ============================================================================
// LEGACY CONSTANTS (Preserved to prevent regressions across existing screens)
// ============================================================================
const Color kcBlack = Colors.black;
const Color kcRed = Color(0xffFF4C4C);
const Color kcBlue = Color(0xff135BEC);
const Color kcGreen = Color(0xFF1DE964);
const Color kcBackgroundColor = kcWhite;
const Color kcWhite = Color(0xFFFFFFFF);
const Color kcViolet = Color(0x336A1B9A);
const Color kcIndigo = Color(0xff6A1B9A);
const Color kcOrange = Color(0xFFF79400);
const Color kcSkyBlue = Color(0xFF28B4CD);
const Color kcDarkGrey = Color(0xFF1A1B1E);
const Color kcDeepGreen = Color(0xFF078E37);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcAquamarine = Color(0xFF1DE9B6);
const Color kcTransparent = Colors.transparent;
const Color kcPrimaryColor = Color(0xFF9E2891);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcPrimaryColorLight = Color(0x149E2891);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);

// ============================================================================
// NEW FIGMA DESIGN TOKENS (Interactive Redesign Palette)
// ============================================================================

abstract class AppColors {
  // Brand / Magenta
  static const Color magenta14 = Color(0xFF2A1830);
  static const Color magenta22 = Color(0xFF5A1652);
  static const Color magenta23 = Color(0xFF5E1557);
  static const Color magenta26 = Color(0xFF6A1A62);
  static const Color magenta27 = Color(0xFF6E1D65);
  static const Color magenta35 = Color(0xFF8E2483);
  static const Color magenta38 = Color(0xFF9A288D); // Primary brand
  static const Color magenta44 = Color(0xFFA83A9B);
  static const Color magenta56 = Color(0xFFC25AB6);
  static const Color magenta63 = Color(0xFFCF72C4);
  static const Color magenta74 = Color(0xFFF08BD8);
  static const Color magenta79 = Color(0xFFD9B9D4);
  static const Color magenta83 = Color(0xFFE3C6DF);

  // Violet
  static const Color violet26 = Color(0xFF4E1275);
  static const Color violet35 = Color(0xFF6A1B9A);
  static const Color violet43 = Color(0xFF7E2BB0);
  static const Color violet47 = Color(0xFF8E3BB5);
  static const Color violet58 = Color(0xFFA55BCB);

  // Gamified & Learning Green (Duolingo style)
  static const Color chartreuse15 = Color(0xFF1B4D00);
  static const Color chartreuse33 = Color(0xFF58A700);
  static const Color chartreuse40 = Color(0xFF58CC02); // Interactive success / practice green

  // Spring Green
  static const Color springGreen21 = Color(0xFF1F4D3D);
  static const Color springGreen24 = Color(0xFF1F5C46);
  static const Color springGreen27 = Color(0xFF2F5A4C);
  static const Color springGreen30 = Color(0xFF1F7A52);
  static const Color springGreen40 = Color(0xFF2E9E6A);
  static const Color springGreen46 = Color(0xFF3BAF7A);
  static const Color springGreen53 = Color(0xFF4CC38A);
  static const Color springGreen58 = Color(0xFF5CCB94);
  static const Color springGreen64 = Color(0xFF8FB8A8);
  static const Color springGreen66 = Color(0xFF7AD9A8);
  static const Color springGreen67 = Color(0xFF7FD8B6);
  static const Color springGreen78 = Color(0xFFA8E8C6);
  static const Color springGreen80 = Color(0xFFB7E3D1);
  static const Color springGreen87 = Color(0xFFC9F2DD);

  // Cyan
  static const Color cyan18 = Color(0xFF0E4F40);
  static const Color cyan33 = Color(0xFF1F8A70);
  static const Color cyan51 = Color(0xFF1DE9B6);

  // Yellow & Streaks
  static const Color yellow47 = Color(0xFFF2B800);
  static const Color yellow62 = Color(0xFFFFD23F);
  static const Color yellow70 = Color(0xFFFFDD66);
  static const Color yellow75 = Color(0xFFFFE680);
  static const Color yellow78 = Color(0xFFFFE78F);
  static const Color yellow88 = Color(0xFFFFF4C2);

  // Orange & Warm Tones
  static const Color orange40 = Color(0xFFC2410C);
  static const Color orange45 = Color(0xFFE5A800);
  static const Color orange52 = Color(0xFFC9773F);
  static const Color orange53 = Color(0xFFF97316);
  static const Color orange61 = Color(0xFFE08E55);
  static const Color orange62 = Color(0xFFFF9A3C);
  static const Color orange70 = Color(0xFFFFD166);
  static const Color orange90 = Color(0xFFFFF1CC);

  // Red & Errors
  static const Color red17 = Color(0xFF4A1A0E);
  static const Color red28 = Color(0xFF7A2E16);
  static const Color red29 = Color(0xFF6B3A2A);
  static const Color red50 = Color(0xFFD7263D); // Primary error
  static const Color red58 = Color(0xFFE46A45);
  static const Color red59 = Color(0xFFE5484D);
  static const Color red70 = Color(0xFFFF8A65);
  static const Color red86 = Color(0xFFFFB8B8);

  // Blue & Azure
  static const Color blue55 = Color(0xFF3D5BD9);
  static const Color blue67 = Color(0xFF8F9BC8);
  static const Color azure73 = Color(0xFF7FD7F5);
  static const Color azure74 = Color(0xFF7AA0FF);
  static const Color azure88 = Color(0xFFC9D5F7);

  // Rose
  static const Color rose42 = Color(0xFF9B3A72);
  static const Color rose59 = Color(0xFFC866A0);

  // Neutrals & Surface Tones
  static const Color neutral14 = Color(0xFF2A1830);
  static const Color neutral21 = Color(0xFF3A2A40);
  static const Color neutral27 = Color(0xFF4A3A50);
  static const Color neutral34 = Color(0xFF5C4A62);
  static const Color neutral40 = Color(0xFF6B5A70);
  static const Color neutral70 = Color(0xFFB8A6BF);
  static const Color neutral76 = Color(0xFFC9B8CC);
  static const Color neutral82 = Color(0xFFD9C4DE);
  static const Color neutral84 = Color(0xFFD8CCE0);
  static const Color neutral87 = Color(0xFFEBD0E8);
  static const Color neutral93 = Color(0xFFECE2F7);

  // Solid
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Ambient Screen Background (Figma soft surface tint)
  static const Color background = Color(0xFFFAF8FC);
}
