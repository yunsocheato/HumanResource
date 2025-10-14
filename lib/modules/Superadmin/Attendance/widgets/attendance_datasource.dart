import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/attendance_model.dart';

class MyDataSource extends DataTableSource {
  final List<AttendanceModel> data;

  MyDataSource(this.data);

  @override
  DataRow getRow(int index) {
    final row = data[index];
    return DataRow(cells: [
      DataCell(Center(child: Text(row.username))),
      DataCell(Center(child: Text(DateFormat('yyyy-MM-dd HH:mm').format(row.clockIn)))),
      DataCell(Center(child: Text(row.checkType))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length;
  @override
  int get selectedRowCount => 0;
}
