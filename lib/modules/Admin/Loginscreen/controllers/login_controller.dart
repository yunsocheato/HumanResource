import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import '../../../../Permission/Permission.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../../../../services/login_service.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var Loading = ''.obs;
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var isLogin = false.obs;
  var isPassword = true.obs;
  var isVisible = false.obs;
  late AnimationController controller1;
  late Animation<double> blurAnimation;
  final context = Get.context;
  final resizeToAvoidBottomInset = false;
  late bool isMobile;

  final progressValue = 0.0.obs;
  final loginText = 'D E A M HR';
  final AnimatedDuration = const Duration(seconds: 2);
  final AnimatedLoginStyle = TextStyle(
    fontSize: 30,
    color: Colors.blue.shade900,
    fontWeight: FontWeight.bold,
    fontFamily: '7TH.ttf',
    shadows: <Shadow>[
      Shadow(
        offset: Offset(5.0, 5.0),
        blurRadius: 3.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      Shadow(
        offset: Offset(10.0, 10.0),
        blurRadius: 8.0,
        color: Color.fromARGB(125, 0, 0, 255),
      ),
    ],
  );
  final AnimationTypes = AnimationType.word;
  late AnimationController controller;
  late Animation<double> animation;

  Future<void> login() async {
    progressValue.value = 0.0;

    Loading.value = 'Loading...';
    Get.find<LoadingUiController>().beginLoading();

    try {
      progressValue.value = 0.25;

      final result = await LoginService().loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      progressValue.value = 0.60;

      final UserRole role = result['role'];

      isLogin.value = true;
      Loading.value = 'Success Login';

      progressValue.value = 1.0;
      Get.find<LoadingUiController>().terminateLoading();

      await Future.delayed(const Duration(milliseconds: 300));

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
          break;
      }
    } catch (e) {
      Get.find<LoadingUiController>().terminateLoading();

      progressValue.value = 0.0;
      Loading.value = e.toString();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx('Error', e.toString(), ContentType.failure);
      });
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
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    animation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    controller1.dispose();
    controller.dispose();
    super.dispose();
  }
}
