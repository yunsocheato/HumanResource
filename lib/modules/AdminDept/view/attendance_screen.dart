import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/user_profile_controller.dart';
import '../../Admin/Drawer/views/drawer_screen.dart';
import '../Utils/date_picker_all_chart.dart';
import '../Utils/date_picker_attendance.dart';
import '../Utils/date_picker_chart_today.dart';
import '../Utils/dropdown_menu_chart_attendance.dart';
import '../controller/attendance_controller.dart';
import '../widget/attendance_chart_widget.dart';
import '../widget/attendance_widget.dart';
import '../widget/bottom_appbar_widget1.dart';
import '../widget/drawer_widget.dart';

class AttendanceUserScreen extends GetView<Attendancecontroller> {
  const AttendanceUserScreen({super.key});
  static const routeName = '/attendance_user';

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<UserProfileController>().userprofiles.value;
    final role = profile?.role ?? '';

    final screenContent = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 10,
            ),
            child: _buildResponsiveContent(),
          ),
        ],
      ),
    );

    final contents =
        (role == 'admin' || role == 'superadmin')
            ? Drawerscreen(content: screenContent)
            : DrawerAdmin(content: screenContent);

    final isMobile = MediaQuery.of(context).size.width < 600;
    return isMobile ? BottomAppBarWidget1(body: contents) : contents;
  }
}

Widget _buildResponsiveContent() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;

      if (width < 600) return _mobileLayout();
      if (width < 1024) return _tabletLayout();
      if (width < 1440) return _laptopLayout();
      if (width < 1920) return _desktopLayout();
      return _largeDesktopLayout();
    },
  );
}

Widget _mobileLayout() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      children: [
        const SizedBox(height: 25),
        Text(
          'ATTENDANCE RECORDS',
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        AttendanceChartWidget(),
        const SizedBox(height: 25),
        Text(
          'ATTENDANCE ANALYZE',
          style: TextStyle(
            color: Colors.green.shade900,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        AttendanceTablewidget(),
        const SizedBox(height: 30),
        _buildProfileSidebar(isMobile: true),
        const SizedBox(height: 40),
      ],
    ),
  );
}

Widget _tabletLayout() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'ATTENDANCE RECORDS',
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 14),
        DatePickerAttendance(),
        const SizedBox(height: 14),
        AttendanceTablewidget(),
        const SizedBox(height: 28),
        _buildProfileSidebar(isMobile: true),
        const SizedBox(height: 24),
      ],
    ),
  );
}

Widget _laptopLayout() {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'ATTENDANCE RECORDS',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue.shade900,
                  decorationThickness: 2,
                  wordSpacing: 2,
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 15),
              DatePickerAttendance(),
              const SizedBox(height: 15),
              AttendanceTablewidget(),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(flex: 1, child: _buildProfileSidebar(isMobile: false)),
      ],
    ),
  );
}

Widget _desktopLayout() {
  return Padding(
    padding: const EdgeInsets.all(36.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                'ATTENDANCE RECORDS',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue.shade900,
                  decorationThickness: 2,
                  wordSpacing: 2,
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              DatePickerAttendance(),
              const SizedBox(height: 20),
              AttendanceTablewidget(),
            ],
          ),
        ),
        const SizedBox(width: 30),
        Expanded(flex: 3, child: _buildProfileSidebar(isMobile: false)),
      ],
    ),
  );
}

Widget _largeDesktopLayout() {
  return Padding(
    padding: const EdgeInsets.all(48.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                'ATTENDANCE RECORDS',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue.shade900,
                  decorationThickness: 2,
                  wordSpacing: 2,
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 24),
              DatePickerAttendance(),
              const SizedBox(height: 20),
              AttendanceTablewidget(),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(flex: 3, child: _buildProfileSidebar(isMobile: false)),
      ],
    ),
  );
}

Widget _buildProfileSidebar({required bool isMobile}) {
  final double internalSpacing = isMobile ? 12.0 : 10.0;

  return Container(
    width: isMobile ? Get.width : null,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withOpacity(0.7),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ATTENDANCE ANALYZE',
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 18 : 20,
          ),
        ),
        SizedBox(height: 15),
        Wrap(
          runSpacing: internalSpacing,
          spacing: internalSpacing,
          children: [
            SizedBox(
              width: isMobile ? (Get.width - 30) / 2.2 : 90,
              height: 40,
              child: DatePickerChartToday(),
            ),
            SizedBox(width: internalSpacing),
            SizedBox(
              width: isMobile ? (Get.width - 30) / 2.2 : 90,
              height: 40,
              child: DatePickerAllDataChart(),
            ),
            SizedBox(width: internalSpacing),
            SizedBox(
              width: isMobile ? (Get.width - 60) / 1.3 : 140,
              height: 50,
              child: DropDownMenuChartPie(),
            ),
          ],
        ),
        const SizedBox(height: 18),
        AttendanceChartWidget(),
      ],
    ),
  );
}
