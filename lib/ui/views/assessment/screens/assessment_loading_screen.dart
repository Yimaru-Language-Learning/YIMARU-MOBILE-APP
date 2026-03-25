import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import '../../../common/app_colors.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/refresh_button.dart';

class AssessmentLoadingScreen extends StatelessWidget {
  final bool isEmpty;
  final bool isLoading;
  final GestureTapCallback? onTap;
  const AssessmentLoadingScreen(
      {super.key, this.onTap, required this.isEmpty, required this.isLoading});

  @override
  Widget build(BuildContext context) => _buildScaffoldWrapper();

  Widget _buildScaffoldWrapper() => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(),
      );

  Widget _buildScaffold() => Stack(
        children: [
          _buildColumn(),
          if (isEmpty) _buildRefreshButton(),
          if (isLoading) _buildPageIndicator()
        ],
      );

  Widget _buildColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [_buildAppBar(), _buildBody()];

  Widget _buildAppBar() => const LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
      );

  Widget _buildBody() => Expanded(child: Container());

  Widget _buildPageIndicator() => const PageLoadingIndicator();

  Widget _buildRefreshButton() => RefreshButton(onTap: onTap);
}
