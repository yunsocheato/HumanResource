import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_controller.dart';

class DatePickerAttendance extends GetView<Attendancecontroller> {
  const DatePickerAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Get.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 900;

    double spacing = isMobile ? 6 : 12;

    // 🔥 Short button padding
    double padH = isMobile ? 10 : 14;
    double padV = isMobile ? 6 : 8;

    double fontSize = isMobile ? 11 : 13;
    double iconSize = isMobile ? 16 : 18;

    Widget startBtn = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade900,
        padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
        minimumSize: Size(0, 36), // 🔥 short height
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: Icon(
        EneftyIcons.calendar_3_bold,
        color: Colors.white,
        size: iconSize,
      ),
      label: Obx(
        () => Text(
          controller.startDate.value == null
              ? 'Start'
              : "${controller.startDate.value!.day}/${controller.startDate.value!.month}/${controller.startDate.value!.year}",
          style: TextStyle(color: Colors.white, fontSize: fontSize),
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
    );

    Widget endBtn = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
        minimumSize: Size(0, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: Icon(
        EneftyIcons.calendar_3_bold,
        color: Colors.white,
        size: iconSize,
      ),
      label: Obx(
        () => Text(
          controller.endDate.value == null
              ? 'End'
              : "${controller.endDate.value!.day}/${controller.endDate.value!.month}/${controller.endDate.value!.year}",
          style: TextStyle(color: Colors.white, fontSize: fontSize),
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
    );

    Widget allBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
        minimumSize: Size(0, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => controller.fetchAttendanceForLoggedInUser(),
      child: Text(
        "All",
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );

    if (isMobile) {
      return Row(
        spacing: 5,
        children: [
          startBtn,
          SizedBox(height: spacing),
          endBtn,
          SizedBox(height: spacing),
          allBtn,
        ],
      );
    }
    return Row(
      children: [
        startBtn,
        SizedBox(width: spacing),
        endBtn,
        SizedBox(width: spacing),
        allBtn,
      ],
    );
  }
}
