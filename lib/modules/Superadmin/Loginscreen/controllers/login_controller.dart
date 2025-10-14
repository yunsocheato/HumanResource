import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../../Dashboard/views/dashboard_screen.dart';
import '../services/login_service.dart';
import '../views/login_screen.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  var Loading = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var isLogin = false.obs;
  var isPassword = true.obs;
  var isVisible = false.obs;
  late AnimationController controller1;
  late Animation<double> blurAnimation;

  void login() async {
    Loading.value = 'Loading...';

    Get.find<LoadingUiController>().beginLoading();

    try {
      final result = await LoginService().loginWithEmail(
        email: email.value,
        password: password.value,
      );

      final role = result['role'];

      isLogin.value = true;
      Loading.value = 'Success Login';

      if (role == 'admin') {
        await Future.delayed(const Duration(seconds: 5));
        Get.find<LoadingUiController>().terminateLoading();
        Get.to(() => DashboardScreen());
      } else {
        await Future.delayed(const Duration(seconds: 6));
        Get.find<LoadingUiController>().terminateLoading();
        Loading.value = 'Only admin can login.';
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 6));
      Get.find<LoadingUiController>().terminateLoading();
      Get.to(() => LoginScreen());
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
