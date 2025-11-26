import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Admin/ChangePassword/controller/verification_controller.dart';

class EmailVerifyScreen extends GetView<VerificationController> {
  const EmailVerifyScreen({super.key});

  static const String routeName = '/email_verify';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobile();
        } else if (constraints.maxWidth < 900) {
          return _buildTablet();
        } else if (constraints.maxWidth < 1400) {
          return _buildDesktop();
        } else {
          return _buildLargeScreen();
        }
      },
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.offAllNamed('/overview'),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Center(child: _buildBody(height: 400, width: 450)),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.offAllNamed('/overview'),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Center(
        child: SizedBox(
          height: 150,
          width: 300,
          child: _buildBody(height: 150, width: 300),
        ),
      ),
    );
  }

  Widget _buildDesktop() {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.offAllNamed('/overview'),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Center(
        child: SizedBox(width: 500, child: _buildBody(height: 400, width: 650)),
      ),
    );
  }

  Widget _buildLargeScreen() {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.offAllNamed('/overview'),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Center(
        child: SizedBox(width: 500, child: _buildBody(height: 400, width: 650)),
      ),
    );
  }

  Widget _buildBody({required double width, required double height}) {
    final c = controller;
    return Obx(() {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/deamlogo.png',
                    width: 100,
                    height: 100,
                  ),
                  Image.asset(
                    'assets/images/supabase.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Note:\nPlease put your email for sending OTP CODE\nDont share your otp code to another',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: c.emailController,
                hintText: 'Your Email',
                suffix:
                    c.isLoading.value
                        ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                        : InkWell(
                          onTap: () {
                            if (c.isOtpVerified.value) return;

                            c.sendOtp();
                          },
                          child: const Icon(Icons.send, color: Colors.white),
                        ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.blue, fontSize: 16),
          filled: true,
          fillColor: Colors.blue.shade800,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
