import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double logoSize;
    double titleFontSize;
    double subtitleFontSize;
    double progressWidth;

    if (size.width >= 1440) {
      logoSize = 200;
      titleFontSize = 48;
      subtitleFontSize = 20;
      progressWidth = size.width * 0.3;
    } else if (size.width >= 1024) {
      logoSize = 160;
      titleFontSize = 36;
      subtitleFontSize = 18;
      progressWidth = size.width * 0.4;
    } else if (size.width >= 768) {
      logoSize = 140;
      titleFontSize = 28;
      subtitleFontSize = 16;
      progressWidth = size.width * 0.5;
    } else {
      logoSize = 120;
      titleFontSize = 28;
      subtitleFontSize = 16;
      progressWidth = size.width * 0.7;
    }

    String subtitleText;

    if (kIsWeb) {
      subtitleText = 'Manage Attendance By Web App';
    } else if (size.width >= 1440) {
      subtitleText = 'Manage Attendance By Desktop App';
    } else if (size.width >= 1024) {
      subtitleText = 'Manage Attendance By Desktop App';
    } else if (size.width >= 768) {
      subtitleText = 'Manage Attendance By Mini App';
    } else {
      subtitleText = 'Manage Attendance By Mobile App';
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: logoSize,
              height: logoSize,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(logoSize * 0.25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Image.asset('assets/images/deamlogo.png'),
            ),

            SizedBox(height: size.height * 0.03),
            Text(
              'DEAM HR MOBILE',
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: size.height * 0.01),
            Text(
              subtitleText,
              style: TextStyle(
                color: Colors.white70,
                fontSize: subtitleFontSize,
              ),
            ),

            SizedBox(height: size.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.03,
              ),
              child: Obx(
                () => TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween(begin: 0, end: controller.progress.value),
                  builder: (context, value, _) {
                    return SizedBox(
                      width: progressWidth,
                      child: LinearProgressIndicator(
                        value: value,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
