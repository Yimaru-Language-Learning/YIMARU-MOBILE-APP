import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';


class InstructionCard extends StatelessWidget {
  final String instruction;
  const InstructionCard({super.key,required this.instruction});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: kcVeryLightGrey,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: _buildColumn(),
  );


  Widget _buildColumn()=> Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _buildColumnChildren(),
  );

  List<Widget> _buildColumnChildren()=> [
    _buildTitle(),
    _buildSubtitle()

  ];


  Widget _buildTitle() => Text(
    'Instructions',
    style: style16P600,
  );


  Widget _buildSubtitle() => Text(
    instruction,
    style: style14MG400,
  );
}
