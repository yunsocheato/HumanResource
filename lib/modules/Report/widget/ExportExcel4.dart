import 'dart:io';
import 'dart:html'as html;
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';

import '../API/employee_report_sql4.dart';

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

  final fileName = 'Absents-Reports-${DateTime.now().toIso8601String()}.xlsx';
  final bytes = excel.encode();
  if (bytes == null) return;

  if (kIsWeb) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrl(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  } else if (Platform.isAndroid || Platform.isIOS || Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, fileName);
    final file = File(path);
    await file.writeAsBytes(bytes);
    Get.snackbar('Success', 'Excel exported to $path');
  } else {
    Get.snackbar('Error', 'Unsupported platform');
  }
}


