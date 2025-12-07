import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'dart:typed_data';
import '../API/employee_report_sql1.dart';

Future<void> ExportExcel1() async {
  final employeeService = empoloyeecheckINSQL();
  final data = await employeeService.employeeReportCheckin(
    StartDate: DateTime.now(),
    endDate: DateTime.now(),
    from: 0,
    to: 10000,
  );

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

  String fileName = 'Report-Checkin${DateTime.now().toIso8601String()}.xlsx';
  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: Uint8List.fromList(fileBytes),
      mimeType: MimeType.microsoftExcel,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx(
        'Success',
        'Exported File $fileName',
        ContentType.success,
      );
    });
  } else {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx(
        'Error',
        'Failed to Generate File $fileName.xls',
        ContentType.failure,
      );
    });
  }
}
