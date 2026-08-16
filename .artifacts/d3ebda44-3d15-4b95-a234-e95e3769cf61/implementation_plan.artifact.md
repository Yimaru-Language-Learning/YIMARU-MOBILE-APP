# Localization of Hardcoded Strings

This plan aims to localize all remaining hardcoded strings in the project using the existing `easy_localization` setup.

## User Review Required

> [!IMPORTANT]
> Some strings in `en.json` were added by the user but not yet reflected in `lib/ui/common/translations/locale_keys.g.dart`. I will update the generated file to ensure the code compiles, but it is recommended to run the `easy_localization` generation command after this process.

## Proposed Changes

### Translations
Update the JSON translation files for English and Amharic.

#### [MODIFY] [en.json](file:///C:/Users/Baby/StudioProjects/yimaru_app/assets/translations/en.json)
Add missing keys found in the UI.

#### [MODIFY] [am.json](file:///C:/Users/Baby/StudioProjects/yimaru_app/assets/translations/am.json)
Add Amharic translations for the new keys.

### Locale Keys
Update the generated locale keys file to include the new keys.

#### [MODIFY] [locale_keys.g.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/common/translations/locale_keys.g.dart)
Add static constants for all missing keys.

### UI Components
Replace hardcoded strings with localized versions using `LocaleKeys.key.tr()`.

#### [MODIFY] [info_alert_dialog.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/dialogs/info_alert/info_alert_dialog.dart)
Localize "Got it".

#### [MODIFY] [course_pricing_card.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/widgets/course_pricing_card.dart)
Localize pricing card strings.

#### [MODIFY] [course_category_card.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/widgets/course_category_card.dart)
Localize "Start Course".

#### [MODIFY] [course_module_tile_large.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/widgets/course_module_tile_large.dart)
Localize "0% completed" and "Continue Module".

#### [MODIFY] [course_lesson_tile.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/widgets/course_lesson_tile.dart)
Localize "Play Video" and "Practice Test".

#### [MODIFY] [app_rating_view.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/views/app_rating/app_rating_view.dart)
Localize all hardcoded strings in the rating view.

#### [MODIFY] [course_view.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/views/course/course_view.dart)
Localize "Courses" and its subtitle.

#### [MODIFY] [course_catalog_view.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/views/course_catalog/course_catalog_view.dart)
Localize titles and subtitles.

#### [MODIFY] [course_lesson_detail_view.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/views/course_lesson_detail/course_lesson_detail_view.dart)
Localize "Start Assessment".

#### [MODIFY] [course_unit_view.dart](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/views/course_unit/course_unit_view.dart)
Localize "Continue Course".

#### [MODIFY] [landing_screens](file:///C:/Users/Baby/StudioProjects/yimaru_app/lib/ui/views/landing/screens/)
Localize "Get Started" in landing screens.

## Verification Plan

### Manual Verification
- Verify that strings are correctly displayed in both English and Amharic by switching the app language.
- Check UI layout for any overflow issues caused by longer translated strings.
