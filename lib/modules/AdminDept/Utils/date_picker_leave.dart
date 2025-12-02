import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/leave_record_controller.dart';

class DatePickerLeave extends GetView<LeaveRecordController> {
  const DatePickerLeave({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;

    ButtonStyle baseStyle(Color color) {
      return ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(isMobile ? 80 : 100, 34),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 10,
          vertical: 6,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      );
    }

    return Row(
      children: [
        _startDateButton(baseStyle),
        const SizedBox(width: 8),
        _endDateButton(baseStyle),
        const SizedBox(width: 8),
        _allButton(baseStyle),
      ],
    );
  }

  Widget _startDateButton(ButtonStyle Function(Color) styleFn) {
    return Obx(
      () => ElevatedButton.icon(
        style: styleFn(Colors.blue.shade900),
        icon: const Icon(
          EneftyIcons.calendar_3_bold,
          color: Colors.white,
          size: 16,
        ),
        label: Text(
          controller.selectedDate.value != null
              ? controller.dateFormat.format(controller.selectedDate.value!)
              : 'Start',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ), // small text
        ),
        onPressed: () async {
          final picked = await showDatePicker(
            context: Get.context!,
            initialDate: controller.selectedDate.value ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (picked != null) controller.setStartDate(picked);
        },
      ),
    );
  }

  Widget _endDateButton(ButtonStyle Function(Color) styleFn) {
    return Obx(
      () => ElevatedButton.icon(
        style: styleFn(Colors.red.shade900),
        icon: const Icon(
          EneftyIcons.calendar_3_bold,
          color: Colors.white,
          size: 16,
        ),
        label: Text(
          controller.selectedEndDate.value != null
              ? controller.dateFormat.format(controller.selectedEndDate.value!)
              : 'End',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        onPressed: () async {
          final picked = await showDatePicker(
            context: Get.context!,
            initialDate:
                controller.selectedEndDate.value ??
                controller.selectedDate.value ??
                DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (picked != null) controller.setEndDate(picked);
        },
      ),
    );
  }

  Widget _allButton(ButtonStyle Function(Color) styleFn) {
    return ElevatedButton(
      style: styleFn(Colors.green),
      onPressed: () => controller.getLeaves(),
      child: const Text(
        'All',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
