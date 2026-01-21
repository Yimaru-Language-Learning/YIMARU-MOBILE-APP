import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';

class MotivationCard extends StatelessWidget {
  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withOpacity(0.1),
        ),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        children: [_buildIconWrapper(), horizontalSpaceSmall, _buildText()],
      );

  Widget _buildIconWrapper() => CircleAvatar(
        backgroundColor: kcPrimaryColor.withOpacity(0.25),
        child: _buildIcon(),
      );

  Widget _buildIcon() => Image.asset('assets/images/deer.png');

  Widget _buildText() => Expanded(
        child: Text(
          'Let’s keep going — you’re more than halfway there!',
          maxLines: 2,
          style: style14DG400,
        ),
      );
}
