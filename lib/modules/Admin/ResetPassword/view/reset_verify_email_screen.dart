import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/reset_password_verificationcontroller.dart';

class resetverification extends GetView<ResetPasswordController> {
  const resetverification({super.key});

  static const String routeName = '/email_verify_reset';

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/login');
          },
          icon: Icon(Icons.arrow_back, color: Colors.orange),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.orange)),
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
                              color: Colors.orange[900],
                            ),
                          ),
                          Image.asset(
                            'assets/images/forgotscreen.png',
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'Note:\nCheck your code in your mailbox\nDo not share the code with another',
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

                                          c.sendEmailOTP();
                                        },
                                        child: const Icon(
                                          Icons.send,
                                          color: Colors.orange,
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
                                  'assets/images/forgotscreen.png',
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
                            color: Colors.orange[100],
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
                                      color: Colors.orange.withOpacity(0.7),
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

  Widget _buildEmailVerifyContent(ResetPasswordController c) {
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
            color: Colors.orange[900],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Note:\nCheck your code in your mailbox\nDo not share the code with another',
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

                        c.sendEmailOTP();
                      },
                      child: const Icon(Icons.send, color: Colors.orange),
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
