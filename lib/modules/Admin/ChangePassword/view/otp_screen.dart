import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/verification_controller.dart';

class OTPScreen extends GetView<VerificationController> {
  OTPScreen({super.key});

  static const String routeName = '/otp';

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    final c = controller;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/overview');
          },
          icon: Icon(Icons.arrow_back, color: Colors.blue),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.blue)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          bool isMobile = width < 600;
          bool isTablet = width >= 600 && width < 1024;
          bool isDesktop = width >= 1024 && width < 1400;
          bool _ = width >= 1400;

          double outerHeight =
              isMobile
                  ? 300
                  : isTablet
                  ? 450
                  : isDesktop
                  ? 400
                  : 400;
          double outerWidth =
              isMobile
                  ? 350
                  : isTablet
                  ? 350
                  : isDesktop
                  ? 400
                  : 450;
          double imageSize =
              isMobile
                  ? 250
                  : isTablet
                  ? 350
                  : isDesktop
                  ? 450
                  : 550;
          double innerPadding = isMobile ? 16 : 32;

          return Obx(
            () =>
                c.isOtpSent.value
                    ? Center(
                      child:
                          isMobile
                              ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/otp.png',
                                      width: imageSize,
                                      height: imageSize,
                                    ),
                                    Container(
                                      height: outerHeight,
                                      width: outerWidth,
                                      padding: EdgeInsets.all(innerPadding),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.7),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: _buildOtpContent(c),
                                    ),
                                  ],
                                ),
                              )
                              : Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/otp.png',
                                            width: imageSize,
                                            height: imageSize,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Material(
                                      color: Colors.blue[100],
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: outerHeight,
                                          width: outerWidth,
                                          padding: EdgeInsets.all(innerPadding),
                                          constraints: BoxConstraints(
                                            maxWidth: outerWidth,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blue.withOpacity(
                                                  0.7,
                                                ),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: _buildOtpContent(c),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                    )
                    : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildOtpContent(VerificationController c) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'OTP\nVERIFICATION',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: '7TH.ttf',
            color: Colors.blue[900],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Enter OTP sent to your email ${controller.maskEmail(controller.emailController.text)}',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 50,
              child: TextField(
                controller: controller.otpControllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: const InputDecoration(counterText: ''),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    focusNodes[index + 1].requestFocus();
                  }
                  if (value.isEmpty && index > 0) {
                    focusNodes[index - 1].requestFocus();
                  }
                },
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed:
                  () =>
                      c.isLoading.value
                          ? CircularProgressIndicator(
                            color: Colors.red.shade900,
                            strokeWidth: 2,
                          )
                          : c.resendopt(),
              style: TextButton.styleFrom(
                minimumSize: const Size(50, 50),
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Resend Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed:
                  () =>
                      c.isLoading.value
                          ? CircularProgressIndicator(
                            color: Colors.blue.shade900,
                            strokeWidth: 2,
                          )
                          : c.verifyOtp(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(50, 50),
                backgroundColor: Colors.blue.shade800,
              ),
              child: const Text(
                'Verify Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
