import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class BirthdaySelector extends StatelessWidget {
  final String? birthday;
  final void Function(DateTime)? onSelected;

  const BirthdaySelector({super.key, this.birthday, this.onSelected});

  DateTime _initialDate() {
    try {
      final parsedDate = format.parse(birthday ?? '');
      return parsedDate.isAfter(DateTime.now()) ? DateTime.now() : parsedDate;
    } catch (_) {
      return DateTime.now();
    }
  }

  Future<void> _pickDateTime(
    BuildContext context,
  ) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      is24HourMode: false,
      isShowSeconds: false,
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
      barrierDismissible: true,
      initialDate: _initialDate(),
      titleSeparator: const Divider(),
      padding: const EdgeInsets.all(16),
      type: OmniDateTimePickerType.date,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      title: const Text('Birthday', style: TextStyle(fontSize: 16)),
      theme: ThemeData(
        colorScheme:
            const ColorScheme.light().copyWith(primary: kcPrimaryColor),
      ),
    );

    if (dateTime != null) {
      //  String formattedDateTime = DateFormat('d MMM, yyyy').format(dateTime);

      if (onSelected != null) {
        onSelected!(dateTime);
      }
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      _buildButtonWrapper(
        context,
      );

  Widget _buildButtonWrapper(BuildContext context) => Container(
        height: 50,
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        child: _buildContainerWrapper(context),
      );

  Widget _buildContainerWrapper(BuildContext context) => GestureDetector(
        onTap: () async => await _pickDateTime(
          context,
        ),
        child: _buildContainer(),
      );

  Widget _buildContainer() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kcPrimaryColor.withOpacity(0.1),
          border: Border.all(color: kcPrimaryColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildButtonRowWrapper(),
      );

  Widget _buildButtonRowWrapper() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtonRowChildren(),
      );

  List<Widget> _buildButtonRowChildren() => [_buildText(), _buildIcon()];

  Widget _buildText() => Text(
        birthday ?? 'Pick birthday',
        style: const TextStyle(color: kcDarkGrey),
      );

  Widget _buildIcon() => const Icon(
        Icons.calendar_month,
        color: kcPrimaryColor,
      );
}
