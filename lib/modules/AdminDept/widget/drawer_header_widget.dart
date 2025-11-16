import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Admin/Drawer/controllers/drawer_controller.dart';
import '../../Admin/Notification/view/notification_screen.dart';

class DrawerHead extends StatelessWidget implements PreferredSizeWidget {
  const DrawerHead({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 900;
    final bool isDesktop = screenWidth >= 900 && screenWidth < 1200;
    final bool isLargeDesktop = screenWidth >= 1200;

    final bool showAppBar = isMobile || isTablet;
    final drawerController = Get.find<AppDrawerController>();

    double logoSize =
        isMobile
            ? 30
            : isTablet
            ? 30
            : isDesktop
            ? 30
            : 30;
    double fontSize =
        isMobile
            ? 12
            : isTablet
            ? 14
            : isDesktop
            ? 16
            : 18;

    if (showAppBar) {
      return AppBar(
        elevation: 8,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        leading: Builder(
          builder:
              (context) => InkWell(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/deamlogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(EneftyIcons.calendar_3_bold, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  EneftyIcons.notification_bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: drawerController.blurAnimation,
                  builder: (context, child) {
                    return ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: drawerController.blurAnimation.value,
                        sigmaY: drawerController.blurAnimation.value,
                      ),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/images/deamlogo.png',
                    height: logoSize * 1.5,
                    width: logoSize * 1.5,
                  ),
                ),

                const SizedBox(width: 12),

                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'DEAM COMPUTER\nINTERNATIONAL',
                        textStyle: TextStyle(
                          fontSize: fontSize,
                          color: Colors.blue.shade900,
                          fontFamily: '7TH.ttf',
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 100,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              NotificationScreen(roles: ['user']),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900.withOpacity(0.7),
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.blue.shade900, width: 1),
                  ),
                  elevation: 25,
                  shadowColor: Colors.grey,
                ),
                onPressed: () {},
                child: const Icon(
                  Icons.calendar_month,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
