import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? language;
  final bool? isLanguage;
  final GestureTapCallback? onTap;

  const CustomListTile({
    super.key,
    this.onTap,
    this.language,
    this.isLanguage,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) => _buildLitTile();

  Widget _buildLitTile() => ListTile(
        onTap: onTap,
        title: _buildTitle(),
        leading: _buildLeading(),
        trailing: _buildTrailing(),
      );

  Widget _buildLeading() => Icon(
        icon,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          color: kcDarkGrey,
        ),
      );

  Widget _buildTrailing() =>
      isLanguage != null ? _buildTrailingRow() : _buildTrailingIcon();

  Widget _buildTrailingRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildTrailingChildren(),
      );

  List<Widget> _buildTrailingChildren() => [
        if (language != null) _buildTrailingText(),
        if (language != null) horizontalSpaceSmall,
        _buildTrailingIcon()
      ];

  Widget _buildTrailingText() => Text(
        language ?? '',
        style: const TextStyle(
          fontSize: 12,
          color: kcDarkGrey,
        ),
      );

  Widget _buildTrailingIcon() => const Icon(
        Icons.keyboard_arrow_right,
        color: kcLightGrey,
      );
}
