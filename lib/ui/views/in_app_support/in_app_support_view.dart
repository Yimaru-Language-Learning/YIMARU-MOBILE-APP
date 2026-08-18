import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/circular_icon.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/page_loading_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'in_app_support_viewmodel.dart';
import 'in_app_support_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'type', validator: FormValidator.validateForm),
  FormTextField(name: 'subject', validator: FormValidator.validateForm),
  FormTextField(name: 'description', validator: FormValidator.validateForm),
])
class InAppSupportView extends StackedView<InAppSupportViewModel>
    with $InAppSupportView {
  const InAppSupportView({Key? key}) : super(key: key);

  Future<void> _report(InAppSupportViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'issue_type': typeController.text,
      'subject': subjectController.text,
      'description': descriptionController.text,
    };

    await viewModel.reportIssue(data);
  }

  @override
  void onViewModelReady(InAppSupportViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  InAppSupportViewModel viewModelBuilder(BuildContext context) =>
      InAppSupportViewModel();

  @override
  Widget builder(
    BuildContext context,
    InAppSupportViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(InAppSupportViewModel viewModel) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(InAppSupportViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(InAppSupportViewModel viewModel) => Stack(
        children: [_buildScaffold(viewModel), _buildBodyState(viewModel)],
      );

  Widget _buildScaffold(InAppSupportViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(InAppSupportViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(InAppSupportViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        _buildExpandedColumn(viewModel)
      ];

  Widget _buildAppBarWrapper(InAppSupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(InAppSupportViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        title: LocaleKeys.in_app_support.tr(),
      );

  Widget _buildExpandedColumn(InAppSupportViewModel viewModel) =>
      Expanded(child: _buildColumnWrapper(viewModel));

  Widget _buildColumnWrapper(InAppSupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(InAppSupportViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(InAppSupportViewModel viewModel) => [
        verticalSpaceLarge,
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildSubjectFormField(viewModel),
        if (viewModel.hasSubjectValidationMessage && viewModel.focusSubject)
          verticalSpaceTiny,
        if (viewModel.hasSubjectValidationMessage && viewModel.focusSubject)
          _buildSubjectValidatorWrapper(viewModel),
        verticalSpaceMedium,
        _buildTypeFormField(viewModel),
        if (viewModel.hasTypeValidationMessage && viewModel.focusType)
          verticalSpaceTiny,
        if (viewModel.hasTypeValidationMessage && viewModel.focusType)
          _buildTypeValidatorWrapper(viewModel),
        verticalSpaceMedium,
        _buildDescriptionFormField(viewModel),
        if (viewModel.hasDescriptionValidationMessage &&
            viewModel.focusDescription)
          verticalSpaceTiny,
        if (viewModel.hasDescriptionValidationMessage &&
            viewModel.focusDescription)
          _buildDescriptionValidatorWrapper(viewModel),
        verticalSpaceLarge,
        _buildContinueButton(viewModel)
      ];

  Widget _buildIcon() => const CircularIcon(
      icon: Icons.menu_book_rounded, size: 50, color: kcOrange);

  Widget _buildTitle() => Text(
        LocaleKeys.write_issue_briefly_title.tr(),
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.connect_support_assistance.tr(),
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildSubjectFormField(InAppSupportViewModel viewModel) =>
      TextFormField(
        controller: subjectController,
        onTap: viewModel.setSubjectFocus,
        decoration: inputDecoration(
            hint: LocaleKeys.issue_subject_label.tr(),
            focus: viewModel.focusSubject,
            filled: subjectController.text.isNotEmpty),
      );

  Widget _buildSubjectValidatorWrapper(InAppSupportViewModel viewModel) =>
      viewModel.hasSubjectValidationMessage
          ? _buildSubjectValidator(viewModel)
          : Container();

  Widget _buildSubjectValidator(InAppSupportViewModel viewModel) => Text(
        viewModel.subjectValidationMessage!,
        style: style12R700,
        textAlign: TextAlign.start,
      );

  Widget _buildTypeFormField(InAppSupportViewModel viewModel) => TextFormField(
        controller: typeController,
        onTap: viewModel.setTypeFocus,
        decoration: inputDecoration(
            hint: LocaleKeys.issue_type_label.tr(),
            focus: viewModel.focusType,
            filled: typeController.text.isNotEmpty),
      );

  Widget _buildTypeValidatorWrapper(InAppSupportViewModel viewModel) =>
      viewModel.hasTypeValidationMessage
          ? _buildTypeValidator(viewModel)
          : Container();

  Widget _buildTypeValidator(InAppSupportViewModel viewModel) => Text(
        viewModel.typeValidationMessage!,
        style: style12R700,
        textAlign: TextAlign.start,
      );

  Widget _buildDescriptionFormField(InAppSupportViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        maxLength: 250,
        controller: descriptionController,
        onTap: viewModel.setDescriptionFocus,
        decoration: inputDecoration(
            focus: viewModel.focusDescription,
            hint: LocaleKeys.describe_issue_hint.tr(),
            filled: descriptionController.text.isNotEmpty),
      );

  Widget _buildDescriptionValidatorWrapper(InAppSupportViewModel viewModel) =>
      viewModel.hasDescriptionValidationMessage
          ? _buildDescriptionValidator(viewModel)
          : Container();

  Widget _buildDescriptionValidator(InAppSupportViewModel viewModel) => Text(
        viewModel.descriptionValidationMessage!,
        style: style12R700,
        textAlign: TextAlign.start,
      );

  Widget _buildContinueButton(InAppSupportViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: LocaleKeys.report.tr(),
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: subjectController.text.isNotEmpty &&
                typeController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty
            ? () async => await _report(viewModel)
            : null,
        backgroundColor: subjectController.text.isNotEmpty &&
                typeController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withValues(alpha: 0.1),
      );

  Widget _buildBodyState(InAppSupportViewModel viewModel) =>
      viewModel.busy(StateObjects.inAppSupport)
          ? const PageLoadingIndicator()
          : Container();
}
