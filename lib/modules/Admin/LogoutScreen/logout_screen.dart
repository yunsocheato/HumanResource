import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});
  static const routeName = '/logout';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024 && screenWidth < 1440;
    bool isLargeDesktop = screenWidth >= 1440;

    double containerWidth =
        isMobile
            ? screenWidth * 0.9
            : isTablet
            ? screenWidth * 0.6
            : isDesktop
            ? screenWidth * 0.35
            : screenWidth * 0.25;

    double containerHeight =
        isMobile
            ? screenHeight * 0.45
            : isTablet
            ? 400
            : 350;

    double fontSizeTitle = isMobile ? 18 : 20;
    double fontSizeNote = isMobile ? 11 : 13;
    double imageSize = isMobile ? 80 : 100;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.pink.shade500.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icon/logout.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'You are Logout Successful',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Note: All data and cache will be deleted after logout.',
                  style: TextStyle(
                    fontSize: fontSizeNote,
                    color: Colors.black54,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.offAllNamed('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: isMobile ? 10 : 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: Text(
                    'Return to Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 14 : 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
