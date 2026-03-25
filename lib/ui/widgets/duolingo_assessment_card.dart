import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class DuolingoAssessmentCard extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;

  const DuolingoAssessmentCard({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withValues(alpha: 0.25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: _buildColumn(),
      );

  Widget _buildColumn() =>
      Column(mainAxisSize: MainAxisSize.min, children: _buildColumnChildren());

  List<Widget> _buildColumnChildren() => [
        verticalSpaceTiny,
        _buildTitle(),
        verticalSpaceSmall,
        _buildStartButtonWrapper()
      ];

  Widget _buildTitle() => Text(
        title,
        style: style18DG700,
      );

  Widget _buildStartButtonWrapper() => SizedBox(
        height: 40,
        child: _buildStartButton(),
      );

  Widget _buildStartButton() => CustomElevatedButton(
        height: 50,
        width: 200,
        onTap: onTap,
        borderRadius: 8,
        text: 'Take Assessment',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
