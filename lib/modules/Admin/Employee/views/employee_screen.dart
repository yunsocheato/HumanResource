import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Admin/Employee/Controller/employee_screen_controller.dart';
import 'package:hrms/modules/AdminDept/widget/bottom_appbar_widget1.dart';
import 'package:hrms/modules/AdminDept/widget/drawer_widget.dart';
import '../../../../Core/user_profile_controller.dart';
import '../../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../widgets/employee_record.dart';

class EmployeeScreen extends GetView<EmployeeScreenController> {
  const EmployeeScreen({super.key});

  static const String routeName = '/employee';

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<UserProfileController>();

    return Obx(() {
      final profile = profileController.userprofiles.value;
      if (profile == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final role = profile.role.toLowerCase();
      final bool isAdmin = role == 'admin' || role == 'superadmin';
      final bool isMobile = Get.width < 600;

      final desktopBody = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildHeader(context, _getTitleFontSize(Get.width)),
            ),
            const SizedBox(height: 10),
            const Cardinfo(),
            const SizedBox(height: 10),
            _buildResponsiveCardInfo(context, Get.width),
          ],
        ),
      );

      final mobileBody = _buildMobileBody(context);

      final content =
          isAdmin
              ? Drawerscreen(content: isMobile ? mobileBody : desktopBody)
              : DrawerAdmin(content: isMobile ? mobileBody : desktopBody);

      if (isMobile) {
        return isAdmin
            ? BottomAppBarWidget(body: content)
            : BottomAppBarWidget1(body: content);
      }

      return content;
    });
  }

  double _getTitleFontSize(double width) {
    if (width < 600) return 14;
    if (width < 1024) return 18;
    if (width < 1440) return 20;
    if (width < 2560) return 24;
    return 28;
  }

  Widget _buildHeader(BuildContext context, double titleFontSize) {
    final controller = Get.find<EmployeeScreenController>();
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final isLaptop = width >= 900 && width < 1440;
    final isDesktop = width >= 1440 && width < 1920;
    final isLargeDesktop = width >= 1920;
    final showHeader = isLaptop || isDesktop || isLargeDesktop;

    return Obx(
      () => AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: controller.showlogincard1.value ? 1.0 : 0.0,
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.only(
            top: controller.showlogincard1.value ? 0 : 100,
          ),
          child:
              showHeader
                  ? SizedBox(
                    height: 70,
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: <Widget>[
                                Text(
                                  'ADMIN EMPLOYEE',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    foreground:
                                        Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.blue[700]!,
                                  ),
                                ),
                                Text(
                                  'ADMIN EMPLOYEE',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: controller.refreshdata,
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.yellow,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Stack(
                              children: <Widget>[
                                Text(
                                  'ADMIN EMPLOYEE',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    foreground:
                                        Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.yellow[700]!,
                                  ),
                                ),
                                Text(
                                  'ADMIN EMPLOYEE',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: controller.refreshdata,
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.yellow,
                            size: isMobile ? 16 : 24,
                          ),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildResponsiveCardInfo(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 600),
        child: const EmployeeList(),
      ),
    );
  }

  Widget _buildMobileBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomBarHeight = kBottomNavigationBarHeight;
    final width = size.width;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: ClipRect(
        child: Stack(
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
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context, _getTitleFontSize(width)),
                        const SizedBox(height: 10),
                        const Cardinfo(),
                        const SizedBox(height: 15),
                        const EmployeeList(),
                        SizedBox(height: bottomBarHeight + 20),
                      ],
                    ),
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
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
