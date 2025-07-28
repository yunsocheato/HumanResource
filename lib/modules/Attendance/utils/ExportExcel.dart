import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:path/path.dart';
import '../API/attendance_stream_api_sql.dart';

Future<Center> exportToExcel({required RxList<Map<String, dynamic>> attendaData}) async {
  final data = await getAttendanceData(limit: 500, page: 0, offset: 0 );

  final excel = Excel.createExcel();
  final sheet = excel['Attendance'];
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

  String fileName = 'Attendance${DateTime.now().toIso8601String()}.xlsx';
  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    File(join(Directory.current.path, fileName))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);

    return Center(child: Text('Excel exported: $fileName'));
  } else {
    return Center(child: Text('cannot exported: $fileName'));
  }
}


