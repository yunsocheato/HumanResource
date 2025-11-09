import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Utils/date_picker_leave.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_controller.dart';
import 'package:hrms/modules/AdminDept/widget/overview_card.dart';
import 'package:hrms/modules/AdminDept/widget/team_leave_request_widget.dart';
import '../../../Utils/Loadingui/Loading_skeleton.dart';
import '../Utils/date_picker_all_chart.dart';
import '../Utils/date_picker_attendance.dart';
import '../Utils/date_picker_chart_today.dart';
import '../Utils/dropdown_menu_chart_attendance.dart';
import '../Utils/dropdown_menu_leave_chart.dart';
import '../controller/manageuser_controller.dart';
import '../controller/overview_controller.dart';
import 'attendance_chart_widget.dart';
import 'attendance_widget.dart';
import 'leave_card_balance_sidebar.dart';
import 'leave_chart_widget.dart';
import 'leave_record_widget.dart';
import 'overview_card_pageview.dart';

class OverViewWidget extends GetView<OverViewController> {
  const OverViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobileGlobal = Get.width < 900;
    final padding = EdgeInsets.all(isMobileGlobal ? 16.0 : 32.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isMobile = width < 900;
        final isTablet = width >= 900 && width < 1200;
        final isDesktop = width >= 1200 && width < 1440;
        final isLaptop = width >= 1440;

        const double mobileFontSize = 15.0;
        const double tabletFontSize = 15.0;
        const double desktopFontSize = 20.0;
        const double laptopFontSize = 15.0;

        final double fontSize =
            isMobile
                ? mobileFontSize
                : isTablet
                ? tabletFontSize
                : isDesktop
                ? desktopFontSize
                : isLaptop
                ? laptopFontSize
                : mobileFontSize;

        if (isMobile) {
          Get.put(Attendancecontroller());
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'DASHBOARD',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const Gridoverviewoverview(),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    PageOverviewScreen(),
                    const SizedBox(height: 25),
                    _buildProfileSidebar(),
                    const SizedBox(height: 25),
                    _sectionTitle('YOUR LEAVE RECORD', fontSize),
                    DatePickerLeave(),
                    LeaveRequestTablewidget(),
                    const SizedBox(height: 20),
                    TeamRequestLeaveResponsiveWidget(),
                    const SizedBox(height: 20),
                    _sectionTitle('YOUR ATTENDANCE RECORDS', fontSize),
                    DatePickerAttendance(),
                    const SizedBox(height: 10),
                    AttendanceTablewidget(),
                  ],
                ),
              ],
            ),
          );
        }
        double maxTableWidth;
        Get.put(Attendancecontroller());

        if (width < 1024) {
          maxTableWidth = width * 0.62;
        } else if (width < 1440) {
          maxTableWidth = width * 0.72;
        } else {
          maxTableWidth = width * 0.78;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.vertical,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              SizedBox(
                width: maxTableWidth,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.topLeft,
                          child: PageOverviewScreen(),
                        ),
                        const SizedBox(height: 20),
                        _sectionTitle('DASHBOARD', fontSize),
                        const SizedBox(height: 15),
                        const Gridoverviewoverview(),
                        const SizedBox(height: 35),
                        _sectionTitle('YOUR LEAVE RECORDS', fontSize),
                        const SizedBox(height: 15),
                        DatePickerLeave(),
                        const SizedBox(height: 15),
                        const LeaveRequestTablewidget(),
                        const SizedBox(height: 35),
                        TeamRequestLeaveResponsiveWidget(),
                        const SizedBox(height: 35),
                        _sectionTitle('YOUR ATTENDANCE RECORDS', fontSize),
                        const SizedBox(height: 8),
                        DatePickerAttendance(),
                        const SizedBox(height: 10),
                        AttendanceTablewidget(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildProfileSidebar(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileSidebar() {
    const double mobileFont = 15;
    const double tabletFont = 15;
    const double desktopFont = 23;
    const double laptopFont = 15;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        final bool isMobile = maxWidth < 900;
        final bool isTablet = maxWidth >= 900 && maxWidth < 1200;
        final bool isDesktop = maxWidth >= 1200 && maxWidth < 1440;
        final bool isLaptop = maxWidth >= 1440;

        final double sidebarWidth = isMobile ? maxWidth : 300.0;

        final double fontSize =
            isMobile
                ? mobileFont
                : isTablet
                ? tabletFont
                : isDesktop
                ? desktopFont
                : isLaptop
                ? laptopFont
                : mobileFont;

        List<Widget> sections = [
          _sectionTitle('LEAVE BALANCE', fontSize),
          const SizedBox(height: 10),
          const GridoverviewLeavebalance(),
          const SizedBox(height: 20),
          _sectionTitle('MANAGE USER', fontSize),
          const SizedBox(height: 15),
          _buildTeamSidebar2(),
          const SizedBox(height: 20),
          _sectionTitle('TEAM MEMBER', fontSize),
          const SizedBox(height: 15),
          _buildTeamSidebar1(),
          const SizedBox(height: 20),
          _sectionTitle('ATTENDANCE COUNTS', fontSize),
          const SizedBox(height: 8),
        ];

        if (isMobile || isTablet) {
          sections.add(
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DropDownMenuChartPie(),
                  const SizedBox(width: 10),
                  DatePickerChartToday(),
                  const SizedBox(width: 10),
                  DatePickerAllDataChart(),
                ],
              ),
            ),
          );
          sections.add(const SizedBox(height: 8));
        } else {
          sections.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropDownMenuChartPie(),
                const SizedBox(height: 8),
                DatePickerChartToday(),
                const SizedBox(height: 8),
                DatePickerAllDataChart(),
              ],
            ),
          );
        }

        sections.add(AttendanceChartWidget());
        sections.add(const SizedBox(height: 20));
        sections.add(_sectionTitle('LEAVE ANALYZES', fontSize));
        sections.add(const SizedBox(height: 8));
        if (isMobile || isTablet) {
          sections.add(
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [DropDownMenuLeaveChart()]),
            ),
          );
        } else {
          sections.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [DropDownMenuLeaveChart()],
            ),
          );
        }
        sections.add(const SizedBox(height: 8));
        sections.add(LeaveChartWidget());

        if (isMobile || isTablet) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections,
            ),
          );
        }
        return Container(
          width: sidebarWidth,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeamSidebar1() {
    double MobilefontSize = 13.0;
    double LaptopfontSize = 15.0;
    double TabletfontSize = 15.0;
    double DesktopfontSize = 23.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        final isTablet =
            constraints.maxWidth >= 900 && constraints.maxWidth < 1200;
        final isDesktop =
            constraints.maxWidth >= 1200 && constraints.maxWidth < 1440;
        final isLaptop = constraints.maxWidth >= 1440;
        final sidebarWidth = isMobile ? constraints.maxWidth : 300.0;

        double fontSize =
            isMobile
                ? MobilefontSize
                : isTablet
                ? TabletfontSize
                : isDesktop
                ? DesktopfontSize
                : isLaptop
                ? LaptopfontSize
                : MobilefontSize;

        return Container(
          width: sidebarWidth,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 15,
              children: [
                _memberCard("Alice", "Developer"),
                _memberCard("Bob", "Designer"),
                _memberCard("Clara", "Admin"),
                _memberCard("Sarah", "IT"),
                _memberCard("Mike", "Head"),
                _memberCard("Charlie", "HR"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeamSidebar2() {
    double mobileFontSize = 13.0;
    double tabletFontSize = 15.0;
    double desktopFontSize = 23.0;
    double laptopFontSize = 15.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        final isTablet =
            constraints.maxWidth >= 900 && constraints.maxWidth < 1200;
        final isDesktop =
            constraints.maxWidth >= 1200 && constraints.maxWidth < 1440;
        final isLaptop = constraints.maxWidth >= 1440;

        final sidebarWidth = isMobile ? constraints.maxWidth : 300.0;
        final fontSize =
            isMobile
                ? mobileFontSize
                : isTablet
                ? tabletFontSize
                : isDesktop
                ? desktopFontSize
                : laptopFontSize;

        return Container(
          width: sidebarWidth,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: _ManageByList(fontSize: fontSize),
        );
      },
    );
  }

  Widget _ManageByList({required double fontSize}) {
    final controller1 = Get.find<ManageUserController>();

    return Obx(() {
      if (controller1.isLoading.value) {
        return Center(child: Skeletonlines());
      }

      if (controller1.userdata.isEmpty) {
        return const Center(child: Text('No users found'));
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller1.userdata.length,
        itemBuilder: (context, index) {
          final user = controller1.userdata[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade700,
              child: Text(
                user.Name.isNotEmpty ? user.Name[0].toUpperCase() : '?',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              user.Name,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manager Name: ${user.ManageByname.isNotEmpty ? user.ManageByname : 'No manager'}',
                  style: TextStyle(
                    fontSize: fontSize - 2,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Head Department: ${user.HeadName.isNotEmpty ? user.HeadName : 'No head department'}',
                  style: TextStyle(
                    fontSize: fontSize - 2,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _memberCard(String name, String role) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.blue,
          child: Icon(EneftyIcons.user_bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        Text(role, style: const TextStyle(color: Colors.black54, fontSize: 11)),
      ],
    );
  }

  Widget _sectionTitle(String text, double fontSize) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}
