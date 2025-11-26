import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  static const String routeName = '/login';

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: controller.resizeToAvoidBottomInset,
      body: _buildResponsive(context, controller),
    );
  }

  Widget _buildResponsive(BuildContext context, LoginController controller) {
    double width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return _buildMobile(context, controller);
    } else if (width < 1024) {
      return _buildTablet(context, controller);
    } else if (width < 1440) {
      return _buildDesktop(context, controller);
    } else {
      return _buildLargeScreen(context, controller);
    }
  }

  Widget _buildMobile(BuildContext context, LoginController controller) {
    return _buildBaseLayout(
      context: context,
      controller: controller,
      containerWidth: MediaQuery.of(context).size.width * 0.9,
      logoSize: 60,
      padding: const EdgeInsets.all(20),
    );
  }

  Widget _buildTablet(BuildContext context, LoginController controller) {
    return _buildBaseLayout(
      context: context,
      controller: controller,
      containerWidth: 450,
      logoSize: 70,
      padding: const EdgeInsets.all(28),
    );
  }

  Widget _buildDesktop(BuildContext context, LoginController controller) {
    return _buildBaseLayout(
      context: context,
      controller: controller,
      containerWidth: 550,
      logoSize: 85,
      padding: const EdgeInsets.all(32),
    );
  }

  Widget _buildLargeScreen(BuildContext context, LoginController controller) {
    return _buildBaseLayout(
      context: context,
      controller: controller,
      containerWidth: 650,
      logoSize: 95,
      padding: const EdgeInsets.all(38),
    );
  }

  Widget _buildBaseLayout({
    required BuildContext context,
    required LoginController controller,
    required double containerWidth,
    required double logoSize,
    required EdgeInsets padding,
  }) {
    final size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: controller.animation,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.animation.value,
              child: Image.asset(
                'assets/images/team_banner.jpg',
                fit: BoxFit.cover,
              ),
            );
          },
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black54, Colors.black87],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Center(
          child: Container(
            width: containerWidth,
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.96),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChimeBellText(
                      text: controller.loginText,
                      duration: controller.AnimatedDuration,
                      textStyle: controller.AnimatedLoginStyle,
                      type: controller.AnimationTypes,
                    ),
                    AnimatedBuilder(
                      animation: controller.blurAnimation,
                      builder: (context, child) {
                        return ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: controller.blurAnimation.value,
                            sigmaY: controller.blurAnimation.value,
                          ),
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/images/deamlogo.png',
                        height: logoSize,
                        width: logoSize,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                _buildTextFields(controller),
                const SizedBox(height: 25),
                _buildLoginButton(controller),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 40,
            color: Colors.blue.shade900,
            child: const Center(
              child: Text(
                '© 2025 DEAM COMPUTER INTERNATIONAL PLT — All Rights Reserved',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFields(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email Address',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.emailController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email, color: Colors.blue),
            filled: true,
            fillColor: Colors.blue.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller.passwordController,
            obscureText: !controller.isVisible.value,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock, color: Colors.blue),
              filled: true,
              fillColor: Colors.blue.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.blue.shade900,
                ),
                onPressed:
                    () =>
                        controller.isVisible.value =
                            !controller.isVisible.value,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(LoginController controller) {
    return Obx(() {
      return Column(
        children: [
          SizedBox(height: 5),
          InkWell(
            onTap: () {
              showAwesomeSnackBarGetx(
                'Development',
                'We are sorry this feature is still in Development modes',
                ContentType.warning,
              );
            },
            child: Text(
              'Are you forgot password?',
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed:
                  controller.isLoading.value ? null : () => controller.login(),
              child:
                  controller.isLoading.value
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/deamlogo.png',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'please wait',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                '...',
                                textStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                speed: Duration(milliseconds: 150),
                              ),
                            ],
                          ),
                        ],
                      )
                      : const Text(
                        'Login to Dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
            ),
          ),

          if (controller.isLoading.value) ...[
            const SizedBox(height: 15),
            Obx(
              () => LinearProgressIndicator(
                value: controller.progressValue.value,
                minHeight: 4,
                color: Colors.blue.shade900,
                backgroundColor: Colors.blue.shade100,
              ),
            ),
          ],
        ],
      );
    });
  }
}
