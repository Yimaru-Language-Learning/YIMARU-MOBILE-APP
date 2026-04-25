import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class ProgressStatus extends StatelessWidget {
  final Color color;
  final String status;

  const ProgressStatus({super.key, required this.color, required this.status});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        child: _buildLabel(),
      );

  Widget _buildLabel() => Text(
        status,
        style: style12RP600.copyWith(color: color),
      );
}
