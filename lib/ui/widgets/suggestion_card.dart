import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_strings.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: 75,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kcIndigo, kcPrimaryColor]),
        ),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        children: [_buildIcon(), horizontalSpaceSmall, _buildTitleWrapper()],
      );

  Widget _buildIcon() => const Icon(Icons.lightbulb_outline, color: kcWhite);

  Widget _buildTitleWrapper() => Expanded(
        child: _buildTitle(),
      );

  Widget _buildTitle() => const Text(
        ksSuggestion,
        style: TextStyle(color: kcWhite),
      );
}
