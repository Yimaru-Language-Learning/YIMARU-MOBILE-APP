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
        data: ThemeData().copyWith(cardColor: kcBackgroundColor),
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
        menuProps: const MenuProps(color: kcBackgroundColor),
        itemBuilder: (context, value, isSelected, isPicked) =>
            _buildPopupProsBuilderWrapper(value),
      );

  TextFieldProps _searchFieldProps() => TextFieldProps(
        maxLines: 1,
        autofocus: true,
        style: const TextStyle(
          fontSize: 14,
          color: kcLightGrey,
        ),
        padding: EdgeInsets.zero,
        cursorColor: kcLightGrey,
        decoration: _popUpDecoration(),
      );

  InputDecoration _popUpDecoration() => InputDecoration(
        filled: true,
        errorBorder: searchBorder,
        focusedBorder: searchBorder,
        enabledBorder: searchBorder,
        disabledBorder: searchBorder,
        focusedErrorBorder: searchBorder,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: kcLightGrey,
        ),
        fillColor: kcPrimaryColor.withOpacity(0.1),
        prefix: icon != null ? _buildPrefixIcon() : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
        focusedErrorBorder: border,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: kcLightGrey,
        ),
        fillColor: kcPrimaryColor.withOpacity(0.1),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      );

  Widget _buildPrefixIcon() => Container(
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: rightBorder),
        margin: const EdgeInsets.only(right: 25, bottom: 7.5, left: 5),
        child: icon,
      );

  Widget _buildDropdownBuilder(String? value) => Text(
        value ?? hint,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 14,
          color: kcDarkGrey,
        ),
      );
}
