import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/custom_form_label.dart';
import 'package:yimaru_app/ui/widgets/small_app_bar.dart';

import '../../../models/field_option.dart';
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
])
class ProfileDetailView extends StackedView<ProfileDetailViewModel>
    with $ProfileDetailView {
  const ProfileDetailView({Key? key}) : super(key: key);

  void _setSelectedCountry(
      {FieldOption? value, required ProfileDetailViewModel viewModel}) {
    viewModel.setSelectedCountry(value);

    if (viewModel.selectedCountry?.label?.toLowerCase().tr() != 'ethiopia') {
      regionController.clear();
      viewModel.unsetRegionFocus();
    }
  }

  Future<void> _update(ProfileDetailViewModel viewModel) async {
    Map<String, dynamic> data = {
      'gender': viewModel.selectedGender,
      'region': viewModel.dropdownRegion
          ? viewModel.selectedRegion?.code
          : regionController.text,
      'last_name': lastNameController.text,
      'first_name': firstNameController.text,
      'country': viewModel.selectedCountry?.code,
      'occupation': viewModel.selectedOccupation?.code,
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

  void _checkRegion(ProfileDetailViewModel viewModel) {
    bool region = viewModel.checkRegion(
        region: viewModel.user?.region ?? '',
        country: viewModel.user?.country ?? '');
    if (region) {
      FieldOption? option = viewModel.regions
          .where((e) => (e.code ?? '') == viewModel.user?.region)
          .first;
      viewModel.setSelectedRegion(option);
    } else {
      regionController.text = viewModel.user?.region ?? '';
    }
  }

  void _onModelReady(ProfileDetailViewModel viewModel) {
    phoneNumberController.text = '251900000000';
    emailController.text = viewModel.user?.email ?? '';
    lastNameController.text = viewModel.user?.lastName ?? '';
    firstNameController.text = viewModel.user?.firstName ?? '';
    _checkRegion(viewModel);
    viewModel.clearUserData();
    viewModel.setSelectedGender(viewModel.user?.gender ?? '');
    viewModel.setSelectedOccupation(viewModel.occupations
        .where((e) => (e.code ?? '') == viewModel.user?.occupation)
        .first);
    viewModel.setSelectedCountry(viewModel.countries
        .where((e) => (e.code ?? '') == viewModel.user?.country)
        .first);
    if (viewModel.user?.country?.toLowerCase() == 'et') {
      viewModel.setEthiopianRegion(viewModel.user?.region ?? '');
    } else {
      regionController.text = viewModel.user?.region ?? '';
    }
  }

  @override
  void onViewModelReady(ProfileDetailViewModel viewModel) async {
    await viewModel.getProfileDetailFields();
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
        body: _buildScaffoldState(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldState(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      viewModel.busy(StateObjects.profileDetail)
          ? const PageLoadingIndicator()
          : _buildScaffoldContainer(context: context, viewModel: viewModel);

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required ProfileDetailViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffoldStack(context: context, viewModel: viewModel),
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
        title: LocaleKeys.edit_profile.tr(),
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
        style: style16DG600,
        label: LocaleKeys.first_name.tr(),
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
        style: style16DG600,
        label: LocaleKeys.last_name.tr(),
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
        style: style16DG600,
        label: LocaleKeys.gender.tr(),
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
          onChanged: (value) => viewModel.setSelectedGender(value ?? ''),
          child: _buildMaleRadioTileWrapper(viewModel));

  Widget _buildMaleRadioTileWrapper(ProfileDetailViewModel viewModel) =>
      Container(
          width: 125,
          alignment: Alignment.centerLeft,
          child: _buildMaleRadioTile(viewModel));

  Widget _buildMaleRadioTile(ProfileDetailViewModel viewModel) =>
      RadioListTile<String?>(
        value: 'male',
        title: _buildMaleTitle(),
        activeColor: kcPrimaryColor,
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildMaleTitle() => Text(
        LocaleKeys.male.tr(),
        style: style14DG500,
      );

  Widget _buildFemaleRadioButton(ProfileDetailViewModel viewModel) =>
      RadioGroup<String?>(
          groupValue: viewModel.selectedGender,
          onChanged: (value) => viewModel.setSelectedGender(value ?? ''),
          child: _buildFemaleRadioTileWrapper(viewModel));

  Widget _buildFemaleRadioTileWrapper(ProfileDetailViewModel viewModel) =>
      Container(
        width: 125,
        alignment: Alignment.centerLeft,
        child: _buildFemaleRadioTile(viewModel),
      );

  Widget _buildFemaleRadioTile(ProfileDetailViewModel viewModel) =>
      RadioListTile<String?>(
        value: 'female',
        title: _buildFemaleTitle(),
        activeColor: kcPrimaryColor,
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildFemaleTitle() => Text(
        LocaleKeys.female.tr(),
        style: style14DG500,
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
        style: style16DG600,
        label: LocaleKeys.phone_number.tr(),
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
        style: style16DG600,
        label: LocaleKeys.email.tr(),
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
        style: style16DG600,
        label: LocaleKeys.country.tr(),
      );

  Widget _buildCountryDropdown(ProfileDetailViewModel viewModel) =>
      CustomDropdownPicker(
          icon: _buildSearchIcon(),
          hint: LocaleKeys.select_country.tr(),
          selectedItem: viewModel.selectedCountry,
          items: (value, props) => viewModel.countries,
          onChanged: (value) =>
              _setSelectedCountry(value: value, viewModel: viewModel));

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
        _buildRegionFormState(viewModel),
        if (viewModel.hasRegionValidationMessage &&
            !viewModel.dropdownRegion &&
            viewModel.focusRegion)
          verticalSpaceTiny,
        if (viewModel.hasRegionValidationMessage &&
            !viewModel.dropdownRegion &&
            viewModel.focusRegion)
          _buildRegionValidatorWrapper(viewModel),
      ];

  Widget _buildRegionFormFieldLabel() => CustomFormLabel(
        style: style16DG600,
        label: LocaleKeys.region.tr(),
      );

  Widget _buildRegionFormState(ProfileDetailViewModel viewModel) =>
      viewModel.dropdownRegion
          ? _buildRegionDropDown(viewModel)
          : _buildRegionFormField(viewModel);

  Widget _buildRegionDropDown(ProfileDetailViewModel viewModel) =>
      CustomDropdownPicker(
          icon: _buildSearchIcon(),
          hint: LocaleKeys.select_region.tr(),
          selectedItem: viewModel.selectedRegion,
          items: (value, props) => viewModel.regions,
          onChanged: (value) => viewModel.setSelectedRegion(value));

  Widget _buildRegionFormField(ProfileDetailViewModel viewModel) =>
      TextFormField(
        controller: regionController,
        onTap: viewModel.setRegionFocus,
        decoration: inputDecoration(
            focus: viewModel.focusRegion,
            hint: LocaleKeys.enter_your_city.tr(),
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
        _buildOccupationDropdown(viewModel)
      ];

  Widget _buildOccupationDropdownLabel() => CustomFormLabel(
        style: style16DG600,
        label: LocaleKeys.occupation.tr(),
      );

  Widget _buildOccupationDropdown(ProfileDetailViewModel viewModel) =>
      CustomDropdownPicker(
          icon: _buildSearchIcon(),
          hint: LocaleKeys.select_occupation.tr(),
          selectedItem: viewModel.selectedOccupation,
          items: (value, props) => viewModel.occupations,
          onChanged: (value) => viewModel.setSelectedOccupation(value));

  Icon _buildSearchIcon() => const Icon(
        Icons.search,
        color: kcPrimaryColor,
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
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.save_changes.tr(),
        onTap: () async => await _update(viewModel),
      );

  Widget _buildCancelButtonWrapper(ProfileDetailViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildCancelButton(viewModel),
      );

  Widget _buildCancelButton(ProfileDetailViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        onTap: viewModel.pop,
        backgroundColor: kcWhite,
        text: LocaleKeys.cancel.tr(),
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );

  Widget _buildState(ProfileDetailViewModel viewModel) =>
      viewModel.busy(StateObjects.profileUpdate)
          ? const PageLoadingIndicator()
          : Container();
}
