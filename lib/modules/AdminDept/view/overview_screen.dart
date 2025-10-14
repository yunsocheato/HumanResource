import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/overview_controller.dart';

import '../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Superadmin/Attendance/views/attendance_chart.dart';
import '../../Superadmin/Drawer/views/drawer_screen.dart';
import '../widget/card_toggle_widget.dart';
import '../widget/power_chart_widget.dart';
import '../widget/sidebar_widget.dart';

class OverViewScreen extends GetView<OverViewController> {
  const OverViewScreen({super.key});
  static const routeName = '/overview';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    Widget dashboardLayout = _buildResponsiveCardInfo(context);

    Widget finalScreen = Drawerscreen(
      content:
          isMobile
              ? _buildMobileScrollableBody(context, dashboardLayout)
              : SingleChildScrollView(child: dashboardLayout),
    );

    return isMobile ? BottomAppBarWidget(body: finalScreen) : finalScreen;
  }

  Widget _buildMobileScrollableBody(BuildContext context, Widget child) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshdata();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: child,
            ),
          ),
        );
      },
    );
  }

  Widget _buildResponsiveCardInfo(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: isMobile ? _buildNarrowLayout(context) : _buildWideLayout(context),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AttendanceChart(),
              const SizedBox(height: 20),

              const Text(
                "My Quick Controls",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ControlToggleCard(
                      title: "Clock-In/Out",
                      icon: Icons.timer,
                      color: Colors.deepPurple,
                      toggleState: controller.isClockedIn,
                      onChanged: controller.toggleClockStatus,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ControlToggleCard(
                      title: "Request Leave",
                      icon: Icons.flight_takeoff,
                      color: Colors.pink,
                      toggleState: controller.isLeaveRequestPending,
                      onChanged: controller.toggleLeaveRequest,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ControlToggleCard(
                      title: "Payslip Access",
                      icon: Icons.attach_money,
                      color: Colors.green,
                      toggleState: controller.isPayslipAvailable,
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                "Work Hours & Overtime",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text("Total Hours This Week"),
                          const SizedBox(height: 8),
                          Text(
                            "42:00",
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Target: 40:00",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Overtime Balance"),
                          const SizedBox(height: 8),
                          Text(
                            "+2:00",
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.red[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Approved: 0:30",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SidebarSection(
                title: "My Tasks & Approvals",
                items: const [
                  "Review Leave Request (3)",
                  "Approve Expense Report",
                  "Performance Review (5)",
                ],
                icon: Icons.task_alt,
              ),
              const SizedBox(height: 20),
              SidebarSection(
                title: "Team Members",
                items: const [
                  "Scarlett (Admin)",
                  "Nariya (Full Access)",
                  "Riya (HR)",
                ],
                icon: Icons.people,
              ),
              const SizedBox(height: 20),
              const PowerConsumedChart(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AttendanceChart(),
        const SizedBox(height: 20),

        const Text(
          "My Quick Controls",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ControlToggleCard(
                title: "Clock-In/Out",
                icon: Icons.timer,
                color: Colors.deepPurple,
                toggleState: controller.isClockedIn,
                onChanged: controller.toggleClockStatus,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ControlToggleCard(
                title: "Request Leave",
                icon: Icons.flight_takeoff,
                color: Colors.pink,
                toggleState: controller.isLeaveRequestPending,
                onChanged: controller.toggleLeaveRequest,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ControlToggleCard(
          title: "Payslip Access",
          icon: Icons.attach_money,
          color: Colors.green,
          toggleState: controller.isPayslipAvailable,
          onChanged: (v) {},
        ),

        const SizedBox(height: 20),
        const SidebarSection(
          title: "Team Members",
          items: ["Scarlett (Admin)", "Nariya (Full Access)"],
          icon: Icons.people,
        ),
        const SizedBox(height: 20),
        const PowerConsumedChart(),
        const SizedBox(height: 20),
      ],
    );
  }
}
