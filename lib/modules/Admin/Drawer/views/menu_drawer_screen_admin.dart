import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Admin/Drawer/widgets/drawer_leave_request.dart';
import '../../../../Core/user_profile_controller.dart';
import '../controllers/drawer_controller.dart';
import '../../../../services/logout_services.dart';
import '../widgets/Method_drawer_policy_button.dart';
import '../widgets/drawer_policy_setup.dart';
import '../widgets/drawer_employee_policy.dart';
import '../widgets/drawer_reports_policy.dart';
import 'overview_screen_admin.dart';

class MenuMobileScreenAdmin extends StatelessWidget {
  const MenuMobileScreenAdmin({super.key});
  static const routeName = '/menu_admin';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    if (!isMobile && !isTablet) {
      Future.microtask(() => Get.offAllNamed('/overview'));
      return const SizedBox();
    }

    final user = Get.find<UserProfileController>();
    final drawer = Get.find<AppDrawerController>();
    final auth = Get.find<AuthController>();

    final double fontSizeBody = 14;

    return Scaffold(
      backgroundColor: const Color(0xFF242C40),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const SizedBox(height: 10),
            Obx(() {
              final profile = user.userprofiles.value;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed:
                            () => Future.microtask(
                              () => Get.offAllNamed('/overview'),
                            ),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              (profile?.image == null || profile!.image.isEmpty)
                                  ? const AssetImage(
                                    "assets/images/profileuser.png",
                                  )
                                  : NetworkImage(profile.image)
                                      as ImageProvider,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          profile?.name ?? 'Unknown User',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          profile?.role ?? 'Unknown Role',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () => auth.logout(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'LOGOUT',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                'assets/icon/logout.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),

            const SizedBox(height: 20),

            _menuGrid(drawer, context),
            const SizedBox(height: 15),
            _menuDivider(),
            const SizedBox(height: 15),
            // _expandTile(
            //   title: "Employee Management",
            //   icon: Icons.person,
            //   children: [
            //     _buildDrawerTile(
            //       'Employee',
            //       'assets/icon/user.png',
            //       () => Get.offAllNamed('/employee'),
            //       index: 140,
            //       fontSize: fontSizeBody,
            //       drawer: drawer,
            //     ),
            //   ],
            // ),
            _expandTile(
              title: "Admin Control Panel",
              icon: Icons.admin_panel_settings,
              children: [PolicySetup(), Employeepolicy(), ReportPolicy()],
            ),
            const SizedBox(height: 10),
            _expandTile(
              title: "Leave Management",
              icon: Icons.beach_access_outlined,
              children: [TableLeaveRequest()],
            ),
            // _expandTile(
            //   title: "Settings",
            //   icon: Icons.settings_outlined,
            //   children: [
            //     _buildDrawerTile(
            //       'Manage Setting',
            //       'assets/icon/setting.png',
            //       () => Get.offAllNamed('/settingmobile'),
            //       index: 23,
            //       fontSize: fontSizeBody,
            //       drawer: drawer,
            //     ),
            //   ],
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _menuGrid(AppDrawerController drawer, BuildContext context) {
    final double fontSizeBody = 14;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        _expandTile(
          title: "My Overview",
          icon: Icons.dashboard_outlined,
          children: [OverviewAdmin()],
        ),
        _expandTile(
          title: "Admin Dashboard",
          icon: Icons.home_filled,
          children: [
            _buildDrawerTile(
              'Admin Dashboard',
              'assets/icon/home.png',
              () => MethodButton18(),
              index: 24,
              fontSize: fontSizeBody,
              drawer: drawer,
            ),
          ],
        ),
        _expandTile(
          title: "Manage Attendance User",
          icon: Icons.policy_outlined,
          children: [
            _buildDrawerTile(
              'Manage Attendance User',
              'assets/icon/calendars.png',
              () => MethodButton2(),
              index: 1,
              fontSize: fontSizeBody,
              drawer: drawer,
            ),
          ],
        ),
      ],
    );
  }

  Widget _menuDivider() {
    return const Divider(thickness: 1, color: Colors.grey, height: 20);
  }

  Widget _expandTile({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
        children: children,
      ),
    );
  }

  Widget _buildDrawerTile(
    String title,
    String iconPath,
    VoidCallback onTap, {
    required int index,
    double fontSize = 12,
    required AppDrawerController drawer,
  }) {
    final isSelected = drawer.selectedIndex.value == index;
    final isMobile = Get.width < 600;
    final Color Selectedcolors = Colors.blue.shade900;
    final Color Unselectedcolors = Colors.white;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color:
                    isSelected
                        ? Selectedcolors
                        : (isMobile ? Colors.blue : Unselectedcolors),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
