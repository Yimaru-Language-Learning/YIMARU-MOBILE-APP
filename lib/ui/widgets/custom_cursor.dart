import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class CustomCursor extends StatelessWidget {
  const CustomCursor({super.key});

  @override
  Widget build(BuildContext context) => _buildCursor();

  Widget _buildCursor() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _buildPinIndicator(),
      );

  List<Widget> _buildPinIndicator() => [
        Container(
          width: 25,
          height: 1,
          color: kcPrimaryColor,
          margin: const EdgeInsets.only(bottom: 9),
        ),
      ];
}
