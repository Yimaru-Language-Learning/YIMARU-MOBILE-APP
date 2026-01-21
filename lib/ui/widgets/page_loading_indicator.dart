import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import 'custom_circular_progress_indicator.dart';

class PageLoadingIndicator extends StatelessWidget {
  const PageLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => _buildBody(context);

  Widget _buildBody(BuildContext context) => Material(
        color: kcTransparent,
        child: _buildContainer(context),
      );

  Widget _buildContainer(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: kcBlack.withOpacity(0.3),
        child: _buildBoxContainerWrapper(),
      );

  Widget _buildBoxContainerWrapper() => Center(
        child: _buildBoxContainer(),
      );

  Widget _buildBoxContainer() => Container(
        width: 150,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kcBackgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: _buildColumnWrapper(),
      );

  Widget _buildColumnWrapper() => Center(
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [_buildShimmer(), verticalSpaceSmall, _buildText()];

  Widget _buildShimmer() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildText() => const Text(
        'Please wait',
        style: TextStyle(color: kcPrimaryColor),
      );
}
