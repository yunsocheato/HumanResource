import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/user_profile_controller.dart';
import '../../../services/logout_services.dart';
import 'drawer_header_widget.dart';

class DrawerAdmin extends StatelessWidget {
  final Widget content;

  const DrawerAdmin({super.key, required this.content});

  bool get isMobile => Get.width < 600;
  bool get isTablet => Get.width >= 600 && Get.width < 900;
  bool get isDesktop => Get.width >= 900 && Get.width < 1440;
  bool get isLargeDesktop => Get.width >= 1440;

  double get sidebarWidth {
    if (isLargeDesktop) return 240;
    if (isDesktop) return 170;
    if (isTablet) return 120;
    return 100;
  }

  EdgeInsets getResponsivePadding() {
    if (isLargeDesktop) {
      return const EdgeInsets.symmetric(vertical: 20, horizontal: 20);
    }
    if (isDesktop) {
      return const EdgeInsets.symmetric(vertical: 10, horizontal: 10);
    }
    if (isTablet) {
      return const EdgeInsets.symmetric(vertical: 16, horizontal: 16);
    }
    return const EdgeInsets.symmetric(vertical: 14, horizontal: 14);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      drawer: (isMobile || isTablet) ? _buildDrawerContent(controller) : null,

      body: Row(
        children: [
          if (!isMobile && !isTablet)
            Container(
              width: sidebarWidth,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: _buildSidebarColumn(controller),
            ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [const DrawerHead(), content],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarColumn(AuthController auth) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _buildProfileHeader(),

        const SizedBox(height: 40),

        _buildSidebarItem(
          icon: Icons.dashboard_outlined,
          title: "Overview",
          routeName: "/overview",
        ),
        SizedBox(height: 25),
        _buildSidebarItem(
          icon: EneftyIcons.user_bold,
          title: "Profiles",
          routeName: "/userprofile",
        ),
        SizedBox(height: 25),

        _buildSidebarItem(
          icon: EneftyIcons.folder_2_bold,
          title: "Report",
          routeName: "/report",
        ),
        SizedBox(height: 25),

        _buildSidebarItem(
          icon: EneftyIcons.calendar_3_bold,
          title: "Attendance",
          routeName: "/attendance",
        ),
        SizedBox(height: 25),
        _buildSidebarItem(
          icon: EneftyIcons.key_bold,
          title: "Change Password",
          routeName: "/attendance",
        ),
        SizedBox(height: 25),
        _buildSidebarItem(
          icon: EneftyIcons.setting_2_bold,
          title: "Setting",
          routeName: "/attendance",
        ),
        const Spacer(),
        const Divider(color: Colors.white),
        _buildSidebarItem(
          icon: Icons.logout,
          title: "LOGOUT",
          routeName: "/logout",
          onTap: auth.logout,
          isLogout: true,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Drawer _buildDrawerContent(AuthController auth) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHead(),
            _buildSidebarItem(
              icon: Icons.dashboard_outlined,
              title: "OVERVIEW",
              routeName: "/overview",
            ),
            _buildSidebarItem(
              icon: EneftyIcons.user_bold,
              title: "PROFILES",
              routeName: "/profiles",
            ),
            _buildSidebarItem(
              icon: EneftyIcons.folder_2_bold,
              title: "REPORT",
              routeName: "/report",
            ),
            _buildSidebarItem(
              icon: EneftyIcons.calendar_3_bold,
              title: "ATTENDANCE",
              routeName: "/attendance",
            ),

            const Spacer(),
            const Divider(color: Colors.white),
            _buildSidebarItem(
              icon: Icons.logout,
              title: "LOGOUT",
              routeName: "/logout",
              onTap: auth.logout,
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final profile = Get.find<UserProfileController>().userprofiles.value;
    final image = profile?.image ?? '';

    return Container(
      height: 100,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 25,
              backgroundImage:
                  image.isEmpty
                      ? const AssetImage('assets/images/profileuser.png')
                      : NetworkImage(image) as ImageProvider,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile?.name ?? "No Name",
                    style: TextStyle(color: Colors.grey[300], fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    profile?.Position ?? "No Position",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    profile?.role ?? "No role",
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required String routeName,
    VoidCallback? onTap,
    bool isLogout = false,
  }) {
    final double screenWidth = Get.width;

    double fontsize;
    if (screenWidth < 600) {
      fontsize = 10;
    } else if (screenWidth < 900) {
      fontsize = 11;
    } else if (screenWidth < 1440) {
      fontsize = 12;
    } else {
      fontsize = 13;
    }
    bool isHover = false;
    return StatefulBuilder(
      builder: (context, setState) {
        final bool isSelected = Get.currentRoute == routeName;
        return MouseRegion(
          onEnter: (_) => setState(() => isHover = true),
          onExit: (_) => setState(() => isHover = false),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              if (routeName != "/logout") Get.offAllNamed(routeName);
              if (routeName == "/logout") onTap?.call();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              padding: getResponsivePadding(),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.blue.shade900
                        : isHover
                        ? Colors.blue.shade900
                        : Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontsize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
