import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:hrms/Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../../../../Core/user_profile_controller.dart';
import '../../../../Utils/DialogScreen/DialogScreen.dart';
import '../../../../services/logout_services.dart';
import '../../Dashboard/views/dashboard_screen.dart';
import '../../SettingScreen/view/setting_screen_Desktop.dart';
import '../controllers/drawer_controller.dart';
import '../widgets/Method_drawer_policy_button.dart';
import '../widgets/drawer_employee_policy.dart';
import '../widgets/drawer_leave_request.dart';
import '../widgets/drawer_policy_setup.dart';
import '../widgets/drawer_reports_policy.dart';

class Drawerscreen extends GetView<AppDrawerController> {
  final Widget content;
  const Drawerscreen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final HoverMouseController controller2 = Get.put(
          HoverMouseController(),
        );

        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isDesktop = width >= 1024 && width < 2560;
        final isLargeDesktop = width >= 2560 && width < 3840;
        double sidebarWidth;
        double fontSizeTitle;
        double fontSizeBody;
        double iconSize;
        double avatarRadius;

        if (isMobile) {
          sidebarWidth = 240;
          fontSizeTitle = 15;
          fontSizeBody = 12;
          iconSize = 22;
          avatarRadius = 35;
        } else if (isTablet) {
          sidebarWidth = 260;
          fontSizeTitle = 16;
          fontSizeBody = 13;
          iconSize = 24;
          avatarRadius = 22;
        } else if (isDesktop) {
          sidebarWidth = 320;
          fontSizeTitle = 18;
          fontSizeBody = 14;
          iconSize = 26;
          avatarRadius = 25;
        } else if (isLargeDesktop) {
          sidebarWidth = 360;
          fontSizeTitle = 20;
          fontSizeBody = 16;
          iconSize = 28;
          avatarRadius = 28;
        } else {
          sidebarWidth = 420;
          fontSizeTitle = 22;
          fontSizeBody = 18;
          iconSize = 32;
          avatarRadius = 32;
        }
        final controller = Get.find<AuthController>();
        final controller1 = Get.find<AppDrawerController>();
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: isMobile ? 60 : 70,
            leading:
                isMobile
                    ? Builder(
                      builder:
                          (context) => IconButton(
                            icon: Icon(
                              EneftyIcons.menu_2_bold,
                              size: iconSize,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                    )
                    : IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: iconSize,
                        color: Colors.white,
                      ),
                      onPressed: () => Get.offAllNamed('/dashboard'),
                    ),
            title:
                !isMobile
                    ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedBuilder(
                          animation: controller1.blurAnimation,
                          builder: (context, child) {
                            return ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: controller1.blurAnimation.value,
                                sigmaY: controller1.blurAnimation.value,
                              ),
                              child: child,
                            );
                          },
                          child: Image.asset(
                            'assets/images/deamlogo.png',
                            height: avatarRadius * 2,
                            width: avatarRadius * 2,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'DEAM COMPUTER\nINTERNATIONAL',
                                textStyle: TextStyle(
                                  fontSize: fontSizeTitle,
                                  color: Colors.white,
                                  fontFamily: '7TH.ttf',
                                  fontWeight: FontWeight.w300,
                                ),
                                speed: Duration(milliseconds: 100),
                              ),
                            ],
                            totalRepeatCount: 100,
                            pause: Duration(milliseconds: 1000),
                            displayFullTextOnTap: true,
                          ),
                        ),
                      ],
                    )
                    : AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'DEAM HR',
                          textStyle: TextStyle(
                            fontSize: fontSizeTitle,
                            color: Colors.white,
                            fontFamily: '7TH.ttf',
                            fontWeight: FontWeight.w300,
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 100,
                      pause: Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                    ),
            backgroundColor: const Color(0xFF242C40),
            actions: [
              if (!isMobile)
                Obx(() {
                  final controller = Get.find<UserProfileController>();
                  final profile = controller.userprofiles.value;
                  return Row(
                    children: [
                      Text(
                        '${profile?.role ?? "No role"} ,'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeBody,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        profile?.name ?? 'No Name',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: fontSizeBody,
                        ),
                      ),
                    ],
                  );
                }),
              const SizedBox(width: 15),
              if (!isMobile)
                Obx(() {
                  final controller = Get.find<UserProfileController>();
                  final image = controller.userprofiles.value?.image;

                  if (image == null || image.isEmpty) {
                    return CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: const AssetImage(
                        'assets/images/profileuser.png',
                      ),
                    );
                  }
                  return CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: NetworkImage(image),
                  );
                }),
              const SizedBox(width: 20),
              MouseHover(
                keyId: 20,
                controller: controller2,
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: iconSize,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              if (!isMobile)
                MouseHover(
                  keyId: 21,
                  controller: controller2,
                  child: IconButton(
                    icon: Icon(
                      Icons.logout,
                      size: iconSize,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.logoutWithConfirmation();
                    },
                  ),
                ),
              if (isMobile)
                IconButton(
                  icon: Icon(Icons.search, size: iconSize, color: Colors.white),
                  onPressed:
                      () => showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder:
                            (_) => SizedBox(
                              height: 250,
                              child: _buildSearchBox(fontSizeBody),
                            ),
                      ),
                ),
            ],
          ),
          drawer:
              isMobile
                  ? Drawer(
                    child: _buildSidebarMobile(
                      context,
                      fontSizeTitle,
                      fontSizeBody,
                      iconSize,
                      avatarRadius,
                      sidebarWidth,
                      isMobile,
                    ),
                  )
                  : null,
          body: Row(
            children: [
              if (!isMobile)
                SizedBox(
                  width: sidebarWidth,
                  child: _buildSidebarOtherResponsive(
                    context,
                    fontSizeTitle,
                    fontSizeBody,
                    iconSize,
                    avatarRadius,
                    sidebarWidth,
                  ),
                ),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSidebarOtherResponsive(
    BuildContext context,
    double fontSizeTitle,
    double fontSizeBody,
    double iconSize,
    double avatarRadius,
    double sidebarWidth,
  ) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        width: sidebarWidth,
        color: const Color(0xFF1B2230),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            SizedBox(child: _buildSearchBox(fontSizeBody)),
            const SizedBox(height: 5),
            _buildDrawerTile(
              'Overview',
              Icons.dashboard_outlined,
              () => MethodButton15(),
              index: 0,
              fontSize: fontSizeBody,
              iconSize: iconSize,
            ),
            _buildDrawerTile(
              'Dashboard',
              EneftyIcons.home_2_bold,
              () => MethodButton1(),
              index: 24,
              fontSize: fontSizeBody,
              iconSize: iconSize,
            ),
            _buildDrawerTile(
              'Attendance',
              EneftyIcons.calendar_2_bold,
              () => MethodButton2(),
              index: 1,
              fontSize: fontSizeBody,
              iconSize: iconSize,
            ),
            PolicySetup(),
            ReportPolicy(),
            Employeepolicy(),
            TableLeaveRequest(),
            _buildDrawerTile(
              'Setting',
              EneftyIcons.setting_3_bold,
              () => DialogScreen(context, SettingScreen()),
              index: 23,
              fontSize: fontSizeBody,
              iconSize: iconSize,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarMobile(
    BuildContext context,
    double fontSizeTitle,
    double fontSizeBody,
    double iconSize,
    double avatarRadius,
    double sidebarWidth,
    bool isMobile,
  ) {
    final controller = Get.find<AuthController>();
    final controller1 = Get.find<UserProfileController>();
    final controller2 = Get.find<AppDrawerController>();
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        width: sidebarWidth,
        color: const Color(0xFF1B2230),
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(bottom: 150, top: 15),
              children: [
                Container(
                  height: 135,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(color: Color(0xFF1B2230)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: controller2.blurAnimation,
                          builder: (context, child) {
                            return ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: controller2.blurAnimation.value,
                                sigmaY: controller2.blurAnimation.value,
                              ),
                              child: child,
                            );
                          },
                          child: Image.asset(
                            'assets/images/deamlogo.png',
                            height: avatarRadius * 2,
                            width: avatarRadius * 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'DEAM COMPUTER\nINTERNATIONAL',
                              textStyle: TextStyle(
                                fontSize: fontSizeBody,
                                color: Colors.white,
                                fontFamily: '7TH.ttf',
                                fontWeight: FontWeight.w300,
                              ),
                              speed: Duration(milliseconds: 100),
                            ),
                          ],
                          totalRepeatCount: 100,
                          pause: Duration(milliseconds: 1000),
                          displayFullTextOnTap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                _buildDrawerTile(
                  'Overview',
                  Icons.dashboard,
                  () => MethodButton15(),
                  index: 0,
                  fontSize: fontSizeBody,
                  iconSize: iconSize,
                ),
                const SizedBox(height: 10),
                _buildDrawerTile(
                  'Attendance',
                  Icons.calendar_month_sharp,
                  () => MethodButton2(),
                  index: 24,
                  fontSize: fontSizeBody,
                  iconSize: iconSize,
                ),
                PolicySetup(),
                ReportPolicy(),
                Employeepolicy(),
                TableLeaveRequest(),
              ],
            ),
            if (isMobile)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1B2230),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      children: [
                        Obx(() {
                          final image = controller1.userprofiles.value?.image;
                          return CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                (image == null || image.isEmpty)
                                    ? AssetImage(
                                      'assets/images/profileuser.png',
                                    )
                                    : NetworkImage(image) as ImageProvider,
                          );
                        }),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() {
                            final profile = controller1.userprofiles.value;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  profile?.name ?? 'No Name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  profile?.role ?? 'No Role',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        IconButton(
                          icon: const Icon(Icons.logout, color: Colors.white),
                          onPressed: () => controller.logoutWithConfirmation(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox(double fontSize) {
    final HoverMouseController controller = Get.put(HoverMouseController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MouseHover(
        keyId: 19,
        controller: controller,
        child: TextField(
          style: TextStyle(color: Colors.white, fontSize: fontSize),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white70, fontSize: fontSize),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerTile(
    String title,
    IconData icon,
    VoidCallback? onTap, {
    int? index,
    double fontSize = 14,
    double iconSize = 18,
  }) {
    return Obx(() {
      final controller = Get.find<AppDrawerController>();
      final isSelected =
          index != null && controller.selectedIndex.value == index;
      return ListTile(
        leading: Icon(
          icon,
          size: iconSize,
          color:
              isSelected
                  ? controller.Selectedcolors
                  : controller.Unselectedcolors,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color:
                isSelected
                    ? controller.Selectedcolors
                    : controller.Unselectedcolors,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (index != null) controller.setSelected(index);
          onTap?.call();
        },
      );
    });
  }
}
