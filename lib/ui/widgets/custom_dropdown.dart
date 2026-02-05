import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class CustomDropdownPicker extends StatelessWidget {
  final Icon? icon;
  final String hint;
  final String selectedItem;
  final void Function(String?)? onChanged;
  final FutureOr<List<String>> Function(String value, LoadProps? props)? items;

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

  Widget _buildDropDownSearch() => DropdownSearch<String>(
        popupProps: _popupProps(),
        selectedItem: selectedItem,
        onChanged: (value) => onChanged!(value),
        decoratorProps: _dropDownDecoratorProps(),
        dropdownBuilder: (context, value) => _buildDropdownBuilder(value),
        items: (value, properties) async => await items!(value, properties),
      );

  PopupProps<String> _popupProps() => PopupProps.menu(
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
        fillColor: kcTransparent,
        errorBorder: searchBorder,
        focusedBorder: searchBorder,
        enabledBorder: searchBorder,
        disabledBorder: searchBorder,
        focusedErrorBorder: searchBorder,
        contentPadding: const EdgeInsets.only(top: 12),
        prefixIcon: icon != null ? _buildPrefixIcon() : null,
      );

  Widget _buildPopupProsBuilderWrapper(String value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: _buildPopupProsBuilder(value),
      );

  Widget _buildPopupProsBuilder(String value) => Text(
        value,
        maxLines: 1,
        style: const TextStyle(color: kcDarkGrey, fontSize: 14),
      );

  DropDownDecoratorProps _dropDownDecoratorProps() => DropDownDecoratorProps(
        decoration: _dropDownDecoration(),
        textAlignVertical: TextAlignVertical.center,
      );

  InputDecoration _dropDownDecoration() => InputDecoration(
        filled: true,
        hintText: hint,
        hintMaxLines: 1,
        errorBorder: border,
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        hintStyle: style14LG400,
        fillColor: kcPrimaryColor.withOpacity(0.1),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      );

  Widget _buildPrefixIcon() => Padding(
        padding: const EdgeInsets.only(right: 10, left: 5),
        child: icon,
      );

  Widget _buildDropdownBuilder(String? value) => Text(
        value ?? hint,
        maxLines: 1,
        style: style14DG400,
      );
}
