import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/widgets/no_data_indicator.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';
import 'package:yimaru_app/ui/widgets/small_app_bar.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';

class PracticeLoadingScreen extends StatelessWidget {
  final bool isEmpty;
  final bool isLoading;
  final String message;
  final GestureTapCallback? onPop;
  final GestureTapCallback? onRetry;

  const PracticeLoadingScreen(
      {super.key,
      this.onPop,
      this.onRetry,
      required this.message,
      required this.isEmpty,
      required this.isLoading});

  @override
  Widget build(BuildContext context) => _buildScaffoldWrapper();

  Widget _buildScaffoldWrapper() => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(),
      );

  Widget _buildScaffoldContainer() => Container(
        decoration: bgDecoration,
        child: _buildScaffold(),
      );

  Widget _buildScaffold() => SafeArea(child: _buildStack());

  Widget _buildStack() => Stack(
        children: [
          _buildColumn(),
          if (isEmpty) _buildRefreshButtonWrapper(),
          if (isLoading) _buildPageIndicator()
        ],
      );

  Widget _buildColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [verticalSpaceMedium, _buildAppBarWrapper(), _buildBody()];

  Widget _buildAppBarWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBar(),
      );

  Widget _buildAppBar() => SmallAppBar(onPop: onPop, showBackButton: true);

  Widget _buildBody() => Expanded(child: Container());

  Widget _buildPageIndicator() => const PageLoadingIndicator();

  Widget _buildRefreshButtonWrapper() =>
      Align(alignment: Alignment.center, child: _buildRefreshButton());

  Widget _buildRefreshButton() => NoDataIndicator(
        onPop: onPop,
        title: message,
        onRetry: onRetry,
      );
}
