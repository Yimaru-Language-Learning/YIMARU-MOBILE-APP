import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class CustomTable extends StatefulWidget {
  final Map<String, dynamic> data;

  const CustomTable({
    super.key,
    required this.data,
  });

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  late final List<String> _columns;
  late final List<List<String>> _rows;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _columns = (widget.data['columns'] as List).cast<String>();
    _rows = (widget.data['rows'] as List)
        .map((row) => (row as List).cast<String>())
        .toList();
  }

  TextEditingController _controller(int row, int col) {
    final key = '$row-$col';
    return _controllers.putIfAbsent(key, TextEditingController.new);
  }

  Map<String, dynamic> getCurrentData() {
    final currentRows = <List<String>>[];
    for (int r = 0; r < _rows.length; r++) {
      final row = <String>[];
      for (int c = 0; c < _columns.length; c++) {
        final key = '$r-$c';
        final controller = _controllers[key];
        row.add(controller != null ? controller.text : _rows[r][c]);
      }
      currentRows.add(row);
    }
    return {
      'columns': _columns,
      'rows': currentRows,
    };
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int number = 1; // Counter for TextFields

    return _buildTableWrapper(number);
  }

  Widget _buildTableWrapper(int number) =>
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: kcVeryLightGrey),
        ),
        child: _buildTableClipWrapper(number),
      );

  Widget _buildTableClipWrapper(int number) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _buildTableScrollerWrapper(number),
      );

  Widget _buildTableScrollerWrapper(int number) =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery
                .of(context)
                .size
                .width - 32,
          ),
          child: _buildTable(number),
        ),
      );

  Widget _buildTable(int number) =>
      Table(
        columnWidths: {
          for (int i = 0; i < _columns.length; i++) i: const FlexColumnWidth(),
        },
        border:  TableBorder(
          bottom: BorderSide(color: kcVeryLightGrey.withValues(alpha: 0.25)),
          horizontalInside: BorderSide(color: kcLightGrey.withValues(alpha: 0.25)),
        ),
        children: _buildTableRowChildren(number),
      );

  List<TableRow> _buildTableRowChildren(int number) =>
      [
        _buildTableHeaderWrapper(),
        ..._rows
            .asMap()
            .entries
            .map((rowEntry) =>
            _buildTableRowWrapper(
              number: number,
              row: rowEntry.value,
              rowIdx: rowEntry.key,
            )),
      ];

  TableRow _buildTableHeaderWrapper() =>
      TableRow(
        decoration: BoxDecoration(color: kcVeryLightGrey.withValues(alpha: 0.75)),
        children: _columns.map((col) => _buildTableHeader(col)).toList(),
      );

  Widget _buildTableHeader(String col) =>
      Padding(
        padding: const EdgeInsets.all(16),
        child: _buildTableHeaderText(col),
      );

  Widget _buildTableHeaderText(String col) =>
      Text(
        col,
        style: style14DG400,
      );

  TableRow _buildTableRowWrapper({required int rowIdx,
    required int number,
    required List<String> row}) =>
      TableRow(
        children: row
            .asMap()
            .entries
            .map((cellEntry) =>
            _buildTableRow(
              rowIdx: rowIdx,
              cell: cellEntry.value,
              colIdx: cellEntry.key,
              number: number,
              isEmpty: cellEntry.value
                  .trim()
                  .isEmpty,
            ))
            .toList(),
      );

  Widget _buildTableRow({
    required int rowIdx,
    required int colIdx,
    required String cell,
    required bool isEmpty,
    required int number,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: _buildTableState(
            rowIdx: rowIdx,
            colIdx: colIdx,
            cell: cell,
            isEmpty: isEmpty,
            number: number),
      );

  Widget _buildTableState({
    required int rowIdx,
    required int colIdx,
    required int number,
    required bool isEmpty,
    required String cell,
  }) =>
      isEmpty
          ? _buildTextFieldRow(number: number, rowIdx: rowIdx, colIdx: colIdx)
          : _buildCell(cell);

  Widget _buildTextFieldRow({
    required int number,
    required int rowIdx,
    required int colIdx,
  }) =>
      Row(
        children: [
          _buildNumbering(number),
          horizontalSpaceSmall,
          _buildTextFieldWrapper(rowIdx: rowIdx, colIdx: colIdx),
        ],
      );

  Widget _buildNumbering(int number) =>
      Text(
        '${number++}.',
        style: style14DG400,
      );

  Widget _buildTextFieldWrapper({
    required int rowIdx,
    required int colIdx,
  }) =>
      Expanded(
        child: TextField(
          style: style14DG400,
          controller: _controller(rowIdx, colIdx),
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            hintStyle: style14DG400,
            fillColor: kcVeryLightGrey.withValues(alpha: 0.5),
            hintText: '${LocaleKeys.enter.tr()} ${_columns[colIdx].toLowerCase()}...',
            border: tableBorder,
            focusedBorder: tableBorder,
            enabledBorder: tableBorder,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
          ),
        ),
      );

  Widget _buildCell(String cell) =>
      Text(
        cell,
        style: style14DG400.copyWith(height: 1.5),
      );
}
