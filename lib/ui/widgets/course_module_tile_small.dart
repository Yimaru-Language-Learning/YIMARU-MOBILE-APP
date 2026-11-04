import 'package:flutter/material.dart';
import 'package:yimaru_app/models/course_module.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class CourseModuleTileSmall extends StatelessWidget {
  final CourseModule? module;
  final GestureTapCallback? onTap;

  const CourseModuleTileSmall({super.key, this.onTap, required this.module});

  // Cycle through a palette so each module gets a distinct color
  static const List<Color> _iconColors = [
    Color(0xFF58CC02), // green
    Color(0xFFFF9600), // orange
    Color(0xFF1CB0F6), // sky blue
    Color(0xFFFF4B4B), // red
    AppColors.magenta38, // magenta
    Color(0xFF9C27B0), // purple
  ];

  Color _iconColor(int? id) =>
      _iconColors[(id ?? 0) % _iconColors.length];

  @override
  Widget build(BuildContext context) => _buildTile();

  Widget _buildTile() => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xFFE8E8F0),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildIconCircle(),
              const SizedBox(width: 12),
              Expanded(child: _buildTitle()),
              _buildTrailing(),
            ],
          ),
        ),
      );

  Widget _buildIconCircle() => Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5FD),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.bookmark_rounded,
          color: Color(0xFF1CB0F6),
          size: 18,
        ),
      );

  Widget _buildTitle() => Text(
        module?.name ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          fontFamily: 'Aeonik',
          color: Color(0xFF1A1A2E),
        ),
      );

  Widget _buildTrailing() => Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFDDDDEE), width: 1.5),
        ),
      );
}
