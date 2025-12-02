import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_chart_controller.dart';

class DatePickerAllDataChart extends GetView<AttendanceChartController> {
  const DatePickerAllDataChart({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 900;
    final bool isLaptop = width >= 900 && width < 1200;
    final bool isDesktop = width >= 1200 && width < 1600;
    final bool isLargeDesktop = width >= 1600;

    double btnHeight =
        isMobile
            ? 36
            : isTablet
            ? 36
            : isLaptop
            ? 36
            : isDesktop
            ? 48
            : 52;

    double fontSize =
        isMobile
            ? 12
            : isTablet
            ? 12
            : isLaptop
            ? 12
            : isDesktop
            ? 12
            : 12;

    double horizontalPadding =
        isMobile
            ? 12
            : isTablet
            ? 16
            : isLaptop
            ? 20
            : isDesktop
            ? 12
            : 28;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: Size(horizontalPadding * 3, btnHeight),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => controller.fetchAttendanceAllData(),
      child: Text(
        "All",
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
