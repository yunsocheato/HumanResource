import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/widgets/Method_drawer_policy_button.dart';
import '../../../Core/user_profile_controller.dart';
import '../../Dashboard/views/dashboard_screen.dart';
import '../../Loginscreen/services/logout_services.dart';
import '../../Schedule/views/schedule_screen.dart';
import '../controllers/drawer_controller.dart';
import '../widgets/drawer_department_policy.dart';
import '../widgets/drawer_employee_policy.dart';
import '../widgets/drawer_leave_request.dart';
import '../widgets/drawer_policy_setup.dart';
import '../widgets/drawer_reports_policy.dart';

class Drawerscreen extends GetView<AppDrawerController> {
  final Widget content;
  const Drawerscreen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      final isDesktop = constraints.maxWidth >= 1024;
      final controller = Get.find<AuthController>();
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: isMobile
              ? Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          )
              : IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.offAllNamed(DashboardScreen.routeName),
          ),
          title: isMobile ? Text(
            'DEAM COMPUTER\nINTERNATIONAL HR',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ): Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DEAM COMPUTER INTERNATIONAL HR',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 20),
              // UpdateButtonScreen()
            ],
          ),
          backgroundColor: Color(0xFF242C40),
          actions: [
            if (!isMobile)
              Obx(() {
                final controller = Get.find<UserProfileController>();
                final profile = controller.userprofiles.value;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${profile?.role ?? "No role"} ,'.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      profile?.name ?? 'No Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 17,
                      ),
                    ),
                  ],
                );
              }),
            SizedBox(width: 15),
            if (!isMobile)
            Obx(() {
              final controller = Get.find<UserProfileController>();
              final image = controller.userprofiles.value?.image;

              if (image == null || image.isEmpty) {
                return CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/profileuser.png'),
                );
              }

              return CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(image),
              );
            }),

            SizedBox(width: 20),

            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),

            if (!isMobile)
              IconButton(
                icon: Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  controller.logoutWithConfirmation();
                },
              ),
            SizedBox(width: 10),
            if (isMobile)
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (_) => Container(
                    height: 250,
                    child: _buildSearchBox(),
                  ),
                ),
              ),
          ],
        ),
        drawer: isMobile ? Drawer(child: _buildSidebar(context)) : null,
        body: Row(
          children: [
            if (!isMobile)
              SizedBox(
                width: isDesktop ? 320 : 260,
                child: _buildSidebar(context),
              ),
            Expanded(child: content),
          ],
        ),
      );
    });
  }

  Widget _buildSidebar(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isMobile = MediaQuery.of(context).size.width < 600;
    final controller = Get.find<AuthController>();

    return SafeArea(
      child: Container(
        color:  Color(0xFF1B2230),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  if (!isMobile)
                  SizedBox(width: isDesktop ? 320 : 260, child: _buildSearchBox()),
                  const SizedBox(height: 20),
                  _buildDrawerTile(
                    'Dashboard',
                    Icons.home, () => MethodButton1()
                  ),
                  _buildDrawerTile(
                      'Attendance',
                      Icons.calendar_month_sharp, () => MethodButton2()
                  ),
                  const SizedBox(height: 10),
                  PolicySetup(),
                  ReportPolicy(),
                  Employeepolicy(),
                  Departmentpolicy(),
                  // Attendancepolicy(),
                  LeaveRequest(),
                  _buildDrawerTile(
                    'Schedule',
                    Icons.calendar_today,
                        () {
                      Get.toNamed(schedulescreen.routeName);
                      if (Scaffold.of(context).isDrawerOpen) Navigator.pop(context);
                    },
                  ),
                  _buildDrawerTile(
                    'History',
                    Icons.history,
                        () {
                      Get.toNamed(DashboardScreen.routeName);
                      if (Scaffold.of(context).isDrawerOpen) Navigator.pop(context);
                    },
                  ),
                  _buildDrawerTile(
                    'Self Services',
                    Icons.settings_accessibility_outlined,
                        () {
                      if (Scaffold.of(context).isDrawerOpen) Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            if (isMobile)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 90,
                  decoration: const BoxDecoration(
                    color:  Color(0xFF1B2230),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Obx(() {
                          final controller = Get.find<UserProfileController>();
                          final image = controller.userprofiles.value?.image;

                          if (image == null || image.isEmpty) {
                            return CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              backgroundImage: AssetImage(
                                  'assets/images/profileuser.png'),
                            );
                          }

                          return CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(image),
                          );
                        }),

                        SizedBox(width: 12),
                        Expanded(
                          child: Obx(() {
                            final controller = Get.find<UserProfileController>();
                            final profile = controller.userprofiles.value;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  profile?.name ?? 'No Name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  profile?.role ?? 'No Role',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            );
                          }
                          ),
                        ),
                        IconButton(

                          icon: const Icon(Icons.logout, color: Colors.white),
                          onPressed: () => controller.logoutWithConfirmation(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.white70),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
        },
      ),
    );
  }

  Widget _buildDrawerTile(String title, IconData icon, VoidCallback? onTap,
      {List<Widget>? children}) {
    return Obx(() {
      final expanded = controller.isExpanded(title);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.white),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: children == null
                ? null
                : Icon(
              expanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.white,
            ),
            onTap: children == null ? onTap : () => controller.toggleExpand(title),
          ),
          if (expanded && children != null)
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(children: children),
            ),
        ],
      );
    });
  }
}
