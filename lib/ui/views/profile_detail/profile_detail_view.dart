import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/widgets/birthday_selector.dart';
import 'package:yimaru_app/ui/widgets/custom_form_label.dart';
import 'package:yimaru_app/ui/widgets/small_app_bar.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/profile_image.dart';
import 'profile_detail_viewmodel.dart';

import 'profile_detail_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'email', validator: FormValidator.validateForm),
  FormTextField(
      name: 'phoneNumber', validator: FormValidator.validatePhoneNumber),
  FormTextField(name: 'lastName', validator: FormValidator.validateForm),
  FormTextField(name: 'firstName', validator: FormValidator.validateForm),
])
class ProfileDetailView extends StackedView<ProfileDetailViewModel>
    with $ProfileDetailView {
  const ProfileDetailView({Key? key}) : super(key: key);

  void _onModelReady() {
    firstNameController.text = 'Abel';
    lastNameController.text = 'Abebe';
    phoneNumberController.text = '251900000000';
    emailController.text = 'email@test.com';
  }

  @override
  void onViewModelReady(ProfileDetailViewModel viewModel) {
    _onModelReady();
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  ProfileDetailViewModel viewModelBuilder(BuildContext context) =>
      ProfileDetailViewModel();

  @override
  Widget builder(
    BuildContext context,
    ProfileDetailViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(ProfileDetailViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(ProfileDetailViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(ProfileDetailViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(ProfileDetailViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(ProfileDetailViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppbar(viewModel),
        verticalSpaceSmall,
        _buildColumnWrapper(viewModel)
      ];

  Widget _buildAppbar(ProfileDetailViewModel viewModel) => SmallAppBar(
        title: 'Edit Profile',
        onTap: viewModel.pop,
      );

  Widget _buildColumnWrapper(ProfileDetailViewModel viewModel) =>
      Expanded(child: _buildBodyColumn(viewModel));

  Widget _buildBodyColumn(ProfileDetailViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(ProfileDetailViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(ProfileDetailViewModel viewModel) => [
        verticalSpaceMedium,
        _buildProfileImage(),
        verticalSpaceMedium,
        _buildNameFormSection(viewModel),
        verticalSpaceMedium,
        _buildGenderFormFieldWrapper(viewModel),
        verticalSpaceSmall,
        _buildBirthdayColumn(viewModel),
        verticalSpaceSmall,
        _buildPhoneNumberFormFieldSection(viewModel),
        verticalSpaceTiny,
        _buildEmailFormFieldSection(viewModel),
        verticalSpaceMedium,
        _buildCountryRegionSection(viewModel),
        verticalSpaceMedium,
        _buildOccupationDropdownWrapper(viewModel),
        verticalSpaceLarge,
        _buildLowerColumn(viewModel)
      ];

  Widget _buildProfileImage() =>
      const Align(alignment: Alignment.center, child: ProfileImage());

  Widget _buildNameFormSection(ProfileDetailViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildNameFormChildren(viewModel),
      );

  List<Widget> _buildNameFormChildren(ProfileDetailViewModel viewModel) => [
        _buildFirstNameFormFieldWrapper(viewModel),
        const SizedBox(width: 20),
        _buildLastNameFormFieldWrapper(viewModel)
      ];

  Widget _buildFirstNameFormFieldWrapper(ProfileDetailViewModel viewModel) =>
      Expanded(child: _buildFirstNameFormFieldColumn(viewModel));

  Widget _buildFirstNameFormFieldColumn(ProfileDetailViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildFirstNameFormFieldChildren(viewModel),
      );

  List<Widget> _buildFirstNameFormFieldChildren(
          ProfileDetailViewModel viewModel) =>
      [
        _buildFirstNameLabel(),
        verticalSpaceSmall,
        _buildFirstNameFormField(viewModel),
        if (viewModel.hasFirstNameValidationMessage && viewModel.focusFirstName)
          verticalSpaceTiny,
        if (viewModel.hasFirstNameValidationMessage && viewModel.focusFirstName)
          _buildFirstNameValidatorWrapper(viewModel)
      ];

  Widget _buildFirstNameLabel() => CustomFormLabel(
        label: 'First Name',
        style: style16DG600,
      );

  Widget _buildFirstNameFormField(ProfileDetailViewModel viewModel) =>
      TextFormField(
        controller: firstNameController,
        onTap: viewModel.setFirstNameFocus,
        decoration: inputDecoration(
            focus: viewModel.focusFirstName,
            filled: firstNameController.text.isNotEmpty),
      );

  Widget _buildFirstNameValidatorWrapper(ProfileDetailViewModel viewModel) =>
      viewModel.hasFirstNameValidationMessage
          ? _buildFirstNameValidator(viewModel)
          : Container();

  Widget _buildFirstNameValidator(ProfileDetailViewModel viewModel) => Text(
        viewModel.firstNameValidationMessage!,
        style: validationStyle,
      );

  Widget _buildLastNameFormFieldWrapper(ProfileDetailViewModel viewModel) =>
      Expanded(child: _buildLastNameFormFieldColumn(viewModel));

  Widget _buildLastNameFormFieldColumn(ProfileDetailViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLastNameFormFieldChildren(viewModel),
      );

  List<Widget> _buildLastNameFormFieldChildren(
          ProfileDetailViewModel viewModel) =>
      [
        _buildLastNameLabel(),
        verticalSpaceSmall,
        _buildLastNameFormField(viewModel),
        if (viewModel.hasLastNameValidationMessage && viewModel.focusLastName)
          verticalSpaceTiny,
        if (viewModel.hasLastNameValidationMessage && viewModel.focusLastName)
          _buildLastNameValidatorWrapper(viewModel)
      ];

  Widget _buildLastNameLabel() => CustomFormLabel(
        label: 'Last Name',
        style: style16DG600,
      );

  Widget _buildLastNameFormField(ProfileDetailViewModel viewModel) =>
      TextFormField(
        controller: lastNameController,
        onTap: viewModel.setLastNameFocus,
        decoration: inputDecoration(
            focus: viewModel.focusLastName,
            filled: lastNameController.text.isNotEmpty),
      );

  Widget _buildLastNameValidatorWrapper(ProfileDetailViewModel viewModel) =>
      viewModel.hasLastNameValidationMessage
          ? _buildLastNameValidator(viewModel)
          : Container();

  Widget _buildLastNameValidator(ProfileDetailViewModel viewModel) => Text(
        viewModel.lastNameValidationMessage!,
        style: validationStyle,
      );

  Widget _buildGenderFormFieldWrapper(ProfileDetailViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildGenderFormFieldChildren(viewModel),
      );

  List<Widget> _buildGenderFormFieldChildren(
          ProfileDetailViewModel viewModel) =>
      [
        _buildGenderLabel(),
        verticalSpaceTiny,
        _buildRadioButtonWrapper(viewModel),
      ];

  Widget _buildGenderLabel() => CustomFormLabel(
        label: 'Gender',
        style: style16DG600,
      );

  Widget _buildRadioButtonWrapper(ProfileDetailViewModel viewModel) => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildRadioButtonChildren(viewModel),
      );

  List<Widget> _buildRadioButtonChildren(ProfileDetailViewModel viewModel) =>
      [_buildMaleRadioButton(viewModel), _buildFemaleRadioButton(viewModel)];

  Widget _buildMaleRadioButton(ProfileDetailViewModel viewModel) =>
      RadioGroup<String?>(
          groupValue: viewModel.selectedGender,
          onChanged: (value) => viewModel.setGender(value ?? ''),
          child: _buildMaleRadioTileWrapper(viewModel));

  Widget _buildMaleRadioTileWrapper(ProfileDetailViewModel viewModel) =>
      Container(
          width: 125,
          alignment: Alignment.centerLeft,
          child: _buildMaleRadioTile(viewModel));

  Widget _buildMaleRadioTile(ProfileDetailViewModel viewModel) =>
      RadioListTile<String?>(
        value: 'Male',
        title: _buildMaleTitle(),
        activeColor: kcPrimaryColor,
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildMaleTitle() => const Text(
        'Male',
        style: TextStyle(
          fontSize: 14,
          color: kcDarkGrey,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildFemaleRadioButton(ProfileDetailViewModel viewModel) =>
      RadioGroup<String?>(
          groupValue: viewModel.selectedGender,
          onChanged: (value) => viewModel.setGender(value ?? ''),
          child: _buildFemaleRadioTileWrapper(viewModel));

  Widget _buildFemaleRadioTileWrapper(ProfileDetailViewModel viewModel) =>
      Container(
        width: 125,
        alignment: Alignment.centerLeft,
        child: _buildFemaleRadioTile(viewModel),
      );

  Widget _buildFemaleRadioTile(ProfileDetailViewModel viewModel) =>
      RadioListTile<String?>(
        value: 'Female',
        title: _buildFemaleTitle(),
        activeColor: kcPrimaryColor,
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildFemaleTitle() => const Text(
        'Female',
        style: TextStyle(
          fontSize: 14,
          color: kcDarkGrey,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildBirthdayColumn(ProfileDetailViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBirthdayChildren(viewModel),
      );

  List<Widget> _buildBirthdayChildren(ProfileDetailViewModel viewModel) => [
        _buildBirthdayLabel(),
        verticalSpaceSmall,
        _buildBirthdayFormField(viewModel),
      ];

  Widget _buildBirthdayLabel() => CustomFormLabel(
        label: 'Birthday',
        style: style16DG600,
      );

  Widget _buildBirthdayFormField(ProfileDetailViewModel viewModel) =>
      BirthdaySelector(
        birthday: viewModel.selectedBirthday,
        onSelected: (value) =>
            viewModel.setBirthday(DateFormat('d MMM, yyyy').format(value)),
      );

  Widget _buildPhoneNumberFormFieldSection(ProfileDetailViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPhoneNumberFormFieldChildren(viewModel),
      );

  List<Widget> _buildPhoneNumberFormFieldChildren(
          ProfileDetailViewModel viewModel) =>
      [
        _buildPhoneNumberLabel(),
        verticalSpaceSmall,
        _buildPhoneNumberFormField(viewModel),
        if (viewModel.hasPhoneNumberValidationMessage &&
            viewModel.focusPhoneNumber)
          verticalSpaceTiny,
        if (viewModel.hasPhoneNumberValidationMessage &&
            viewModel.focusPhoneNumber)
          _buildPhoneNumberValidatorWrapper(viewModel)
      ];

  Widget _buildPhoneNumberLabel() => CustomFormLabel(
        label: 'Phone Number',
        style: style16DG600,
      );

  Widget _buildPhoneNumberFormField(ProfileDetailViewModel viewModel) =>
      TextFormField(
        maxLength: 12,
        keyboardType: TextInputType.phone,
        controller: phoneNumberController,
        onTap: viewModel.setPhoneNumberFocus,
        decoration: inputDecoration(
            hint: '251',
            focus: viewModel.focusPhoneNumber,
            filled: phoneNumberController.text.isNotEmpty),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  Widget _buildPhoneNumberValidatorWrapper(ProfileDetailViewModel viewModel) =>
      viewModel.hasPhoneNumberValidationMessage
          ? _buildPhoneNumberValidator(viewModel)
          : Container();

  Widget _buildPhoneNumberValidator(ProfileDetailViewModel viewModel) => Text(
        viewModel.phoneNumberValidationMessage!,
        style: validationStyle,
      );

  Widget _buildEmailFormFieldSection(ProfileDetailViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildEmailFormFieldChildren(viewModel),
      );

  List<Widget> _buildEmailFormFieldChildren(ProfileDetailViewModel viewModel) =>
      [
        _buildEmailLabel(),
        verticalSpaceSmall,
        _buildEmailFormField(viewModel),
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          verticalSpaceTiny,
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          _buildEmailValidatorWrapper(viewModel)
      ];

  Widget _buildEmailLabel() => CustomFormLabel(
        label: 'Email',
        style: style16DG600,
      );

  Widget _buildEmailFormField(ProfileDetailViewModel viewModel) =>
      TextFormField(
        controller: emailController,
        onTap: viewModel.setPhoneNumberFocus,
        keyboardType: TextInputType.emailAddress,
        decoration: inputDecoration(
            focus: viewModel.focusEmail,
            filled: emailController.text.isNotEmpty),
      );

  Widget _buildEmailValidatorWrapper(ProfileDetailViewModel viewModel) =>
      viewModel.hasEmailValidationMessage
          ? _buildEmailValidator(viewModel)
          : Container();

  Widget _buildEmailValidator(ProfileDetailViewModel viewModel) => Text(
        viewModel.emailValidationMessage!,
        style: validationStyle,
      );

  Widget _buildCountryRegionSection(ProfileDetailViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildCountryRegionChildren(viewModel),
      );

  List<Widget> _buildCountryRegionChildren(ProfileDetailViewModel viewModel) =>
      [
        _buildCountryDropdownColumnWrapper(viewModel),
        const SizedBox(width: 20),
        _buildRegionDropdownColumnWrapper(viewModel)
      ];

  Widget _buildCountryDropdownColumnWrapper(ProfileDetailViewModel viewModel) =>
      Expanded(
        child: _buildCountryDropdownColumn(viewModel),
      );

  Widget _buildCountryDropdownColumn(ProfileDetailViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildCountryDropdownChildren(viewModel),
      );

  List<Widget> _buildCountryDropdownChildren(
          ProfileDetailViewModel viewModel) =>
      [
        _buildCountryDropdownLabel(),
        verticalSpaceSmall,
        _buildCountryDropdown(viewModel)
      ];

  Widget _buildCountryDropdownLabel() => CustomFormLabel(
        label: 'Country',
        style: style16DG600,
      );

  Widget _buildCountryDropdown(ProfileDetailViewModel viewModel) =>
      CustomDropdownPicker(
        onChanged: (value) {},
        hint: 'Select country',
        selectedItem: 'Ethiopia',
        items: (value, props) => viewModel.getCountries(),
      );

  Widget _buildRegionDropdownColumnWrapper(ProfileDetailViewModel viewModel) =>
      Expanded(
        child: _buildRegionDropdownColumn(viewModel),
      );

  Widget _buildRegionDropdownColumn(ProfileDetailViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildRegionDropdownChildren(viewModel),
      );

  List<Widget> _buildRegionDropdownChildren(ProfileDetailViewModel viewModel) =>
      [
        _buildRegionDropdownLabel(),
        verticalSpaceSmall,
        _buildRegionDropdown(viewModel)
      ];

  Widget _buildRegionDropdownLabel() => CustomFormLabel(
        label: 'Region',
        style: style16DG600,
      );

  Widget _buildRegionDropdown(ProfileDetailViewModel viewModel) =>
      CustomDropdownPicker(
        hint: 'Select region',
        onChanged: (value) {},
        selectedItem: 'Addis Ababa',
        items: (value, props) => viewModel.getRegions('Addis Ababa'),
      );

  Widget _buildOccupationDropdownWrapper(ProfileDetailViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildOccupationDropdownChildren(viewModel),
      );

  List<Widget> _buildOccupationDropdownChildren(
          ProfileDetailViewModel viewModel) =>
      [
        _buildOccupationDropdownLabel(),
        verticalSpaceSmall,
        _buildOccupationDropdown(viewModel)
      ];

  Widget _buildOccupationDropdownLabel() => CustomFormLabel(
        label: 'Occupation',
        style: style16DG600,
      );

  Widget _buildOccupationDropdown(ProfileDetailViewModel viewModel) =>
      CustomDropdownPicker(
        hint: 'Select occupation',
        onChanged: (value) {},
        selectedItem: 'Student',
        items: (value, props) => viewModel.getOccupations('Student'),
      );

  Widget _buildLowerColumn(ProfileDetailViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(ProfileDetailViewModel viewModel) => [
        _buildSaveButton(viewModel),
        verticalSpaceSmall,
        _buildCancelButtonWrapper(viewModel)
      ];

  Widget _buildSaveButton(ProfileDetailViewModel viewModel) =>
      const CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Save Changes',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildCancelButtonWrapper(ProfileDetailViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildCancelButton(viewModel),
      );

  Widget _buildCancelButton(ProfileDetailViewModel viewModel) =>
      const CustomElevatedButton(
        height: 55,
        text: 'Cancel',
        borderRadius: 12,
        borderColor: kcPrimaryColor,
        backgroundColor: kcWhite,
        foregroundColor: kcPrimaryColor,
      );
}
