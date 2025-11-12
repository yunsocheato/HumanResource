import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Admin/Drawer/controllers/drawer_controller.dart';

class DrawerHead extends StatelessWidget implements PreferredSizeWidget {
  const DrawerHead({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 900;
    final bool showAppBar = isMobile || isTablet;
    final controller1 = Get.find<AppDrawerController>();

    if (showAppBar) {
      return AppBar(
        elevation: 8,
        shadowColor: Colors.grey.withOpacity(0.5),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
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
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
                height: 45 * 1.7,
                width: 45 * 1.7,
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
                      fontSize: 23,
                      color: Colors.blue.shade900,
                      fontFamily: '7TH.ttf',
                      fontWeight: FontWeight.bold,
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
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
