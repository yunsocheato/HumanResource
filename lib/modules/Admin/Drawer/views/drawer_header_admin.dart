import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../Notification/view/notification_screen.dart';
import '../controllers/drawer_controller.dart';

class DrawerHead1 extends StatelessWidget implements PreferredSizeWidget {
  const DrawerHead1({super.key});

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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  Future.microtask(() => Get.offAllNamed('/menu_admin'));
                },
                icon: const Icon(
                  Icons.dashboard_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'DEAM HR',
                    textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
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
            Row(
              children: [
                NotificationScreen(roles: ['user']),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900.withOpacity(0.7),
                    shape: const CircleBorder(),
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
