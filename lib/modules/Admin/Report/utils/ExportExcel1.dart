import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:hrms/modules/Admin/Report/API/employee_report_sql1.dart';

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

  final headers = <String>{};
  for (final row in data) {
    headers.addAll(row.keys);
  }
  final headerList = headers.toList();

  sheet.appendRow(headerList.map((e) => TextCellValue(e)).toList());

  for (final row in data) {
    sheet.appendRow(
      headerList.map((key) {
        final value = row[key];
        if (value == null) return TextCellValue('');
        if (value is int) return IntCellValue(value);
        if (value is double) return DoubleCellValue(value);
        if (value is DateTime) {
          return DateTimeCellValue.fromDateTime(value);
        }
        return TextCellValue(value.toString());
      }).toList(),
    );
  }

  final timestamp = DateTime.now().toString().replaceAll(RegExp(r'[:.]'), '-');

  final fileName = 'Report-Checkin-$timestamp';

  final fileBytes = excel.save();

  if (fileBytes == null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx(
        'Error',
        'Failed to generate Excel file',
        ContentType.failure,
      );
    });
    return;
  }

  await FileSaver.instance.saveFile(
    name: fileName,
    bytes: Uint8List.fromList(fileBytes),
    fileExtension: 'xlsx',
    mimeType: MimeType.microsoftExcel,
  );

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showAwesomeSnackBarGetx(
      'Success',
      kIsWeb ? 'File downloaded' : 'File saved successfully',
      ContentType.success,
    );
  });
}
