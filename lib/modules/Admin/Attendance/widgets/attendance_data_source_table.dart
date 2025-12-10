import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataTableSourceAttendance extends DataTableSource {
  final List<Map<String, dynamic>> data;

  DataTableSourceAttendance(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;

    final row = data[index];
    return DataRow(
      cells: [
        DataCell(Text(row['fingerprint_id'].toString())),
        DataCell(Text(row['username'] ?? 'No Name')),
        DataCell(Text(row['check_type'].toString())),
        DataCell(
          Text(
            row['timestamp'] != null
                ? formatDate(row['timestamp'])
                : 'No clock',
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  String formatDate(String timestamp) {
    final date = DateTime.parse(timestamp).toLocal();
    final formatter = DateFormat('hh:mm a dd.MM.yyyy');
    return formatter.format(date);
  }
}
