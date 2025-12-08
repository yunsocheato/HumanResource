import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/user_profile_controller.dart';
import '../../Admin/Drawer/views/drawer_screen.dart';
import '../controller/request_leave_controller.dart';
import '../widget/bottom_appbar_widget1.dart';
import '../widget/drawer_widget.dart';
import '../widget/request_leave_screen_widget.dart';

class RequestLeaveScreen extends GetView<RequestLeaveScreenController> {
  const RequestLeaveScreen({super.key});
  static const String routeName = '/requestleave';

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<UserProfileController>().userprofiles.value;
    final role = profile?.role ?? '';
    final isMobile = Get.width < 600;
    final myScrollController = ScrollController();
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
    final size = MediaQuery.of(Get.context!).size;
    final bottomBarHeight = kBottomNavigationBarHeight;

    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade700],
          ),
        ),
        child: Stack(
          children: [
            // Decorative floating circle
            Positioned(
              top: -30,
              right: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned.fill(
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.15),
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 12,
                    right: 12,
                    bottom: bottomBarHeight + 12,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: const Column(children: [RequestLeaveWidget()]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopTabletContent() {
    return const RequestLeaveWidget();
  }
}
