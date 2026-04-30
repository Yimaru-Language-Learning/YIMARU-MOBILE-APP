import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/widgets/custom_form_label.dart';
import 'package:yimaru_app/ui/widgets/small_app_bar.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/image_picker_option.dart';
import '../../widgets/page_loading_indicator.dart';
import '../../widgets/profile_image.dart';
import 'profile_detail_viewmodel.dart';

import 'profile_detail_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'email', validator: FormValidator.validateForm),
  FormTextField(name: 'region', validator: FormValidator.validateForm),
  FormTextField(
      name: 'phoneNumber', validator: FormValidator.validatePhoneNumberForm),
  FormTextField(name: 'lastName', validator: FormValidator.validateForm),
  FormTextField(name: 'firstName', validator: FormValidator.validateForm),
  FormTextField(name: 'occupation', validator: FormValidator.validateForm),
])
class ProfileDetailView extends StackedView<ProfileDetailViewModel>
    with $ProfileDetailView {
  const ProfileDetailView({Key? key}) : super(key: key);

  Future<void> _update(ProfileDetailViewModel viewModel) async {
    Map<String, dynamic> data = {
      'region': regionController.text,
      'gender': viewModel.selectedGender,
      'last_name': lastNameController.text,
      'country': viewModel.selectedCountry,
      'first_name': firstNameController.text,
      'occupation': occupationController.text,
      'birth_day': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    };

    viewModel.addUserData(data);

    await viewModel.updateProfile();
  }

  Future<void> _showImagePicker(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) async =>
      await showDialog(
        context: context,
        builder: (context) =>
            _showImagePickerDialog(context: context, viewModel: viewModel),
      );

  AlertDialog _showImagePickerDialog(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      AlertDialog(
        backgroundColor: Colors.transparent,
        content: _buildImagePicker(context: context, viewModel: viewModel),
      );

  void _onModelReady(ProfileDetailViewModel viewModel) {
    phoneNumberController.text = '251900000000';
    emailController.text = viewModel.user?.email ?? '';
    regionController.text = viewModel.user?.region ?? '';
    lastNameController.text = viewModel.user?.lastName ?? '';
    firstNameController.text = viewModel.user?.firstName ?? '';
    occupationController.text = viewModel.user?.occupation ?? '';
    viewModel.clearUserData();
    viewModel.setGender(viewModel.user?.gender ?? '');
    viewModel.setSelectedCountry(viewModel.user?.country ?? 'Ethiopia');
  }

  @override
  void onViewModelReady(ProfileDetailViewModel viewModel) {
    _onModelReady(viewModel);
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
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      Stack(children: [
        _buildScaffold(context: context, viewModel: viewModel),
        _buildState(viewModel)
      ]);

  Widget _buildScaffold(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      SafeArea(
          child: _buildBodyWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyWrapper(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(context: context, viewModel: viewModel),
      );

  Widget _buildBody(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyChildren(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildAppbar(viewModel),
        verticalSpaceMedium,
        _buildColumnWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildAppbar(ProfileDetailViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        title: 'Edit Profile',
      );

  Widget _buildColumnWrapper(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      Expanded(child: _buildBodyColumn(context: context, viewModel: viewModel));

  Widget _buildBodyColumn(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildColumnChildren(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildProfileImageWrapper(context: context, viewModel: viewModel),
        verticalSpaceMedium,
        _buildNameFormSection(viewModel),
        verticalSpaceMedium,
        _buildGenderFormFieldWrapper(viewModel),
        verticalSpaceSmall,
        _buildPhoneNumberFormFieldSection(viewModel),
        verticalSpaceTiny,
        _buildEmailFormFieldSection(viewModel),
        verticalSpaceMedium,
        _buildCountryDropdownLabel(),
        verticalSpaceSmall,
        _buildCountryDropdown(viewModel),
        verticalSpaceMedium,
        _buildRegionFormFieldWrapper(viewModel),
        verticalSpaceMedium,
        _buildOccupationDropdownWrapper(viewModel),
        verticalSpaceLarge,
        _buildLowerColumn(viewModel)
      ];

  Widget _buildProfileImageWrapper(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      Align(
          alignment: Alignment.center,
          child: _buildProfileImage(context: context, viewModel: viewModel));

  Widget _buildProfileImage(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      ProfileImage(
        profileImage: viewModel.user?.profilePicture,
        loading: viewModel.busy(StateObjects.profileImage) ? true : false,
        onTap: () async =>
            await _showImagePicker(context: context, viewModel: viewModel),
      );

  Widget _buildImagePicker(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      ImagePickerOption(
        onCameraTap: () async => await viewModel.openCamera(),
        onGalleryTap: () async => await viewModel.openGallery(),
      );

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
        enabled: false,
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
        enabled: false,
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

  Widget _buildCountryDropdownLabel() => CustomFormLabel(
        label: 'Country',
        style: style16DG600,
      );

  Widget _buildCountryDropdown(ProfileDetailViewModel viewModel) =>
      CustomDropdownPicker(
        hint: 'Select country',
        selectedItem: viewModel.selectedCountry,
        items: (value, props) => viewModel.getCountries(),
        onChanged: (value) => viewModel.setSelectedCountry(value ?? 'Ethiopia'),
      );

  Widget _buildRegionFormFieldWrapper(ProfileDetailViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildRegionFormFieldChildren(viewModel),
      );

  List<Widget> _buildRegionFormFieldChildren(
          ProfileDetailViewModel viewModel) =>
      [
        _buildRegionFormFieldLabel(),
        verticalSpaceSmall,
        _buildRegionFormField(viewModel),
        if (viewModel.hasRegionValidationMessage && viewModel.focusRegion)
          verticalSpaceTiny,
        if (viewModel.hasRegionValidationMessage && viewModel.focusRegion)
          _buildRegionValidatorWrapper(viewModel),
      ];

  Widget _buildRegionFormFieldLabel() => CustomFormLabel(
        label: 'Region',
        style: style16DG600,
      );

  Widget _buildRegionFormField(ProfileDetailViewModel viewModel) =>
      TextFormField(
        controller: regionController,
        onTap: viewModel.setRegionFocus,
        decoration: inputDecoration(
            hint: 'Enter Your City',
            focus: viewModel.focusRegion,
            filled: regionController.text.isNotEmpty),
      );

  Widget _buildRegionValidatorWrapper(ProfileDetailViewModel viewModel) =>
      viewModel.hasRegionValidationMessage
          ? _buildRegionValidator(viewModel)
          : Container();

  Widget _buildRegionValidator(ProfileDetailViewModel viewModel) => Text(
        viewModel.regionValidationMessage!,
        style: style12R700,
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
        _buildOccupationFormField(viewModel),
        if (viewModel.hasOccupationValidationMessage &&
            viewModel.focusOccupation)
          verticalSpaceTiny,
        if (viewModel.hasOccupationValidationMessage &&
            viewModel.focusOccupation)
          _buildOccupationValidatorWrapper(viewModel)
      ];

  Widget _buildOccupationDropdownLabel() => CustomFormLabel(
        label: 'Occupation',
        style: style16DG600,
      );

  Widget _buildOccupationFormField(ProfileDetailViewModel viewModel) =>
      TextFormField(
        controller: occupationController,
        onTap: viewModel.setOccupationFocus,
        decoration: inputDecoration(
            hint: 'Enter Your Occupation',
            focus: viewModel.focusOccupation,
            filled: occupationController.text.isNotEmpty),
      );

  Widget _buildOccupationValidatorWrapper(ProfileDetailViewModel viewModel) =>
      viewModel.hasOccupationValidationMessage
          ? _buildOccupationValidator(viewModel)
          : Container();

  Widget _buildOccupationValidator(ProfileDetailViewModel viewModel) => Text(
        viewModel.occupationValidationMessage!,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      );
  Widget _buildLowerColumn(ProfileDetailViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(ProfileDetailViewModel viewModel) => [
        _buildSaveButton(viewModel),
        verticalSpaceMedium,
        _buildCancelButtonWrapper(viewModel)
      ];

  Widget _buildSaveButton(ProfileDetailViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Save Changes',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _update(viewModel),
      );

  Widget _buildCancelButtonWrapper(ProfileDetailViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildCancelButton(viewModel),
      );

  Widget _buildCancelButton(ProfileDetailViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Cancel',
        borderRadius: 12,
        onTap: viewModel.pop,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );

  Widget _buildState(ProfileDetailViewModel viewModel) =>
      viewModel.busy(StateObjects.profileUpdate)
          ? const PageLoadingIndicator()
          : Container();
}
