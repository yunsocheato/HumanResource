import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../API/employee_report_sql4.dart';
import 'dart:typed_data';

Future<void> ExportExcel4({
  required int page,
  required int pageSize,
  required DateTime endDate,
  required DateTime startDate,
  required int from,
  required int to,
}) async {
  final employeeService4 = EmployeeReportSQL4();
  final data = await employeeService4.employeeabsent(
    startDate: startDate,
    endDate: endDate,
    page: page,
    pageSize: pageSize,
    from: from,
    to: to,
  );

  if (data.isEmpty) {
    Get.snackbar('Info', 'No data available to export');
    return;
  }

  final excel = Excel.createExcel();
  final sheet = excel['Absent-Report'];
  excel.delete('Sheet1');

  final headers = data.first.keys.toList();
  sheet.appendRow(headers.map((h) => TextCellValue(h)).toList());

  for (final row in data) {
    final rowCells = headers.map((key) {
      final value = row[key];

      if (value == null) return  TextCellValue('');
      if (value is int) return IntCellValue(value);
      if (value is double) return DoubleCellValue(value);
      if (value is DateTime) return DateTimeCellValue.fromDateTime(value);

      try {
        final dt = DateTime.parse(value.toString());
        return DateTimeCellValue.fromDateTime(dt);
      } catch (_) {
        return TextCellValue(value.toString());
      }
    }).toList();

    sheet.appendRow(rowCells);
  }

  String fileName = 'Report-Absent${DateTime.now().toIso8601String()}';
  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: Uint8List.fromList(fileBytes),
      mimeType: MimeType.microsoftExcel,
    );
    Get.snackbar('Success', 'Excel exported: $fileName');
  }
  else {
    Get.snackbar('Error', 'Failed to generate Excel');
  }
}


