import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_small_radio_button.dart';
import '../../widgets/small_app_bar.dart';
import 'language_viewmodel.dart';

class LanguageView extends StackedView<LanguageViewModel> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  LanguageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LanguageViewModel();

  @override
  Widget builder(
    BuildContext context,
    LanguageViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LanguageViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LanguageViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(LanguageViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(LanguageViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        _buildExpandedBody(viewModel)
      ];

  Widget _buildExpandedBody(LanguageViewModel viewModel) =>
      Expanded(child: _buildColumnWrapper(viewModel));

  Widget _buildColumnWrapper(LanguageViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LanguageViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(LanguageViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildLanguages(viewModel)
      ];

  Widget _buildAppBarWrapper(LanguageViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(LanguageViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        title: 'Language Preference',
      );

  Widget _buildTitle() => Text(
        'Choose your language',
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        'You can switch languages anytime',
        style: style14MG400,
      );

  Widget _buildLanguages(LanguageViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.languages.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildLanguage(
          title: viewModel.languages[index]['language'],
          selected: viewModel
              .isSelectedLanguage(viewModel.languages[index]['language']),
          onTap: () =>
              viewModel.setSelectedLanguage(viewModel.languages[index]),
        ),
      );

  Widget _buildLanguage(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );
}
