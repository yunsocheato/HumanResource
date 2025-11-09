import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/leave_record_controller.dart';

class DatePickerTeamLeave extends GetView<LeaveRecordController> {
  const DatePickerTeamLeave({super.key});

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
              controller.selectedDateLeaveTeams.value != null
                  ? 'From: ${controller.dateFormat.format(controller.selectedDateLeaveTeams.value!)}'
                  : 'StartDate',
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate:
                    controller.selectedDateLeaveTeams.value ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                controller.setStartDateLeaveTeam(picked);
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
              controller.selectedEndDateLeaveTeams.value != null
                  ? 'To: ${controller.dateFormat.format(controller.selectedEndDateLeaveTeams.value!)}'
                  : 'EndDate',
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate:
                    controller.selectedEndDateLeaveTeams.value ??
                    controller.selectedDateLeaveTeams.value ??
                    DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                controller.setEndDateLeaveTeam(picked);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            controller.fetchLeavesForAdmin();
          },
          child: Text('All', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
