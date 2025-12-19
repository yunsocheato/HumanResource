import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/user_profile_controller.dart';
import '../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Admin/Drawer/views/drawer_screen.dart';
import '../Utils/date_picker_all_chart.dart';
import '../Utils/date_picker_attendance.dart';
import '../Utils/date_picker_chart_today.dart';
import '../Utils/dropdown_menu_chart_attendance.dart';
import '../controller/attendance_controller.dart';
import '../widget/attendance_chart_widget.dart';
import '../widget/attendance_widget.dart';
import '../widget/bottom_appbar_widget1.dart';
import '../widget/drawer_header_widget.dart';
import '../widget/drawer_widget.dart';

class AttendanceUserScreen extends GetView<Attendancecontroller> {
  const AttendanceUserScreen({super.key});
  static const routeName = '/attendance_user';

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<UserProfileController>();

    return Obx(() {
      final profile = profileController.userprofiles.value;

      if (profile == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final role = profile.role.toLowerCase();
      final isMobile = Get.width < 900;

      final bool isAdmin = role == 'admin' || role == 'superadmin';
      final bool isUserSide = role == 'admindept' || role == 'user';

      final contents =
          isAdmin
              ? Drawerscreen(
                content: SingleChildScrollView(
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

      if (isMobile) {
        return isAdmin
            ? BottomAppBarWidget(body: contents)
            : BottomAppBarWidget1(body: contents);
      } else {
        return contents;
      }
    });
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
  final profileController = Get.find<UserProfileController>();
  final profile = profileController.userprofiles.value;

  if (profile == null) {
    return const Center(child: CircularProgressIndicator());
  }

  final role = profile.role.toLowerCase();
  final bool isAdmin = role == 'admin' || role == 'superadmin';

  final size = MediaQuery.of(Get.context!).size;
  final bottomBarHeight = kBottomNavigationBarHeight;

  return SizedBox(
    height: size.height,
    width: size.width,
    child: Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade900, Colors.blue.shade300],
            ),
          ),
        ),

        Positioned(
          top: -30,
          right: -60,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),

        if (!isAdmin)
          Positioned(top: 20, left: 0, right: 0, child: DrawerHead()),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: size.height * 0.85,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  top: 40,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: bottomBarHeight + 12,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.offAllNamed('/overview');
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Back',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'MY ATTENDANCE',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue.shade900,
                                    decorationThickness: 2,
                                    wordSpacing: 2,
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: '7TH.ttf',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          Text(
                            'ATTENDANCE ANALYZE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AttendanceChartWidget(),
                          const SizedBox(height: 55),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ATTENDANCE RECORDS',
                                style: TextStyle(
                                  color: Colors.green.shade900,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 12),
                              DatePickerAttendance(),
                            ],
                          ),
                          const SizedBox(height: 12),
                          AttendanceTablewidget(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Image.asset('assets/icon/calendars.png', width: 30, height: 30),
              const SizedBox(width: 12),
              Text(
                'My Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: '7TH.ttf',
                  color: Colors.blue.shade900,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue.shade900,
                  decorationThickness: 2,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 50),
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
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon/calendars.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'My Attendance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: '7TH.ttf',
                        color: Colors.blue.shade900,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue.shade900,
                        decorationThickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              DatePickerAttendance(),
              const SizedBox(height: 15),
              AttendanceTablewidget(),
            ],
          ),
        ),

        const SizedBox(height: 30, width: 20),
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
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon/calendars.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'My Attendance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: '7TH.ttf',
                        color: Colors.blue.shade900,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue.shade900,
                        decorationThickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              DatePickerAttendance(),
              const SizedBox(height: 20),
              AttendanceTablewidget(),
            ],
          ),
        ),
        const SizedBox(height: 30, width: 20),
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
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon/calendars.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'My Attendance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: '7TH.ttf',
                        color: Colors.blue.shade900,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue.shade900,
                        decorationThickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              DatePickerAttendance(),
              const SizedBox(height: 20),
              AttendanceTablewidget(),
            ],
          ),
        ),
        const SizedBox(height: 30, width: 20),
        Expanded(flex: 3, child: _buildProfileSidebar(isMobile: false)),
      ],
    ),
  );
}

Widget _buildProfileSidebar({required bool isMobile}) {
  final double internalSpacing = isMobile ? 12.0 : 10.0;

  return Container(
    width: isMobile ? Get.width : null,
    padding: const EdgeInsets.all(12.0),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'ATTENDANCE ANALYZE',
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 15 : 18,
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
              height: 65,
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
