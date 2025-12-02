import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/user_profile_controller.dart';
import '../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Admin/Drawer/views/drawer_header_admin.dart';
import '../../Admin/Drawer/views/drawer_screen.dart';
import '../controller/overview_controller.dart';
import '../widget/bottom_appbar_widget1.dart';
import '../widget/drawer_header_widget.dart';
import '../widget/drawer_widget.dart';
import '../widget/overview_widget.dart';

class OverViewScreen extends GetView<OverViewController> {
  const OverViewScreen({super.key});
  static const String routeName = '/overview';

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<UserProfileController>();

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
    final bool isUserRoles = !isAdmin;

    final size = MediaQuery.of(Get.context!).size;
    final isMobile = Get.width < 600;
    final isTablet = Get.width >= 600 && Get.width < 900;
    final bottomBarHeight = kBottomNavigationBarHeight;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: ClipRect(
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
              left: 0,
              right: 0,
              bottom: 0,
              height: size.height * 0.85,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 12,
                            left: 12,
                            right: 12,
                            bottom: bottomBarHeight,
                          ),
                          child: OverViewWidget(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ),
                  ],
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
            if ((isMobile || isTablet) && !isAdmin)
              Positioned(top: 20, left: 0, right: 0, child: DrawerHead()),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopTabletContent() {
    return OverViewWidget();
  }
}
