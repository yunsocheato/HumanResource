import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Core/user_profile_controller.dart';
import '../../Admin/Drawer/views/drawer_screen.dart';
import '../Utils/date_picker_attendance.dart';
import '../Utils/date_picker_leave.dart';
import '../widget/attendance_widget.dart';
import '../widget/bottom_appbar_widget1.dart';
import '../widget/drawer_widget.dart';
import '../widget/leave_record_widget.dart';
import '../widget/team_leave_request_widget.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});
  static const String routeName = '/report';

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
          const SizedBox(height: 20),
          Text(
            'LEAVE REQUEST',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          DatePickerLeave(),
          const LeaveRequestTablewidget(),
          const SizedBox(height: 15),
          const TeamRequestLeaveResponsiveWidget(),
          const SizedBox(height: 15),
          Text(
            'ATTENDANCE',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const DatePickerAttendance(),
          const AttendanceTablewidget(),
        ],
      ),
    );
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
