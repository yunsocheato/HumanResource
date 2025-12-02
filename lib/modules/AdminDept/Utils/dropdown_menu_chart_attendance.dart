import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_chart_controller.dart';

class DropDownMenuChartPie extends GetView<AttendanceChartController> {
  const DropDownMenuChartPie({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // --- Responsive breakpoints ---
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 900;
    final bool isLaptop = width >= 900 && width < 1200;
    final bool isDesktop = width >= 1200 && width < 1600;
    final bool isLargeDesktop = width >= 1600;

    double containerHeight =
        isMobile
            ? 40
            : isTablet
            ? 45
            : isLaptop
            ? 50
            : isDesktop
            ? 55
            : 60;

    double iconSize =
        isMobile
            ? 18
            : isTablet
            ? 20
            : isLaptop
            ? 22
            : isDesktop
            ? 24
            : 26;

    double fontSize =
        isMobile
            ? 12
            : isTablet
            ? 14
            : isLaptop
            ? 15
            : isDesktop
            ? 16
            : 17;

    double spacing =
        isMobile
            ? 6
            : isTablet
            ? 8
            : 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => Container(
            height: containerHeight,
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedRange.value,
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.blueAccent,
                  size: iconSize,
                ),
                borderRadius: BorderRadius.circular(12),
                dropdownColor: Colors.white,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                items:
                    controller.ranges
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Row(
                              children: [
                                Icon(
                                  EneftyIcons.calendar_2_bold,
                                  color: Colors.blue.shade700,
                                  size: iconSize,
                                ),
                                SizedBox(width: spacing),
                                Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.setRange(value);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
