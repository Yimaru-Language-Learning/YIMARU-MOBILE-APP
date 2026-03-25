import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class DwarfTile extends StatelessWidget {
  final bool small;
  final Widget child;

  const DwarfTile({super.key, this.small = false, required this.child});

  @override
  Widget build(BuildContext context) => _buildRow();

  Widget _buildRow() => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildRowChildren(),
      );

  List<Widget> _buildRowChildren() => [
        _buildDwarf(),
        horizontalSpaceSmall,
        child,
      ];

  Widget _buildDwarf() => Image.asset(
        'assets/icons/dwarf.png',
        height: small ? 75 : null,
      );
}
