import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/verification_controller.dart';

class EmailVerifyScreen extends GetView<VerificationController> {
  const EmailVerifyScreen({super.key});

  static const String routeName = '/email_verify';

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
                  ? 350
                  : 600;
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

          return SafeArea(
            child:
                isMobile
                    ? SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Email\nVerification',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: '7TH.ttf',
                              color: Colors.blue[900],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Note:\nDo not Share your OTP code with another',
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/images/email_verify.png',
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.contain,
                          ),
                          Obx(
                            () => TextField(
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                suffixIcon:
                                    controller.isLoading.value
                                        ? const CircularProgressIndicator(
                                          color: Colors.blue,
                                          strokeWidth: 2,
                                        )
                                        : InkWell(
                                          onTap: () {
                                            if (controller
                                                .isOtpVerified
                                                .value) {
                                              return;
                                            }

                                            controller.sendOtp();
                                          },
                                          child: const Icon(
                                            Icons.send,
                                            color: Colors.blue,
                                          ),
                                        ),
                                labelText: 'Your email',
                                border: const OutlineInputBorder(),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/email_verify.png',
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
                                child: _buildEmailVerifyContent(c),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
          );
        },
      ),
    );
  }

  Widget _buildEmailVerifyContent(VerificationController c) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email\nVerification',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: '7TH.ttf',
            color: Colors.blue[900],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Note:\nDo not Share your OTP code with another',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),
        TextField(
          controller: c.emailController,
          decoration: InputDecoration(
            suffixIcon:
                c.isLoading.value
                    ? const CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 2,
                    )
                    : InkWell(
                      onTap: () {
                        if (c.isOtpVerified.value) return;

                        c.sendOtp();
                      },
                      child: const Icon(Icons.send, color: Colors.blue),
                    ),
            labelText: 'Your email',
            border: const OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
