import 'package:flutter/material.dart';

import '../Model/employee_OT_model.dart';

class DataTableReportOT extends DataTableSource{
  final List<EmployeeOTModel> data;
  DataTableReportOT(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final employee = data[index];
    return DataRow(cells: [
      DataCell(Text(employee.staff_id ?? '')),
      DataCell(Text(employee.staff_name ?? '')),
      DataCell(Text(employee.start_date.toLocal().toString().split(' ')[0] ?? '')),
      DataCell(Text(employee.time_start ?? '')),
      DataCell(Text(employee.end_date.toLocal().toString().split(' ')[0] ?? '')),
      DataCell(Text(employee.end_time ?? '')),
      DataCell(Text(employee.reason ?? '')),
      DataCell(Text(
        employee.created_at != null
            ? employee.created_at!.toLocal().toString().split(' ')[0]
            : '',
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false ;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount =>  0 ;

}