import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_chart_controller.dart';

class DatePickerChartToday extends GetView<AttendanceChartController> {
  const DatePickerChartToday({super.key});

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
            ? 44
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
            : 17;

    double horizontalPadding =
        isMobile
            ? 12
            : isTablet
            ? 12
            : isLaptop
            ? 12
            : isDesktop
            ? 12
            : 28;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue.shade900,
        minimumSize: Size(horizontalPadding * 3, btnHeight),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => controller.fetchTodayChart(),
      child: Text(
        'Today',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
