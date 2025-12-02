import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/leave_record_controller.dart';

class DatePickerTeamLeave extends GetView<LeaveRecordController> {
  const DatePickerTeamLeave({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;

    ButtonStyle buttonStyle(Color color) {
      return ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(90, 32),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 12),
      );
    }

    Widget startDateButton() {
      return Obx(
        () => ElevatedButton.icon(
          style: buttonStyle(Colors.blue.shade900),
          icon: const Icon(
            EneftyIcons.calendar_3_bold,
            color: Colors.white,
            size: 14,
          ),
          label: Text(
            controller.selectedDateLeaveTeams.value != null
                ? controller.dateFormat.format(
                  controller.selectedDateLeaveTeams.value!,
                )
                : 'Start',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate:
                  controller.selectedDateLeaveTeams.value ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) controller.setStartDateLeaveTeam(picked);
          },
        ),
      );
    }

    Widget endDateButton() {
      return Obx(
        () => ElevatedButton.icon(
          style: buttonStyle(Colors.red.shade900),
          icon: const Icon(
            EneftyIcons.calendar_3_bold,
            color: Colors.white,
            size: 14,
          ),
          label: Text(
            controller.selectedEndDateLeaveTeams.value != null
                ? controller.dateFormat.format(
                  controller.selectedEndDateLeaveTeams.value!,
                )
                : 'End',
            style: const TextStyle(color: Colors.white, fontSize: 12),
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
            if (picked != null) controller.setEndDateLeaveTeam(picked);
          },
        ),
      );
    }

    Widget allButton() {
      return ElevatedButton(
        style: buttonStyle(Colors.green),
        onPressed: () => controller.fetchLeavesForAdmin(),
        child: const Text(
          'All',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      );
    }

    // --- LAYOUT ---
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [startDateButton(), endDateButton(), allButton()],
    );
  }
}
