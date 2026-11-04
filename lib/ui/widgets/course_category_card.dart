import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../common/app_colors.dart';

class CourseCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Map<String, dynamic> course;

  const CourseCard({super.key, this.onTap, required this.course});

  Color get _accentColor => AppColors.magenta38;
  Color get _bgColor => const Color(0xFFF3E8F1);
  String get _illustrationPath =>
      'assets/images/illustrations/course_exam_certificate.svg';

  @override
  Widget build(BuildContext context) => _buildCard();

  Widget _buildCard() => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.07),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildCardContent(),
        ),
      );

  Widget _buildCardContent() => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAccentStripe(),
            _buildTextSection(),
            _buildIllustration(),
          ],
        ),
      );

  Widget _buildAccentStripe() => Container(
        width: 6,
        color: _accentColor,
      );

  Widget _buildTextSection() => Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 8, 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course['title'] ?? '',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Aeonik',
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                course['description'] ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Aeonik',
                  color: Color(0xFF666677),
                ),
              ),
              const SizedBox(height: 14),
              _buildStartButton(),
            ],
          ),
        ),
      );

  Widget _buildStartButton() => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.chartreuse40,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            LocaleKeys.start_course.tr(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'Aeonik',
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget _buildIllustration() => Container(
        width: 100,
        color: _bgColor,
        padding: const EdgeInsets.all(8),
        child: Center(
          child: SvgPicture.asset(
            _illustrationPath,
            width: 80,
            fit: BoxFit.contain,
          ),
        ),
      );
}
