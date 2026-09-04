import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';

class DeveloperMode extends StatelessWidget {
  const DeveloperMode({super.key});

  @override
  Widget build(BuildContext context) => _buildScaffoldWrapper();

  Widget _buildScaffoldWrapper() => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(),
      );

  Widget _buildScaffoldContainer() => Container(
        decoration: bgDecoration,
        child: _buildDeveloperModeCenterWrapper(),
      );

  Widget _buildDeveloperModeCenterWrapper() =>
      Center(child: _buildDeveloperModePaddingWrapper());

  Widget _buildDeveloperModePaddingWrapper() => Padding(
        padding: const EdgeInsets.all(32),
        child: _buildDeveloperModeColumnWrapper(),
      );

  Widget _buildDeveloperModeColumnWrapper() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDeveloperModeColumnChildren(),
      );

  List<Widget> _buildDeveloperModeColumnChildren() => [
        _buildBlockIcon(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildSubtitle(),
      ];

  Widget _buildBlockIcon() =>
      const Icon(Icons.block, size: 72, color: Colors.red);

  Widget _buildTitle() => Text(
        'Access Restricted',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Developer Mode was detected on this device. '
        'Disable it in Settings, then return to the app.',
        textAlign: TextAlign.center,
        style: style16DG400,
      );
}
