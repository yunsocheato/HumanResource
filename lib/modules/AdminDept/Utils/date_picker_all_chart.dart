import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_chart_controller.dart';

class DatePickerAllDataChart extends GetView<AttendanceChartController> {
  const DatePickerAllDataChart({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => controller.fetchAttendanceAllData(),
      child: Text("All", style: TextStyle(color: Colors.white)),
    );
  }
}
