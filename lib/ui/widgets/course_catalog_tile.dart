import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/course_catalog.dart';

class CourseCatalogTile extends StatelessWidget {
  final CourseCatalog catalog;
  final GestureTapCallback? onCourseTap;
  final GestureTapCallback? onPracticeTap;

  const CourseCatalogTile({
    super.key,
    this.onCourseTap,
    this.onPracticeTap,
    required this.catalog,
  });

  bool get _isProfessionals {
    final cat = (catalog.category ?? '').toLowerCase();
    final nm = (catalog.name ?? '').toLowerCase();
    return cat.contains('prof') || nm.contains('prof');
  }

  bool get _isDuolingo {
    if (_isProfessionals) return false;
    final cat = (catalog.category ?? '').toUpperCase();
    final nm = (catalog.name ?? '').toLowerCase();
    return cat.contains('DUOLINGO') || nm.contains('duolingo');
  }

  bool get _isIelts {
    if (_isProfessionals) return false;
    final cat = (catalog.category ?? '').toUpperCase();
    final nm = (catalog.name ?? '').toLowerCase();
    return cat.contains('IELTS') || nm.contains('ielts');
  }

  Color get _cardBg {
    if (_isDuolingo) return const Color(0xFF58CC02);
    if (_isIelts) return const Color(0xFFE4002B);
    return const Color(0xFFF4E3F2);
  }

  Color get _bottomBevelColor {
    if (_isDuolingo) return const Color(0xFF46A302);
    if (_isIelts) return const Color(0xFFA8001F);
    return const Color(0xFFE3C6DF);
  }

  Color get _textColor {
    if (_isDuolingo || _isIelts) return Colors.white;
    return const Color(0xFF2A1830);
  }

  Color get _chevronColor {
    if (_isDuolingo || _isIelts) return Colors.white;
    return const Color(0xFF2A1830);
  }

  String get _illustrationPath {
    if (_isDuolingo) {
      return 'assets/images/06-course-tab-and-exam-prep/6.2-proficiency-exams-01.svg';
    }
    if (_isIelts) {
      return 'assets/images/06-course-tab-and-exam-prep/6.2-proficiency-exams-02.svg';
    }
    return 'assets/images/06-course-tab-and-exam-prep/6.2-proficiency-exams-03.svg';
  }

  String get _displayName {
    final raw = (catalog.name ?? '').trim();
    if (raw.toLowerCase() == 'duolingo english test') {
      return 'Duolingo English\nTest';
    }
    if (raw.toLowerCase() == 'english for professionals') {
      return 'English For\nProfessionals';
    }
    return raw;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: (catalog.access?.isAccessible ?? false) || _isProfessionals
            ? onCourseTap
            : onPracticeTap,
        child: _buildCard(),
      );

  Widget _buildCard() => Container(
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: _bottomBevelColor,
              offset: const Offset(0, 3),
              blurRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            _buildIllustrationBox(),
            const SizedBox(width: 16),
            Expanded(child: _buildTitle()),
            _buildChevron(),
          ],
        ),
      );

  Widget _buildIllustrationBox() => Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(
          _illustrationPath,
          fit: BoxFit.contain,
        ),
      );

  Widget _buildTitle() => Text(
        _displayName,
        style: TextStyle(
          fontSize: _isIelts ? 20 : 17,
          fontWeight: FontWeight.w800,
          fontFamily: 'Aeonik',
          color: _textColor,
          height: 1.15,
        ),
      );

  Widget _buildChevron() => Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Icon(
          Icons.chevron_right_rounded,
          color: _chevronColor,
          size: 28,
        ),
      );
}
