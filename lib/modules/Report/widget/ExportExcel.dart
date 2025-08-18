import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import '../API/employee_report_sql.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:html' as html;

Future<void> ExportExcel() async {
  final employeeService = empoloyeecheckINSQL();
  final data = await employeeService.employeeReportCheckin();

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
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  } else {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, fileName);
    final file = File(path);
    await file.writeAsBytes(bytes);
  }


}


