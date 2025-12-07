import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:typed_data';

import '../API/employee_report_sql2.dart';

Future<void> ExportExcel2() async {
  final employeeService2 = empoloyeecheckINSQL2();
  final data = await employeeService2.employeeReportCheckin(
    StartDate: DateTime.now(),
    endDate: DateTime.now(),
    from: 0,
    to: 9999,
  );

  final excel = Excel.createExcel();
  final sheet = excel['Report-Late'];
  excel.delete('Sheet1');

  final Set<String> headerSet = {};
  for (final row in data) {
    headerSet.addAll(row.keys);
  }
  final List<String> headers = headerSet.toList();

  sheet.appendRow(headers.map((h) => TextCellValue(h)).toList());
  for (final row in data) {
    final List<CellValue?> rowCells =
        headers.map((key) {
          final value = row.containsKey(key) ? row[key] : null;

          if (value == null) {
            return TextCellValue('');
          } else if (value is int) {
            return IntCellValue(value);
          } else if (value is double) {
            return DoubleCellValue(value);
          } else if (value is DateTime) {
            return DateTimeCellValue.fromDateTime(value);
          } else {
            try {
              final dt = DateTime.parse(value.toString());
              return DateTimeCellValue.fromDateTime(dt);
            } catch (_) {
              return TextCellValue(value.toString());
            }
          }
        }).toList();
    sheet.appendRow(rowCells);
  }

  String fileName = 'Report-Late${DateTime.now().toIso8601String()}';
  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: Uint8List.fromList(fileBytes),
      mimeType: MimeType.microsoftExcel,
    );
    Get.snackbar('Success', 'Excel exported: $fileName');
  } else {
    Get.snackbar('Error', 'Failed to generate Excel');
  }
}
