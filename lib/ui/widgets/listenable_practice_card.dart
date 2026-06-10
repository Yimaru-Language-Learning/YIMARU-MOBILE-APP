import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../common/app_colors.dart';

class ListenablePracticeCard extends StatelessWidget {
  const ListenablePracticeCard({super.key});

  @override
  Widget build(BuildContext context) => _buildRow();

  Widget _buildContainer() => SizedBox(
        height: 75,
        width: double.maxFinite,
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildRowChildren(),
      );

  List<Widget> _buildRowChildren() =>
      [_buildPlayButton(), horizontalSpaceSmall, _buildColumnWrapper()];

  Widget _buildPlayButton() => ElevatedButton(
        onPressed: () {},
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
          shadowColor: WidgetStatePropertyAll(kcPrimaryColor),
          backgroundColor: WidgetStatePropertyAll(kcPrimaryColor),
        ),
        child: _buildPlayIcon(),
      );

  Widget _buildPlayIcon() => const Icon(
        Icons.play_arrow_rounded,
        size: 35,
        color: kcWhite,
      );

  Widget _buildColumnWrapper() => Expanded(child: _buildColumn());

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        _buildProgressIndicator(),
        verticalSpaceTiny,
        _buildTitle(),
        verticalSpaceSmall,
        _buildColumnRow()
      ];

  Widget _buildProgressIndicator() => const CustomLinearProgressIndicator(
      progress: 0.75,
      activeColor: kcPrimaryColor,
      backgroundColor: kcVeryLightGrey);

  Widget _buildTitle() => Text(
        '0:01 / 0:07',
        style: style14MG400,
      );

  Widget _buildColumnRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnRowChildren(),
      );

  List<Widget> _buildColumnRowChildren() =>
      [_buildReplyButtonWrapper(), horizontalSpaceTiny, _buildSubtitle()];

  Widget _buildReplyButtonWrapper() => SizedBox(
        width: 85,
        height: 25,
        child: _buildReplyButton(),
      );

  Widget _buildReplyButton() => const CustomElevatedButton(
        height: 25,
        text: 'Reply',
        borderRadius: 15,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildSubtitle() => Text(
        '2 reply left',
        style: style14P400,
      );
}
