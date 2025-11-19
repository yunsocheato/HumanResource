import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    final isMobile = Get.width < 600;

    final contents =
        (role == 'admin' || role == 'superadmin')
            ? Drawerscreen(
              content: SingleChildScrollView(
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
              ),
            )
            : DrawerAdmin(
              content: SingleChildScrollView(
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
              ),
            );
    return isMobile ? BottomAppBarWidget1(body: contents) : contents;
  }
}

Widget _buildResponsiveContent() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return isMobile ? _buildMobileContent() : _buildDesktopTabletContent();
    },
  );
}

Widget _buildMobileContent() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        SizedBox(height: 25),
        Text(
          'ATTENDANCE RECORDS',
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        AttendanceChartWidget(),
        SizedBox(height: 25),
        Text(
          'ATTENDANCE ANALYZE',
          style: TextStyle(
            color: Colors.green.shade900,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        AttendanceTablewidget(),
      ],
    ),
  );
}

Widget _buildDesktopTabletContent() {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              SizedBox(height: 50),
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
              ),
              SizedBox(height: 15),
              DatePickerAttendance(),
              SizedBox(height: 15),
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

Widget _buildProfileSidebar({required bool isMobile}) {
  return Container(
    width: isMobile ? Get.width : null,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    ),
    child: Column(
      children: [
        SizedBox(height: 50),
        Text(
          'ATTENDANCE ANALYZE',
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropDownMenuChartPie(),
            const SizedBox(width: 10),
            DatePickerChartToday(),
            const SizedBox(width: 10),
            DatePickerAllDataChart(),
          ],
        ),
        AttendanceChartWidget(),
      ],
    ),
  );
}
