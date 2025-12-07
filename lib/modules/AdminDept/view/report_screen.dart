import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/overview_controller.dart';

import '../../../Core/user_profile_controller.dart';
import '../../../Utils/Bottomappbar/controller/bottomappbar_controller.dart';
import '../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Admin/Drawer/views/drawer_screen.dart';
import '../Utils/date_picker_attendance.dart';
import '../Utils/date_picker_leave.dart';
import '../controller/bottom_appbar_controller.dart';
import '../widget/attendance_widget.dart';
import '../widget/bottom_appbar_widget1.dart';
import '../widget/drawer_header_widget.dart';
import '../widget/drawer_widget.dart';
import '../widget/leave_record_widget.dart';
import '../widget/team_leave_request_widget.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});
  static const String routeName = '/report';

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<UserProfileController>();
    final controller = Get.find<BottomAppBarController>();
    final controller1 = Get.find<BottomAppBarController1>();

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

  Widget _buildResponsiveContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return isMobile ? _buildMobileContent() : _buildDesktopTabletContent();
      },
    );
  }

  Widget _buildMobileContent() {
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
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: _pageviewMangementList(),
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
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     children: [
    //       const SizedBox(height: 20),
    //       Text(
    //         'LEAVE REQUEST',
    //         style: TextStyle(
    //           color: Colors.grey,
    //           fontSize: 14,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       const SizedBox(height: 5),
    //       DatePickerLeave(),
    //       const LeaveRequestTablewidget(),
    //       const SizedBox(height: 15),
    //       const TeamRequestLeaveResponsiveWidget(),
    //       const SizedBox(height: 15),
    //       Text(
    //         'ATTENDANCE',
    //         style: TextStyle(
    //           color: Colors.grey,
    //           fontSize: 14,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       const SizedBox(height: 5),
    //       const DatePickerAttendance(),
    //       const AttendanceTablewidget(),
    //     ],
    //   ),
    // );
  }

  Widget _pageviewMangementList() {
    final ManageController = Get.find<OverViewController>();
    final isMobile = Get.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment:
                  isMobile
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.start,
              children: List.generate(ManageController.managelist1.length, (
                index,
              ) {
                final selected =
                    ManageController.isSelectedindex.value == index;

                return GestureDetector(
                  onTap: () {
                    ManageController.SelectedIndex(index);
                    ManageController.pageController2.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 14,
                    ),
                    decoration: ManageController.boxDecoration(index).copyWith(
                      color:
                          selected ? Colors.blue.shade900 : Colors.transparent,
                    ),
                    child: Text(
                      ManageController.managelist1[index],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: ManageController.iconColor(index),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),

        const SizedBox(height: 15),

        SizedBox(
          height: 450,
          child: PageView.builder(
            controller: ManageController.pageController2,
            itemCount: ManageController.managelist1.length,
            onPageChanged: (index) => ManageController.SelectedIndex(index),
            itemBuilder: (_, index) {
              return _buildPage(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
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
                  DatePickerAttendance(),
                ],
              ),
              SizedBox(height: 10),
              AttendanceTablewidget(),
            ],
          ),
        );

      case 1:
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
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
                  DatePickerLeave(),
                ],
              ),
              SizedBox(height: 10),
              LeaveRequestTablewidget(),
            ],
          ),
        );

      case 2:
        return const TeamRequestLeaveResponsiveWidget();

      default:
        return const Center(child: Text("No page found"));
    }
  }

  Widget _buildDesktopTabletContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'LEAVE REQUEST',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          DatePickerLeave(),
          const LeaveRequestTablewidget(),
          const SizedBox(height: 20),
          const TeamRequestLeaveResponsiveWidget(),
          const SizedBox(height: 20),
          Text(
            'ATTENDANCE',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const DatePickerAttendance(),
          const AttendanceTablewidget(),
        ],
      ),
    );
  }
}
