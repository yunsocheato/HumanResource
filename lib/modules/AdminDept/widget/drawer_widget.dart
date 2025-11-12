import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/user_profile_controller.dart';
import '../../../services/logout_services.dart';
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
                      onTap: controller.logout,
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
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                width: isHovered ? 180 : 100,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isHovered ? 0.3 : 0.1),
                      blurRadius: isHovered ? 15 : 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final drawerWidth = constraints.maxWidth;
                          final controller = Get.find<UserProfileController>();
                          final profile = controller.userprofiles.value;
                          final image = profile?.image ?? '';

                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    image.isEmpty
                                        ? const AssetImage(
                                          'assets/images/profileuser.png',
                                        )
                                        : NetworkImage(image) as ImageProvider,
                              ),
                              if (isHovered && drawerWidth > 120) ...[
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        profile?.name ?? 'No Name',
                                        style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        profile?.Position ?? 'No Position',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        profile?.role ?? 'No role',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 70),

                    _buildSidebarItem(
                      icon: Icons.dashboard_outlined,
                      title: "OVERVIEW",
                      routeName: "/overview",
                      showText: isHovered,
                    ),
                    SizedBox(height: isHovered ? 35 : 25),
                    _buildSidebarItem(
                      icon: EneftyIcons.user_bold,
                      title: "PROFILES",
                      routeName: "/profiles",
                      showText: isHovered,
                    ),
                    SizedBox(height: isHovered ? 35 : 25),
                    _buildSidebarItem(
                      icon: EneftyIcons.folder_2_bold,
                      title: "REPORT",
                      routeName: "/report",
                      showText: isHovered,
                    ),
                    SizedBox(height: isHovered ? 35 : 25),
                    _buildSidebarItem(
                      icon: EneftyIcons.calendar_3_bold,
                      title: "ATTENDANCE",
                      routeName: "/attendance",
                      showText: isHovered,
                    ),

                    const Spacer(),
                    Divider(color: Colors.white24, indent: 10, endIndent: 10),

                    _buildSidebarItem(
                      icon: Icons.logout,
                      title: "LOGOUT",
                      routeName: "/logout",
                      showText: isHovered,
                      onTap: controller.logout,
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
    required String routeName,
    bool showText = false,
    VoidCallback? onTap,
  }) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        final bool isSelected = Get.currentRoute == routeName;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOutQuart,
            decoration: BoxDecoration(
              color:
                  !showText
                      ? Colors.blueGrey.shade900
                      : (isSelected
                          ? Colors.blue.shade900
                          : (isHovered
                              ? Colors.blue.shade800
                              : Colors.blueGrey.shade900)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                if (routeName != "/logout") Get.offAllNamed(routeName);
                onTap?.call();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white, size: isHovered ? 25 : 20),
                    if (showText) ...[
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
