import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Admin/Loginscreen/services/logout_services.dart';
import 'drawer_header_widget.dart';

class DrawerAdmin extends StatefulWidget {
  final Widget content;

  const DrawerAdmin({Key? key, required this.content}) : super(key: key);

  @override
  State<DrawerAdmin> createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Get.width < 600;
    final bool isTablet = Get.width >= 600 && Get.width < 900;
    final bool showSidebar = !(isMobile || isTablet);
    final controller = Get.find<AuthController>();

    return Scaffold(
      drawer:
          (isMobile || isTablet)
              ? Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHead(),
                    _buildDrawerTile(
                      icon: EneftyIcons.grid_1_outline,
                      title: "OVERVIEW",
                      onTap: () {
                        Get.toNamed("/overview");
                      },
                    ),
                    _buildDrawerTile(
                      icon: EneftyIcons.user_bold,
                      title: "PROFILES",
                      onTap: () {
                        Get.toNamed("/profiles");
                      },
                    ),
                    _buildDrawerTile(
                      icon: EneftyIcons.folder_2_bold,
                      title: "REPORT",
                      onTap: () {
                        Get.toNamed("/report");
                      },
                    ),
                    _buildDrawerTile(
                      icon: EneftyIcons.calendar_2_bold,
                      title: "ATTENDANCE",
                      onTap: () {
                        Get.toNamed("/attendance");
                      },
                    ),
                    const SizedBox(height: 300),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: controller.logoutWithConfirmation,
                    ),
                  ],
                ),
              )
              : null,
      body: Row(
        children: [
          if (showSidebar)
            MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: AnimatedContainer(
                duration: Duration(microseconds: 100),
                curve: Curves.easeInOut,
                width: isHovered ? 180 : 65,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(isHovered ? 3 : 0, isHovered ? 3 : 0),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade900,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/deamlogo.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                          if (isHovered) const SizedBox(width: 12),
                          if (isHovered)
                            Expanded(
                              child: Text(
                                "DEAM COMPUTER\nINTERNATIONAL",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "7TH.ttf",
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    _buildSidebarItem(
                      icon: Icons.dashboard_outlined,
                      title: "OVERVIEW",
                      showText: isHovered,
                      onTap: () {
                        Get.toNamed("/overview");
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSidebarItem(
                      icon: EneftyIcons.user_bold,
                      title: "PROFILES",
                      showText: isHovered,
                      onTap: () {
                        Get.toNamed("/profiles");
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSidebarItem(
                      icon: EneftyIcons.folder_2_bold,
                      title: "REPORT",
                      showText: isHovered,
                      onTap: () {
                        Get.toNamed("/report");
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSidebarItem(
                      icon: EneftyIcons.calendar_3_bold,
                      title: "ATTENDANCE",
                      showText: isHovered,
                      onTap: () {
                        Get.toNamed("/attendance");
                      },
                    ),
                    const Spacer(),
                    Divider(color: Colors.white24, indent: 10, endIndent: 10),
                    _buildSidebarItem(
                      icon: Icons.logout,
                      title: "LOGOUT",
                      showText: isHovered,
                      onTap: controller.logoutWithConfirmation,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [const DrawerHead(), widget.content],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    bool showText = false,
    bool showIcon = false,
    Color color = Colors.white,
    VoidCallback? onTap,
  }) {
    double fontSize = showText ? 14 : 16;
    double iconSize = showIcon ? 20 : 25;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: iconSize),
            if (showText) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
