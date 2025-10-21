import 'package:flutter/material.dart';
import '../Model/employee_absent_model.dart';

class DataSourceTableReportAbsent extends DataTableSource {
  final List<EmployeeAbsentModel> data;

  DataSourceTableReportAbsent(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final user = data[index];
    return DataRow(
      cells: [
        DataCell(Text(user.staff_id ?? '')),
        DataCell(Text(user.staff_name ?? '')),
        DataCell(Text(user.position ?? '')),
        DataCell(Text(user.department ?? '')),
        DataCell(
          Text(user.absent_date.toLocal().toString().split(' ')[0] ?? ''),
        ),
        DataCell(Text(user.reason ?? '')),
        DataCell(
          Text(
            user.created_at != null
                ? user.created_at!.toLocal().toString().split(' ')[0]
                : '',
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
}

extension on String {
  toLocal() {
    return DateTime.parse(this).toLocal();
  }
}
