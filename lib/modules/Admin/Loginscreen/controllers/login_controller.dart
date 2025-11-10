import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/view/overview_screen.dart';
import '../../../../Permission/Permission.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../../../../services/login_service.dart';
import '../../Dashboard/views/dashboard_screen.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var Loading = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var isLogin = false.obs;
  var isPassword = true.obs;
  var isVisible = false.obs;
  late AnimationController controller1;
  late Animation<double> blurAnimation;

  Future<void> login() async {
    Loading.value = 'Loading...';
    Get.find<LoadingUiController>().beginLoading();

    try {
      final result = await LoginService().loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final UserRole role = result['role'];

      isLogin.value = true;
      Loading.value = 'Success Login';

      Get.find<LoadingUiController>().terminateLoading();

      switch (role) {
        case UserRole.admin:
          Get.offAllNamed('/overview');
          break;
        case UserRole.adminDept:
          Get.offAllNamed('/overview');
          break;
        case UserRole.user:
          Get.offAllNamed('/overview');
          break;
        case UserRole.superadmin:
          Get.offAllNamed('/overview');
      }
    } catch (e) {
      Get.find<LoadingUiController>().terminateLoading();
      Loading.value = e.toString();
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void togglePasswordVisibility() {
    isVisible.value = !isVisible.value;
  }

  void togglePassword() {
    isPassword.value = !isPassword.value;
  }

  void toggleLogin() {
    isLogin.value = !isLogin.value;
  }

  @override
  void onInit() {
    super.onInit();

    controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    blurAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }
}
