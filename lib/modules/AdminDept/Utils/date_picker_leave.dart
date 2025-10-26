import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/leave_record_controller.dart';

class DatePickerLeave extends GetView<LeaveRecordController> {
  const DatePickerLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade900,
            ),
            icon: Icon(EneftyIcons.calendar_3_bold, color: Colors.white),
            label: Text(
              style: TextStyle(color: Colors.white),
              controller.selectedDate.value != null
                  ? 'From: ${controller.dateFormat.format(controller.selectedDate.value!)}'
                  : 'StartDate',
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: controller.selectedDate.value ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                controller.setStartDate(picked);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Obx(
          () => ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade900,
            ),
            icon: Icon(EneftyIcons.calendar_3_bold, color: Colors.white),
            label: Text(
              style: TextStyle(color: Colors.white),
              controller.selectedEndDate.value != null
                  ? 'To: ${controller.dateFormat.format(controller.selectedEndDate.value!)}'
                  : 'EndDate',
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate:
                    controller.selectedEndDate.value ??
                    controller.selectedDate.value ??
                    DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                controller.setEndDate(picked);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            controller.getLeaves();
          },
          child: Text('All', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
