import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/user_profile_controller.dart';
import '../../../../services/logout_services.dart';
import '../../Admin/Drawer/controllers/drawer_controller.dart';

class MenuMobileScreenUser extends StatelessWidget {
  const MenuMobileScreenUser({super.key});
  static const routeName = '/menu_user';

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
                      Row(
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
                          const SizedBox(width: 10),
                          Text(
                            'Back',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Flexible(
                    flex: 5,
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
                ],
              );
            }),
            _menuDivider(),
            const SizedBox(height: 20),
            _menuBoxGrid(drawer),
            const SizedBox(height: 15),
            _menuDivider(),
            const SizedBox(height: 25),
            _expandTile(
              title: "Leave & Requests",
              icon: Icons.request_page_outlined,
              children: [
                _simpleItem("Leave Requests", index: 1, drawer: drawer),
                _simpleItem("Approval Panel", index: 2, drawer: drawer),
              ],
            ),

            _expandTile(
              title: "Admin Controls",
              icon: Icons.admin_panel_settings,
              children: [
                _simpleItem("Policy Setup", index: 3, drawer: drawer),
                _simpleItem("Employee Policies", index: 4, drawer: drawer),
                _simpleItem("Reports", index: 5, drawer: drawer),
              ],
            ),

            _expandTile(
              title: "Settings",
              icon: Icons.settings_outlined,
              children: [
                _simpleItem("General Settings", index: 6, drawer: drawer),
                _simpleItem("Notifications", index: 7, drawer: drawer),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => auth.logout(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGOUT',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      'assets/icon/logouts.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _menuBoxGrid(AppDrawerController drawer) {
    final items = [
      ("Dashboard", Icons.dashboard, 24),
      ("Attendance", Icons.calendar_month, 1),
      ("Employees", Icons.people, 4),
      ("Reports", Icons.bar_chart, 5),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 80,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, i) {
        final selected = drawer.selectedIndex.value == items[i].$3;

        return GestureDetector(
          onTap: () => drawer.setSelected(items[i].$3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  items[i].$2,
                  size: 26,
                  color: selected ? Colors.blue : Colors.black,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    items[i].$1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
        children: children,
      ),
    );
  }

  Widget _simpleItem(
    String title, {
    required int index,
    required AppDrawerController drawer,
  }) {
    final selected = drawer.selectedIndex.value == index;

    return ListTile(
      leading: Icon(
        Icons.circle,
        size: 12,
        color: selected ? Colors.blue : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.blue : Colors.black,
          fontSize: 14,
        ),
      ),
      dense: true,
      onTap: () => drawer.setSelected(index),
    );
  }
}
