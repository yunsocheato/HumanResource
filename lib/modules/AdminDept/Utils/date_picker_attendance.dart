import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_controller.dart';

class DatePickerAttendance extends GetView<Attendancecontroller> {
  const DatePickerAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(EneftyIcons.calendar_3_bold, color: Colors.white),
          label: Obx(
            () => Text(
              controller.startDate.value == null
                  ? 'Start Date'
                  : '${controller.startDate.value!.day.toString().padLeft(2, '0')}/'
                      '${controller.startDate.value!.month.toString().padLeft(2, '0')}/'
                      '${controller.startDate.value!.year}',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: controller.startDate.value ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null) controller.setStartDate(picked);
          },
        ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(EneftyIcons.calendar_3_bold, color: Colors.white),
          label: Obx(
            () => Text(
              controller.endDate.value == null
                  ? 'End Date'
                  : '${controller.endDate.value!.day.toString().padLeft(2, '0')}/'
                      '${controller.endDate.value!.month.toString().padLeft(2, '0')}/'
                      '${controller.endDate.value!.year}',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: controller.endDate.value ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null) controller.setEndDate(picked);
          },
        ),
        SizedBox(width: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            controller.fetchAttendanceForLoggedInUser();
          },
          child: Text('All', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
