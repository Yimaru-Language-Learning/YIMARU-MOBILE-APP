import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_small_trailing_radio_button.dart';
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
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      SafeArea(
          child: _buildBodyWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyWrapper(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyChildren(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        _buildExpandedBody(context: context, viewModel: viewModel)
      ];

  Widget _buildExpandedBody(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      Expanded(
          child: _buildColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildColumnWrapper(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildColumnChildren(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildLanguages(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarWrapper(LanguageViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(LanguageViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
        title: LocaleKeys.language_preference.tr(),
      );

  Widget _buildTitle() => Text(
        LocaleKeys.choose_your_language.tr(),
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.switch_language_anytime.tr(),
        style: style14MG400,
      );

  Widget _buildLanguages(
          {required BuildContext context,
          required LanguageViewModel viewModel}) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.languages.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildLanguage(
          title: viewModel.languages[index]['language'],
          onTap: () => viewModel.setSelectedLanguage(
              context: context, title: viewModel.languages[index]),
          selected: viewModel
              .isSelectedLanguage(viewModel.languages[index]['language']),
        ),
      );

  Widget _buildLanguage(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallTrailingRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );
}
