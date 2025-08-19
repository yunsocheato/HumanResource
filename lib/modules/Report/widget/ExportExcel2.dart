import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html;

import '../API/employee_report_sql2.dart';

Future<void> ExportExcel2() async {
  final employeeService2 = empoloyeecheckINSQL2();
  final data = await employeeService2.employeeReportCheckin(StartDate: DateTime.now(), endDate: DateTime.now(),from: 0,to: 9999);

  final excel = Excel.createExcel();
  final sheet = excel['Report-Checkin'];
  excel.delete('Sheet1');

  final Set<String> headerSet = {};
  for (final row in data) {
    headerSet.addAll(row.keys);
  }
  final List<String> headers = headerSet.toList();

  sheet.appendRow(headers.map((h) => TextCellValue(h)).toList());
  for (final row in data) {
    final List<CellValue?> rowCells = headers.map((key) {
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

  final fileName = 'Report-Checkin_${DateTime.now().toIso8601String()}.xlsx';
  final bytes = excel.encode();
  if (bytes == null) return;

  if (kIsWeb) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrl(blob);
    final anchor =
    html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  } else if (Platform.isAndroid ||
      Platform.isIOS ||
      Platform.isLinux ||
      Platform.isMacOS ||
      Platform.isWindows) {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, fileName);
    final file = File(path);
    await file.writeAsBytes(bytes);
  } else {
    Get.snackbar('Error', 'Unsupported platform');
  }
}


