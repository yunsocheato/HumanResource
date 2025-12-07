import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/leave_record_controller.dart';

class DatePickerAllTeamLeaveToday extends GetView<LeaveRecordController> {
  const DatePickerAllTeamLeaveToday({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => controller.fetchLeavesForAdmin(),
      child: Text("All", style: TextStyle(color: Colors.white)),
    );
  }
}
