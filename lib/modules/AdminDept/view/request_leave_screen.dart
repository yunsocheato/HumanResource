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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RequestLeaveWidget(),
    );
  }

  Widget _buildDesktopTabletContent() {
    return const RequestLeaveWidget();
  }
}
