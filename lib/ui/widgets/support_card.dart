import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/widgets/circular_icon.dart';

class SupportCard extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final String subtitle;
  final GestureTapCallback? onTap;

  const SupportCard({
    super.key,
    this.onTap,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) => _buildLitTile();

  Widget _buildLitTile() => ListTile(
        onTap: onTap,
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
        trailing: _buildTrailingIcon(),
        leading: _buildLeadingWrapper(),
        tileColor: color.withOpacity(0.2),
      );

  Widget _buildLeadingWrapper() =>
      CircularIcon(icon: icon, size: 20, color: color);

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
            fontSize: 16, color: kcDarkGrey, fontWeight: FontWeight.w600),
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        maxLines: 2,
        style: const TextStyle(color: kcDarkGrey),
      );

  Widget _buildTrailingIcon() => Icon(
        Icons.keyboard_arrow_right,
        color: color,
      );
}
