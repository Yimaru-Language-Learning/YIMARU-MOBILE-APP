import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) => _buildScaffoldWrapper();

  Widget _buildScaffoldWrapper() => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(),
      );

  Widget _buildScaffold() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyWrapper(),
      );

  Widget _buildBodyWrapper() => Center(
        child: _buildBody(),
      );

  Widget _buildBody() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildBodyChildren(),
      );

  List<Widget> _buildBodyChildren() => [
        verticalSpaceLarge,
        _buildIcon(),
        verticalSpaceSmall,
        _buildTitle(),
      ];

  Widget _buildIcon() => Image.asset('assets/images/coming_soon.png');

  Widget _buildTitle() => const Text(
        'Launching Very Soon!',
        style: TextStyle(
          fontSize: 22,
          color: kcMediumGrey,
          fontWeight: FontWeight.w700,
        ),
      );
}
