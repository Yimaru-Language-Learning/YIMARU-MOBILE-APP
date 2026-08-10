import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../../models/field_option.dart';

class CustomDropdownPicker extends StatelessWidget {
  final Icon? icon;
  final String hint;
  final FieldOption? selectedItem;
  final void Function(FieldOption?)? onChanged;
  final FutureOr<List<FieldOption>> Function(String value, LoadProps? props)?
      items;

  const CustomDropdownPicker(
      {super.key,
      this.icon,
      required this.hint,
      required this.items,
      required this.onChanged,
      required this.selectedItem});

  @override
  Widget build(BuildContext context) => _buildDropDownSearchWrapper();

  Widget _buildDropDownSearchWrapper() => Theme(
        data: ThemeData().copyWith(cardColor: const Color(0xfff5e9f4)),
        child: _buildDropDownSearch(),
      );

  Widget _buildDropDownSearch() => DropdownSearch<FieldOption>(
        onChanged: onChanged,
        popupProps: _popupProps(),
        selectedItem: selectedItem,
        itemAsString: (item) => item.label ?? '',
        decoratorProps: _dropDownDecoratorProps(),
        compareFn: (item1, item2) => item1.label == item2.label,
        items: (value, properties) => items!(value, properties),
        dropdownBuilder: (context, value) => _buildDropdownBuilder(value),
      );

  PopupProps<FieldOption> _popupProps() => PopupProps<FieldOption>.menu(
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: _searchFieldProps(),
        itemBuilder: (context, value, isSelected, isPicked) =>
            _buildPopupProsBuilderWrapper(value),
      );

  TextFieldProps _searchFieldProps() => TextFieldProps(
        maxLines: 1,
        autofocus: true,
        style: style14DG400,
        padding: EdgeInsets.zero,
        cursorColor: kcLightGrey,
        decoration: _popUpDecoration(),
      );

  InputDecoration _popUpDecoration() => InputDecoration(
        filled: true,
        hintStyle: style14DG400,
        errorBorder: universalSearchBorder,
        focusedBorder: universalSearchBorder,
        enabledBorder: universalSearchBorder,
        disabledBorder: universalSearchBorder,
        focusedErrorBorder: universalSearchBorder,
        fillColor: const Color(0xfff5e9f4),
        contentPadding: const EdgeInsets.only(top: 12),
        prefixIcon: icon != null ? _buildPrefixIcon() : null,
      );

  Widget _buildPopupProsBuilderWrapper(FieldOption value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: _buildPopupProsBuilder(value),
      );

  Widget _buildPopupProsBuilder(FieldOption value) => Text(
        value.label ?? '',
        maxLines: 1,
        style: style14DG400,
      );

  DropDownDecoratorProps _dropDownDecoratorProps() => DropDownDecoratorProps(
        decoration: _dropDownDecoration(),
        textAlignVertical: TextAlignVertical.center,
      );

  InputDecoration _dropDownDecoration() => InputDecoration(
        filled: true,
        hintText: hint,
        hintMaxLines: 1,
        errorBorder: universalBorder,
        focusedBorder: universalBorder,
        enabledBorder: universalBorder,
        disabledBorder: universalBorder,
        hintStyle: style14MG400,
        fillColor: kcPrimaryColor.withValues(alpha: 0.1),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      );

  Widget _buildPrefixIcon() => Padding(
        padding: const EdgeInsets.only(right: 10, left: 5),
        child: icon,
      );

  Widget _buildDropdownBuilder(FieldOption? value) => Text(
        value?.label ?? '',
        maxLines: 1,
        style: style14DG400,
      );
}
