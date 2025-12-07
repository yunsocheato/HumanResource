import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/verification_controller.dart';

class ChangePasswordScreen extends GetView<VerificationController> {
  const ChangePasswordScreen({super.key});
  static const String routeName = '/change_password';

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
                  ? 480
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

          return Obx(
            () =>
                c.isOtpSent.value
                    ? SafeArea(
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
                                      'CHANGE PASSWORD',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: '7TH.ttf',
                                        color: Colors.green[900],
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/changepass.png',
                                      width: imageSize,
                                      height: imageSize,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      'Your email:\n${c.maskEmail(c.emailController.text)} required change password',
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: c.oldpasswordController,
                                      obscureText: c.hide1.value,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            c.hide1.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed:
                                              () =>
                                                  c.hide1.value =
                                                      !c.hide1.value,
                                        ),
                                        labelText: 'Old Password',
                                        border: const OutlineInputBorder(),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextField(
                                      controller: c.newpasswordController,
                                      obscureText: c.hide2.value,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            c.hide2.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed:
                                              () =>
                                                  c.hide2.value =
                                                      !c.hide2.value,
                                        ),
                                        labelText: 'New Password',
                                        border: const OutlineInputBorder(),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextField(
                                      controller: c.retypepasswordController,
                                      obscureText: c.hide3.value,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            c.hide3.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed:
                                              () =>
                                                  c.hide3.value =
                                                      !c.hide3.value,
                                        ),
                                        labelText: 'Retype New Password',
                                        border: const OutlineInputBorder(),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          minimumSize: const Size(50, 50),
                                          backgroundColor:
                                              Colors.green.shade900,
                                        ),
                                        onPressed:
                                            () =>
                                                c.isLoading.value
                                                    ? CircularProgressIndicator(
                                                      color:
                                                          Colors.green.shade900,
                                                      strokeWidth: 2,
                                                    )
                                                    : c.changePassword(),
                                        child: const Text(
                                          'Change Password',
                                          style: TextStyle(color: Colors.white),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/changepass.png',
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
                                      color: Colors.green[100],
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
                                                color: Colors.green.withOpacity(
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
          'CHANGE PASSWORD',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: '7TH.ttf',
            color: Colors.green[900],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Your email:\n${c.maskEmail(c.emailController.text)}\nneed to change password',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: c.oldpasswordController,
          obscureText: c.hide1.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                c.hide1.value ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () => c.hide1.value = !c.hide1.value,
            ),
            labelText: 'Old Password',
            border: const OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: c.newpasswordController,
          obscureText: c.hide2.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                c.hide2.value ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () => c.hide2.value = !c.hide2.value,
            ),
            labelText: 'New Password',
            border: const OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: c.retypepasswordController,
          obscureText: c.hide3.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                c.hide3.value ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () => c.hide3.value = !c.hide3.value,
            ),
            labelText: 'Retype New Password',
            border: const OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(50, 50),
            backgroundColor: Colors.green.shade900,
          ),
          onPressed:
              () =>
                  c.isLoading.value
                      ? CircularProgressIndicator(
                        color: Colors.green.shade900,
                        strokeWidth: 2,
                      )
                      : c.changePassword(),
          child: const Text(
            'Change Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
