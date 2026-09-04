import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../common/ui_helpers.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/circular_icon.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_form_label.dart';
import '../../widgets/page_loading_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'app_rating_viewmodel.dart';
import 'app_rating_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'review', validator: FormValidator.validateForm),
])
class AppRatingView extends StackedView<AppRatingViewModel>
    with $AppRatingView {
  const AppRatingView({Key? key}) : super(key: key);

  Future<void> _rate(AppRatingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();
    int target = 0;
    if (viewModel.selectedTarget == null) {
      showErrorToast('Select review target.');
      return;
    }

    if (viewModel.selectedRating == null) {
      showErrorToast('Select rating.');

      return;
    }

    if (viewModel.selectedTarget == 'course') {
      target = 1;
    } else if (viewModel.selectedTarget == 'sub-course') {
      target = 2;
    }

    Map<String, dynamic> data = {
      'target_id': target,
      'review': reviewController.text,
      'target_type': viewModel.selectedTarget,
      'stars': int.parse(viewModel.selectedRating ?? '0'),
    };

    await viewModel.rateApp(data);
  }

  @override
  void onViewModelReady(AppRatingViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  AppRatingViewModel viewModelBuilder(BuildContext context) =>
      AppRatingViewModel();

  @override
  Widget builder(
    BuildContext context,
    AppRatingViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(AppRatingViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(AppRatingViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(AppRatingViewModel viewModel) => Stack(
        children: [_buildScaffold(viewModel), _buildBodyState(viewModel)],
      );

  Widget _buildScaffold(AppRatingViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(AppRatingViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(AppRatingViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        _buildExpandedColumn(viewModel)
      ];

  Widget _buildAppBarWrapper(AppRatingViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(AppRatingViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        title: LocaleKeys.app_rating.tr(),
      );

  Widget _buildExpandedColumn(AppRatingViewModel viewModel) =>
      Expanded(child: _buildColumnScrollerWrapper(viewModel));

  Widget _buildColumnScrollerWrapper(AppRatingViewModel viewModel) =>
      SingleChildScrollView(child: _buildColumnWrapper(viewModel));

  Widget _buildColumnWrapper(AppRatingViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(AppRatingViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(AppRatingViewModel viewModel) => [
        verticalSpaceLarge,
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildTargetFormFieldWrapper(viewModel),
        verticalSpaceMedium,
        _buildRatingFormFieldWrapper(viewModel),
        verticalSpaceMedium,
        _buildReviewFormField(viewModel),
        if (viewModel.hasReviewValidationMessage && viewModel.focusReview)
          verticalSpaceTiny,
        if (viewModel.hasReviewValidationMessage && viewModel.focusReview)
          _buildReviewValidatorWrapper(viewModel),
        verticalSpaceLarge,
        _buildContinueButton(viewModel)
      ];

  Widget _buildIcon() =>
      const CircularIcon(icon: Icons.rate_review, size: 50, color: kcIndigo);

  Widget _buildTitle() => Text(
        LocaleKeys.write_rating.tr(),
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.give_rating.tr(),
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildTargetFormFieldWrapper(AppRatingViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildTargetFormFieldChildren(viewModel),
      );

  List<Widget> _buildTargetFormFieldChildren(AppRatingViewModel viewModel) => [
        _buildReviewLabel(),
        verticalSpaceTiny,
        _buildTargetRadioButtonWrapper(viewModel),
      ];

  Widget _buildReviewLabel() => CustomFormLabel(
        style: style16DG600,
        label: LocaleKeys.review_target.tr(),
      );

  Widget _buildTargetRadioButtonWrapper(AppRatingViewModel viewModel) => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildTargetRadioButtonChildren(viewModel),
      );

  List<Widget> _buildTargetRadioButtonChildren(AppRatingViewModel viewModel) =>
      [
        _buildAppRadioButton(viewModel),
        _buildCourseRadioButton(viewModel),
        _buildSubCourseRadioButton(viewModel),
      ];

  Widget _buildAppRadioButton(AppRatingViewModel viewModel) =>
      RadioGroup<String?>(
          groupValue: viewModel.selectedTarget,
          onChanged: (value) => viewModel.setSelectedTarget(value ?? ''),
          child: _buildAppRadioTileWrapper(viewModel));

  Widget _buildAppRadioTileWrapper(AppRatingViewModel viewModel) => Container(
      width: 125,
      alignment: Alignment.centerLeft,
      child: _buildAppRadioTile(viewModel));

  Widget _buildAppRadioTile(AppRatingViewModel viewModel) =>
      RadioListTile<String?>(
        value: 'app',
        title: _buildAppTitle(),
        activeColor: kcPrimaryColor,
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildAppTitle() => Text(
        LocaleKeys.app.tr(),
        style: style14DG500,
      );

  Widget _buildCourseRadioButton(AppRatingViewModel viewModel) =>
      RadioGroup<String?>(
          groupValue: viewModel.selectedTarget,
          onChanged: (value) => viewModel.setSelectedTarget(value ?? ''),
          child: _buildCourseRadioTileWrapper(viewModel));

  Widget _buildCourseRadioTileWrapper(AppRatingViewModel viewModel) =>
      Container(
        width: 125,
        alignment: Alignment.centerLeft,
        child: _buildCourseRadioTile(viewModel),
      );

  Widget _buildCourseRadioTile(AppRatingViewModel viewModel) =>
      RadioListTile<String?>(
        value: 'course',
        title: _buildCourseTitle(),
        activeColor: kcPrimaryColor,
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildCourseTitle() => Text(
        LocaleKeys.course.tr(),
        style: style14DG500,
      );

  Widget _buildSubCourseRadioButton(AppRatingViewModel viewModel) =>
      RadioGroup<String?>(
          groupValue: viewModel.selectedTarget,
          onChanged: (value) => viewModel.setSelectedTarget(value ?? ''),
          child: _buildSubCourseRadioTileWrapper(viewModel));

  Widget _buildSubCourseRadioTileWrapper(AppRatingViewModel viewModel) =>
      Container(
        width: 125,
        alignment: Alignment.centerLeft,
        child: _buildSubCourseRadioTile(viewModel),
      );

  Widget _buildSubCourseRadioTile(AppRatingViewModel viewModel) =>
      RadioListTile<String?>(
        value: 'sub_course',
        activeColor: kcPrimaryColor,
        title: _buildSubCourseTitle(),
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildSubCourseTitle() => Text(
        LocaleKeys.sub_course.tr(),
        style: style14DG500,
      );

  Widget _buildRatingFormFieldWrapper(AppRatingViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildRatingFormFieldChildren(viewModel),
      );

  List<Widget> _buildRatingFormFieldChildren(AppRatingViewModel viewModel) => [
        _buildRatingLabel(),
        verticalSpaceTiny,
        _buildRatingDropdown(viewModel),
      ];

  Widget _buildRatingLabel() => CustomFormLabel(
        style: style16DG600,
        label: LocaleKeys.how_do_you_rate.tr(),
      );

  Widget _buildRatingDropdown(AppRatingViewModel viewModel) =>
      DropdownButton<String>(
        isDense: false,
        isExpanded: true,
        hint: _buildHint(),
        style: style14DG400,
        underline: Container(),
        value: viewModel.selectedRating,
        onChanged: (value) => viewModel.setSelectedRating(value),
        items: viewModel.ratings
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: style14DG400,
                ),
              ),
            )
            .toList(),
      );

  Widget _buildHint() => Text(
        LocaleKeys.rate_us.tr(),
        style: style14DG400,
      );

  Widget _buildReviewFormField(AppRatingViewModel viewModel) => TextFormField(
        maxLines: 5,
        maxLength: 250,
        controller: reviewController,
        onTap: viewModel.setReviewFocus,
        decoration: inputDecoration(
            focus: viewModel.focusReview,
            hint: LocaleKeys.describe_comment.tr(),
            filled: reviewController.text.isNotEmpty),
      );

  Widget _buildReviewValidatorWrapper(AppRatingViewModel viewModel) =>
      viewModel.hasReviewValidationMessage
          ? _buildReviewValidator(viewModel)
          : Container();

  Widget _buildReviewValidator(AppRatingViewModel viewModel) => Text(
        viewModel.reviewValidationMessage!,
        style: style12R700,
        textAlign: TextAlign.start,
      );

  Widget _buildContinueButton(AppRatingViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: LocaleKeys.report.tr(),
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: reviewController.text.isNotEmpty
            ? () async => await _rate(viewModel)
            : null,
        backgroundColor: reviewController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withValues(alpha: 0.1),
      );

  Widget _buildBodyState(AppRatingViewModel viewModel) =>
      viewModel.busy(StateObjects.appRating)
          ? const PageLoadingIndicator()
          : Container();
}
