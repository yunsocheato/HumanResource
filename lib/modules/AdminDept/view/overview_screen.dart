import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/user_profile_controller.dart';
import '../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Admin/Drawer/views/drawer_screen.dart';
import '../controller/overview_controller.dart';
import '../widget/bottom_appbar_widget1.dart';
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
                        child: _responsiveBody(context),
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
                        child: _responsiveBody(context),
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

  Widget _responsiveBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileContent();
        }
        return const OverViewWidget();
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
    final isMobile = Get.width < 600;
    final isTablet = Get.width >= 600 && Get.width < 900;
    final bottomBarHeight = kBottomNavigationBarHeight;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade900, Colors.blue.shade700],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height * 0.85,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 12,
                  left: 12,
                  right: 12,
                  bottom: bottomBarHeight,
                ),
                child: const OverViewWidget(),
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
          Positioned(
            top: -30,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
