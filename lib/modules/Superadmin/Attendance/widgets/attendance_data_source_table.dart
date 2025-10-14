import 'package:flutter/material.dart';

class DataTableSourceAttendance extends DataTableSource {
  final List<Map<String, dynamic>> data;

  DataTableSourceAttendance(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;

    final row = data[index];
    return DataRow(cells: [
      DataCell(Text(row['log_id'].toString())),
      DataCell(Text(row['fingerprint_id'].toString())),
      DataCell(Text(row['name'] ?? '')),
      DataCell(Text(row['timestamp'].toString())),
      DataCell(Text(row['check_type'] ?? '')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
