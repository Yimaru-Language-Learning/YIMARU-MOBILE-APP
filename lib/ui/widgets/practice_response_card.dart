import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class PracticeResponseCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const PracticeResponseCard(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        children: [
          _buildPlayButton(),
          _buildColumnWrapper()
        ],
      );

  Widget _buildPlayButton() => ElevatedButton(
        onPressed: () {},
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
          shadowColor: WidgetStatePropertyAll(kcPrimaryColor),
          backgroundColor: WidgetStatePropertyAll(kcPrimaryColor),
        ),
        child: _buildPlayIcon(),
      );

  Widget _buildPlayIcon() => const Icon(
        Icons.play_arrow_rounded,
        size: 25,
        color: kcWhite,
      );

  Widget _buildColumnWrapper() => Expanded(child: _buildColumn());

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [_buildTitle(), _buildSubtitle()];

  Widget _buildTitle() => Text(
        title,
        maxLines: 1,
        softWrap: false,
        style: style12RP600,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        maxLines: 1,
        softWrap: false,
        style: style12RP600,
      );
}
