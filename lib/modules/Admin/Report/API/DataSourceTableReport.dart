import 'package:flutter/material.dart';
import '../Model/employee_checkin_model.dart';

class DataSourceTableReport extends DataTableSource {
  final List<EmployeeCheckinModel> data;

  DataSourceTableReport(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final user = data[index];
    return DataRow(
      cells: [
        DataCell(Text(user.id.toString() ?? '')),
        DataCell(Text(user.fingerprint_id.toString() ?? '')),
        DataCell(Text(user.username ?? '')),
        DataCell(Text(user.check_type ?? '')),
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
  DateTime toLocal() {
    return DateTime.parse(this).toLocal();
  }
}
