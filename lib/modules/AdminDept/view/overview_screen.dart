import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/user_profile_controller.dart';
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

      final contents =
          (role == 'admin' || role == 'superadmin')
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

      return isMobile ? BottomAppBarWidget1(body: contents) : contents;
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
    return const Padding(padding: EdgeInsets.all(8.0), child: OverViewWidget());
  }

  Widget _buildDesktopTabletContent() {
    return OverViewWidget();
  }
}
