import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Utils/date_picker_leave.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_controller.dart';
import 'package:hrms/modules/AdminDept/widget/overview_card.dart';
import 'package:hrms/modules/AdminDept/widget/team_leave_request_widget.dart';
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
    final padding = EdgeInsets.all(isMobileGlobal ? 16.0 : 24.0);

    return RefreshIndicator(
      color: Colors.blue.shade900,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: LayoutBuilder(
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
                  const SizedBox(height: 25),
                  PageOverviewScreen(),
                  const SizedBox(height: 25),
                  _buildProfileSidebar(),
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
                          const SizedBox(height: 35),
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
                  flex: 1,
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
      ),
    );
  }

  Widget _buildProfileSidebar() {
    const double mobileFont = 15;
    const double tabletFont = 15;
    const double desktopFont = 15;
    const double laptopFont = 15;

    final double screenWidth = Get.width;

    final bool isMobile = screenWidth < 900;
    final bool isTablet = screenWidth >= 900 && screenWidth < 1200;
    final bool isDesktop = screenWidth >= 1200 && screenWidth < 1440;
    final bool isLaptop = screenWidth >= 1440;

    final double sidebarWidth = isMobile ? screenWidth : 450.0;
    final double sidebarHeight =
        isMobile ? 500.0 : MediaQuery.of(Get.context!).size.height * 1.95;

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

    List<Widget> baseSections = [
      _sectionTitle('LEAVE BALANCE', fontSize),
      const SizedBox(height: 10),
      const GridoverviewLeavebalance(),
      const SizedBox(height: 20),
    ];

    if (isMobile || isTablet) {
      final sections = List<Widget>.from(baseSections)..addAll([
        _sectionTitle('MANAGEMENT LIST', fontSize),
        const SizedBox(height: 15),
        _pageviewMangementList(),
        const SizedBox(height: 20),
      ]);

      return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sections,
        ),
      );
    }

    final sections = List<Widget>.from(baseSections)..addAll([
      _sectionTitle('MANAGE USER', fontSize),
      const SizedBox(height: 15),
      _buildTeamSidebar2(),
      const SizedBox(height: 20),
      // _sectionTitle('TEAM MEMBER', fontSize),
      // const SizedBox(height: 15),
      // _buildTeamSidebar1(),
      // const SizedBox(height: 20),
      _sectionTitle('ATTENDANCE ANALYZE', fontSize),
      const SizedBox(height: 8),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            DropDownMenuChartPie(),
            const SizedBox(width: 5),
            DatePickerChartToday(),
            const SizedBox(width: 5),
            DatePickerAllDataChart(),
            const SizedBox(width: 5),
          ],
        ),
      ),
      const SizedBox(height: 8),
      AttendanceChartWidget(),
      const SizedBox(height: 20),
      _sectionTitle('LEAVE ANALYZES', fontSize),
      const SizedBox(height: 8),
      DropDownMenuLeaveChart(),
      const SizedBox(height: 8),
      LeaveChartWidget(),
    ]);

    return Container(
      width: sidebarWidth,
      height: sidebarHeight,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sections,
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Clock-in/Late',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      DatePickerAttendance(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                AttendanceTablewidget(),
              ],
            ),
          ),
        );

      case 1:
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LEAVE REQUEST',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      DatePickerLeave(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                LeaveRequestTablewidget(),
              ],
            ),
          ),
        );

      case 2:
        return TeamRequestLeaveResponsiveWidget();
      case 3:
        return _buildTeamSidebar2();
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            DropDownMenuLeaveChart(),
            SizedBox(height: 15),
            LeaveChartWidget(),
          ],
        );
      case 5:
        return Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropDownMenuChartPie(),
                SizedBox(width: 13),
                DatePickerChartToday(),
                SizedBox(width: 13),
                DatePickerAllDataChart(),
              ],
            ),
            SizedBox(height: 15),
            AttendanceChartWidget(),
          ],
        );

      default:
        return const Center(child: Text("No page found"));
    }
  }

  Widget _pageviewMangementList() {
    final isMobile = Get.width < 600;
    return Column(
      children: [
        Obx(() {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment:
                  isMobile
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.start,
              children: List.generate(controller.managelist.length, (index) {
                final selected = controller.isSelectedindex.value == index;
                return GestureDetector(
                  onTap: () {
                    controller.SelectedIndex(index);
                    controller.pageController1.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: controller
                        .boxDecoration(index)
                        .copyWith(
                          color:
                              selected
                                  ? Colors.blue.shade900
                                  : Colors.transparent,
                        ),
                    child: Text(
                      controller.managelist[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.iconColor(index),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
        SizedBox(
          height: 450,
          child: PageView.builder(
            controller: controller.pageController1,
            itemCount: controller.managelist.length,
            onPageChanged: (index) => controller.SelectedIndex(index),
            itemBuilder: (_, index) {
              return _buildPage(index);
            },
          ),
        ),
      ],
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
    const double mobileFontSize = 13.0;
    const double tabletFontSize = 15.0;
    const double laptopFontSize = 17.0;
    const double desktopFontSize = 20.0;
    const double largeDesktopFontSize = 23.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final bool isMobile = width < 600;
        final bool isTablet = width >= 600 && width < 900;
        final bool isLaptop = width >= 900 && width < 1200;
        final bool isDesktop = width >= 1200 && width < 1600;
        final bool isLargeDesktop = width >= 1600;

        double sidebarWidth;
        double fontSize;

        if (isMobile) {
          sidebarWidth = width;
          fontSize = mobileFontSize;
        } else if (isTablet) {
          sidebarWidth = 120;
          fontSize = tabletFontSize;
        } else if (isLaptop) {
          sidebarWidth = 140;
          fontSize = laptopFontSize;
        } else if (isDesktop) {
          sidebarWidth = 160;
          fontSize = desktopFontSize;
        } else {
          sidebarWidth = 200;
          fontSize = largeDesktopFontSize;
        }

        return Column(
          children: [
            SizedBox(height: 35),
            SizedBox(
              height: 120,
              width: sidebarWidth,
              child: Card(child: _ManageByList(fontSize: fontSize)),
            ),
          ],
        );
      },
    );
  }

  Widget _ManageByList({required double fontSize}) {
    final controller1 = Get.find<ManageUserController>();

    return Obx(() {
      if (controller1.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller1.userdata.isEmpty) {
        return const Center(child: Text('No users found'));
      }

      return ListView.builder(
        itemCount: controller1.userdata.length,
        itemBuilder: (context, index) {
          final user = controller1.userdata[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade700,
                child: Text(
                  user.Name.isNotEmpty ? user.Name[0].toUpperCase() : '?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                user.Name,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manager: ${user.ManageByname.isNotEmpty ? user.ManageByname : 'No manager'}',
                    style: TextStyle(
                      fontSize: fontSize - 2,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Head: ${user.HeadName.isNotEmpty ? user.HeadName : 'No head'}',
                    style: TextStyle(
                      fontSize: fontSize - 2,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
