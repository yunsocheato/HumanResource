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
import '../../Notification/view/notification_screen.dart';
import '../../SettingScreen/view/setting_screen_Desktop.dart';
import '../controllers/drawer_controller.dart';
import '../widgets/Method_drawer_policy_button.dart';
import '../widgets/drawer_employee_policy.dart';
import '../widgets/drawer_leave_request.dart';
import '../widgets/drawer_policy_setup.dart';
import '../widgets/drawer_reports_policy.dart';
import 'drawer_header_admin.dart';
import 'overview_screen_admin.dart';

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
        double iconSize1 = 32;
        double avatarRadius;

        if (isMobile) {
          sidebarWidth = 200;
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 12;
          avatarRadius = 35;
        } else if (isTablet) {
          sidebarWidth = 200;
          fontSizeTitle = 16;
          fontSizeBody = 13;
          iconSize = 24;
          avatarRadius = 22;
        } else if (isDesktop) {
          sidebarWidth = 230;
          fontSizeTitle = 10;
          fontSizeBody = 10;
          iconSize = 15;
          avatarRadius = 21;
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
        final isUserRoles = true;
        return Scaffold(
          appBar:
              isMobile || isTablet
                  ? null
                  : AppBar(
                    toolbarHeight: 65,
                    title: Row(
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
                            height: avatarRadius * 1.7,
                            width: avatarRadius * 1.7,
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
                      NotificationScreen(roles: ['admin', 'superadmin']),
                      const SizedBox(width: 10),
                      if (!isMobile)
                        MouseHover(
                          keyId: 21,
                          controller: controller2,
                          child: IconButton(
                            icon: Image.asset(
                              'assets/icon/log-out.png',
                              height: 32,
                              width: 32,
                            ),
                            onPressed: () {
                              controller.logout();
                            },
                          ),
                        ),
                    ],
                  ),
          body: Stack(
            children: [
              Row(
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
              if ((isMobile || isTablet) && isUserRoles)
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: const DrawerHead1(),
                ),
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
            OverviewAdmin(),
            _buildDrawerTile(
              'Admin Dashboard',
              'assets/icon/home.png',
              () => MethodButton18(),
              index: 24,
              fontSize: fontSizeBody,
            ),
            _buildDrawerTile(
              'Mange Attendance User',
              'assets/icon/calendars.png',
              () => MethodButton2(),
              index: 1,
              fontSize: fontSizeBody,
            ),
            PolicySetup(),
            ReportPolicy(),
            Employeepolicy(),
            TableLeaveRequest(),
            _buildDrawerTile(
              'Manage Setting',
              'assets/icon/setting.png',
              () => DialogScreen(context, SettingScreen()),
              index: 23,
              fontSize: fontSizeBody,
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
    String imagePath,
    VoidCallback? onTap, {
    int? index,
    double fontSize = 14,
    double imageSize = 22,
  }) {
    return Obx(() {
      final controller = Get.find<AppDrawerController>();
      final isSelected =
          index != null && controller.selectedIndex.value == index;
      final isMobile = Get.width < 600;
      return ListTile(
        leading: Image.asset(imagePath, width: imageSize, height: imageSize),
        title: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color:
                isSelected
                    ? controller.Selectedcolors
                    : (isMobile ? Colors.blue : controller.Unselectedcolors),
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

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../Core/user_profile_controller.dart';
// import '../../../../services/logout_services.dart';
// import '../../Notification/view/notification_screen.dart';
// import '../controllers/drawer_controller.dart';
// import '../widgets/Method_drawer_policy_button.dart';
// import '../widgets/drawer_employee_policy.dart';
// import '../widgets/drawer_leave_request.dart';
// import '../widgets/drawer_policy_setup.dart';
// import '../widgets/drawer_reports_policy.dart';
// import 'drawer_header_admin.dart';
// import 'overview_screen_admin.dart';
//
// class Drawerscreen extends GetView<AppDrawerController> {
//   final Widget content;
//   const Drawerscreen({super.key, required this.content});
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.maxWidth;
//
//         // Determine screen type
//         final isMobile = width < 600;
//         final isTablet = width >= 600 && width < 1024;
//         final isDesktop = width >= 1024 && width < 2560;
//         final isLargeDesktop = width >= 2560;
//
//         // Sidebar & font sizing
//         double sidebarWidth =
//             isMobile
//                 ? 240
//                 : isTablet
//                 ? 200
//                 : isDesktop
//                 ? 230
//                 : 360;
//         double fontSizeTitle =
//             isMobile
//                 ? 15
//                 : isTablet
//                 ? 16
//                 : isDesktop
//                 ? 18
//                 : 22;
//         double fontSizeBody =
//             isMobile
//                 ? 12
//                 : isTablet
//                 ? 12
//                 : isDesktop
//                 ? 12
//                 : 12;
//         double avatarRadius =
//             isMobile
//                 ? 35
//                 : isTablet
//                 ? 22
//                 : isDesktop
//                 ? 28
//                 : 32;
//
//         final authController = Get.find<AuthController>();
//         final userController = Get.find<UserProfileController>();
//         final drawerController = Get.find<AppDrawerController>();
//
//         final role =
//             userController.userprofiles.value?.role.toLowerCase() ?? '';
//         final isUserRoles = role == 'admin' || role == 'superadmin';
//
//         return Scaffold(
//           appBar:
//               isMobile || isTablet
//                   ? null
//                   : AppBar(
//                     toolbarHeight: 65,
//                     backgroundColor: const Color(0xFF242C40),
//                     title: Row(
//                       children: [
//                         Image.asset(
//                           'assets/images/deamlogo.png',
//                           height: avatarRadius * 1.7,
//                           width: avatarRadius * 1.7,
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'DEAM COMPUTER INTERNATIONAL',
//                           style: TextStyle(
//                             fontSize: fontSizeTitle,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ],
//                     ),
//                     actions: [
//                       NotificationScreen(roles: ['admin', 'superadmin']),
//                       IconButton(
//                         icon: const Icon(Icons.logout, color: Colors.white),
//                         onPressed: () => authController.logout(),
//                       ),
//                     ],
//                   ),
//           drawer:
//               (isMobile || isTablet)
//                   ? Drawer(
//                     child: _buildSidebarMobile(
//                       fontSizeTitle,
//                       fontSizeBody,
//                       avatarRadius,
//                       sidebarWidth,
//                     ),
//                   )
//                   : null,
//           body: Stack(
//             children: [
//               Row(
//                 children: [
//                   if (!isMobile)
//                     SizedBox(
//                       width: sidebarWidth,
//                       child: _buildSidebarOtherResponsive(
//                         fontSizeTitle,
//                         fontSizeBody,
//                         avatarRadius,
//                         sidebarWidth,
//                       ),
//                     ),
//                   Expanded(child: content),
//                 ],
//               ),
//               if ((isMobile || isTablet) && isUserRoles)
//                 Positioned(
//                   top: 20,
//                   left: 0,
//                   right: 0,
//                   child: const DrawerHead1(),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildSidebarOtherResponsive(
//     double fontSizeTitle,
//     double fontSizeBody,
//     double avatarRadius,
//     double sidebarWidth,
//   ) {
//     return SafeArea(
//       child: Container(
//         width: sidebarWidth,
//         color: const Color(0xFF1B2230),
//         child: ListView(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           children: [
//             OverviewAdmin(),
//             _buildDrawerTile(
//               'Admin Dashboard',
//               'assets/icon/home.png',
//               () => MethodButton18(),
//               fontSize: fontSizeBody,
//             ),
//             _buildDrawerTile(
//               'Manage Attendance User',
//               'assets/icon/calendars.png',
//               () => MethodButton2(),
//               fontSize: fontSizeBody,
//             ),
//             PolicySetup(),
//             ReportPolicy(),
//             Employeepolicy(),
//             TableLeaveRequest(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSidebarMobile(
//     double fontSizeTitle,
//     double fontSizeBody,
//     double avatarRadius,
//     double sidebarWidth,
//   ) {
//     final authController = Get.find<AuthController>();
//     final userController = Get.find<UserProfileController>();
//
//     return SafeArea(
//       child: Container(
//         width: sidebarWidth,
//         color: const Color(0xFF1B2230),
//         child: Stack(
//           children: [
//             ListView(
//               padding: const EdgeInsets.only(bottom: 120, top: 15),
//               children: [
//                 DrawerHeader(
//                   decoration: const BoxDecoration(color: Color(0xFF1B2230)),
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         'assets/images/deamlogo.png',
//                         height: avatarRadius * 2,
//                         width: avatarRadius * 2,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         'DEAM COMPUTER\nINTERNATIONAL',
//                         style: TextStyle(
//                           fontSize: fontSizeBody,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 OverviewAdmin(),
//                 _buildDrawerTile(
//                   'Admin Dashboard',
//                   'assets/icon/home.png',
//                   () => MethodButton18(),
//                   fontSize: fontSizeBody,
//                 ),
//                 _buildDrawerTile(
//                   'Manage Attendance User',
//                   'assets/icon/calendars.png',
//                   () => MethodButton2(),
//                   fontSize: fontSizeBody,
//                 ),
//                 PolicySetup(),
//                 ReportPolicy(),
//                 Employeepolicy(),
//                 TableLeaveRequest(),
//               ],
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 90,
//                 color: const Color(0xFF1B2230),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//                 child: Row(
//                   children: [
//                     Obx(() {
//                       final image = userController.userprofiles.value?.image;
//                       return CircleAvatar(
//                         radius: 25,
//                         backgroundImage:
//                             (image == null || image.isEmpty)
//                                 ? const AssetImage(
//                                   'assets/images/profileuser.png',
//                                 )
//                                 : NetworkImage(image) as ImageProvider,
//                       );
//                     }),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Obx(() {
//                         final profile = userController.userprofiles.value;
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               profile?.name ?? 'No Name',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 13,
//                               ),
//                             ),
//                             Text(
//                               profile?.role ?? 'No Role',
//                               style: const TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.logout, color: Colors.white),
//                       onPressed: () => authController.logout(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerTile(
//     String title,
//     String imagePath,
//     VoidCallback onTap, {
//     double fontSize = 14,
//   }) {
//     return ListTile(
//       leading: Image.asset(imagePath, width: 22, height: 22),
//       title: Text(
//         title,
//         style: TextStyle(fontSize: fontSize, color: Colors.white),
//       ),
//       onTap: onTap,
//     );
//   }
// }
