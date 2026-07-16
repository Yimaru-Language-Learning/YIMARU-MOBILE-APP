import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class ReadingPracticeOptionCard
    extends ViewModelWidget<CoursePracticeViewModel> {
  final bool enabled;
  final List options;
  final String number;

  const ReadingPracticeOptionCard(
      {super.key,
      required this.enabled,
      required this.options,
      required this.number});

  void _setOption(
      {required Map<String, dynamic> answer,
      required CoursePracticeViewModel viewModel}) {
    viewModel.setSelectedChoice(number: number, answer: answer);
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildButtonWrapper(viewModel);

  Widget _buildButtonWrapper(CoursePracticeViewModel viewModel) => Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kcVeryLightGrey),
          color: kcVeryLightGrey.withValues(alpha: 0.25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: _buildRow(viewModel),
      );

  Widget _buildRow(CoursePracticeViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildRowChildren(viewModel),
      );

  List<Widget> _buildRowChildren(CoursePracticeViewModel viewModel) => [
        _buildNumberWrapper(),
        horizontalSpaceSmall,
        _buildOptionsWrapper(viewModel)
      ];

  Widget _buildNumberWrapper() => Container(
        width: 25,
        height: 25,
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: kcVeryLightGrey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: _buildNumber(),
      );

  Widget _buildNumber() => Text(
        number,
        style: style14DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildOptionsWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildOptionsList(viewModel));

  Widget _buildOptionsList(CoursePracticeViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) => _buildOptionDetector(
          title: options[index]['text'],
          onTap: enabled
              ? () => _setOption(viewModel: viewModel, answer: options[index])
              : null,
          selected: viewModel.isSelectedChoice(
              number: number, answer: options[index]),
        ),
      );

  Widget _buildOptionDetector(
          {required String title,
          required bool selected,
          GestureTapCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: _buildOption(title: title, selected: selected, onTap: onTap),
      );

  Widget _buildOption(
          {required String title,
          required bool selected,
          GestureTapCallback? onTap}) =>
      Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: selected ? kcMediumGrey.withValues(alpha: 0.1) : kcTransparent,
          border: Border(
            bottom: BorderSide(
              color: selected
                  ? kcMediumGrey.withValues(alpha: 0.1)
                  : kcVeryLightGrey,
            ),
          ),
        ),
        child: _buildButtonRowWrapper(title: title, selected: selected),
      );

  Widget _buildButtonRowWrapper(
          {required String title, required bool selected}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtonRowChildren(title: title, selected: selected),
      );

  List<Widget> _buildButtonRowChildren({
    required String title,
    required bool selected,
  }) =>
      [_buildTextWrapper(title), if (selected) _buildIcon()];

  Widget _buildTextWrapper(String title) => Expanded(
        child: _buildText(title),
      );

  Widget _buildText(String title) => Text(
        title,
        maxLines: 2,
        style: style14DG400,
      );

  Widget _buildIcon() => const Icon(
        Icons.check,
        size: 20,
        color: kcMediumGrey,
      );
}
