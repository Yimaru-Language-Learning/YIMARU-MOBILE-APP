import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class CustomColumnButton extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final GestureTapCallback? onTap;

  const CustomColumnButton(
      {super.key,
      this.onTap,
      required this.icon,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) => _buildColumnWrapper();

  Widget _buildColumnWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
    _buildIconWrapper(),
    _buildLabel()
  ];

  Widget _buildIconWrapper() => Container(
    padding:const EdgeInsets.all(5),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color.withOpacity(0.1),
      border: Border.all(color: color.withOpacity(0.75))
    ),
    child: _buildIcon(),
  );

  Widget _buildLabel()=> Text(label,style: style14LG400.copyWith(color: color),);

  Widget _buildIcon()=> Icon(icon,size: 14,color: color,);
}
