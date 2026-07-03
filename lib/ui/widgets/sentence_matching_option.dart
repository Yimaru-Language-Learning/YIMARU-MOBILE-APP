import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class SentenceMatchingOption extends StatelessWidget {
  final String title;
  final bool selected;
  final String leading;

  const SentenceMatchingOption(
      {super.key,
      required this.title,
      required this.leading,
      required this.selected,
      });

  @override
  Widget build(BuildContext context) => _buildContainerWrapper();

  Widget _buildContainerWrapper() => Container(
        height: 75,
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        child: _buildContainer(),
      );



  Widget _buildContainer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: selected ? kcPrimaryColor.withValues(alpha: 0.1) : kcTransparent,
          border: Border.all(
            color: selected
                ? kcPrimaryColor.withValues(alpha: 0.75)
                : kcLightGrey.withValues(alpha: 0.1),
          ),
        ),
        child: _buildButtonRowWrapper(),
      );

  Widget _buildButtonRowWrapper() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtonRowChildren(),
      );

  List<Widget> _buildButtonRowChildren() =>
      [_buildLeadingWrapper(), horizontalSpaceSmall, _buildTextWrapper()];

  Widget _buildTextWrapper() => Expanded(
        child: _buildText(),
      );

  Widget _buildText() => Text(
        title,
        maxLines: 2,
        style: style14DG400,
      );

  Widget _buildLeadingWrapper() => CircleAvatar(
        backgroundColor:selected ? kcPrimaryColor.withValues(alpha: 0.25):kcPrimaryColor.withValues(alpha: 0.1),
        child: _buildLeading(),
      );

  Widget _buildLeading() => Text(
        leading,
        maxLines: 2,
        style:selected ?style14W400: style14DG400,
      );
}
