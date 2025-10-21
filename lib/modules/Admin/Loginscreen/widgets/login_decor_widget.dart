import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../../../../Utils/Loadingui/Loading_Screen.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../controllers/login_card_controller.dart';
import '../controllers/login_controller.dart';

class LoginCard extends GetView<LoginCardController> {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: _buildLoginCard(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildforMobile() : _buildforLargeDevices();
  }

  Widget _buildforLargeDevices() {
    final controller = Get.put(LoginCardController());
    final logincontroller = Get.find<LoginController>();
    final controller1 = Get.find<LoginController>();
    final loadingUi = Get.find<LoadingUiController>();
    final context = Get.context!;

    return Obx(() {
      if (loadingUi.isLoading.value) {
        return const Center(child: LoadingScreen());
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.6,
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(height: 5),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'DEAM COMPUTER INTERNATIONAL',
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: '7TH.ttf',
                        ),
                      ),
                    ],
                    totalRepeatCount: 100,
                    pause: Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Login to access Dashboard',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontFamily: 'DODG5.ttf',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: logincontroller.emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () => TextFormField(
                      controller: logincontroller.passwordController,
                      obscureText: controller.hide.value,
                      onFieldSubmitted: (_) => logincontroller.login(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.hide.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.blue.shade900,
                          ),
                          onPressed: () {
                            controller.hide.value = !controller.hide.value;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              value: controller.rememberMe.value,
                              onChanged:
                                  (val) =>
                                      controller.rememberMe.value =
                                          val ?? false,
                            ),
                            const Text(
                              'Remember Me',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const TextButton(
                        onPressed: null,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () =>
                        controller.isLoading.value
                            ? const LoadingScreen()
                            : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: logincontroller.login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade900,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.login,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                label: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildforMobile() {
    final context = Get.context!;
    final logincontroller = Get.find<LoginController>();
    final controller1 = Get.find<LoginController>();
    final controller = Get.put(LoginCardController());
    final loadingUi = Get.find<LoadingUiController>();
    final HoverMouseController controller2 = Get.put(HoverMouseController());

    return Obx(() {
      if (loadingUi.isLoading.value) {
        return const Center(child: LoadingScreen());
      }

      return MouseHover(
        keyId: 13,
        controller: controller2,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(maxWidth: 800),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'DEAM COMPUTER\nINTERNATIONAL',
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: '7TH.ttf',
                                  ),
                                ),
                              ],
                              totalRepeatCount: 100,
                              pause: Duration(milliseconds: 1000),
                              displayFullTextOnTap: true,
                            ),
                            SizedBox(width: 15),
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
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: const Text(
                          'Login to access Dashboard',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                            fontFamily: 'DODG5.ttf',
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: logincontroller.emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Obx(
                        () => TextFormField(
                          controller: logincontroller.passwordController,
                          obscureText: controller.hide.value,
                          onFieldSubmitted: (_) => logincontroller.login(),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.hide.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.blue.shade900,
                              ),
                              onPressed: () {
                                controller.hide.value = !controller.hide.value;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Obx(
                              () => Row(
                                children: [
                                  Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged:
                                        (val) =>
                                            controller.rememberMe.value =
                                                val ?? false,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Remember Me',
                                      style: TextStyle(fontSize: 14),
                                      overflow:
                                          TextOverflow
                                              .ellipsis, // prevents overflow
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: null,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Obx(
                          () =>
                              controller.isLoading.value
                                  ? LoadingScreen()
                                  : SizedBox(
                                    width: 200,
                                    child: ElevatedButton.icon(
                                      onPressed: logincontroller.login,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade900,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),

                                      icon: const Icon(
                                        Icons.login,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      label: const Text(
                                        'Sign in',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
