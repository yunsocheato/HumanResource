import 'package:flutter/material.dart';
import '../Model/employee_leave_summary_model.dart';

class DataSourceTableReportSummary extends DataTableSource {
  final List<EmployeeLeaveSummaryModel> data;

  DataSourceTableReportSummary(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final user = data[index];
    return DataRow(cells: [
      DataCell(Text(user.staff_id.toString() ?? '')),
      DataCell(Text(user.name.toString() ?? '')),
      DataCell(Text(user.department ?? '')),
      DataCell(Text(user.position ?? '')),
      DataCell(Text(user.request_type ?? '')),
      DataCell(Text('${user.leave_count.toString() ?? 0.0} times')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

extension on String {
  toLocal() {
    return DateTime.parse(this).toLocal();
  }
}
