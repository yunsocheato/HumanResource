import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Dashboard/views/dashboard_screen.dart';
import '../../Loadingui/ErrorScreen/Controller/ErrorMessage.dart';
import '../../Loadingui/loading_controller.dart';
import '../../Network/Method/method_internet_connection.dart';
import '../services/login_service.dart';

class LoginCardController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService loginService = LoginService();
  final Error = Get.put<ErrormessageController>( ErrormessageController());
  final loadingUi = Get.put<LoadingUiController>( LoadingUiController());
  final Nointernetmethod CheckingEnternetError =  Nointernetmethod();

  RxBool hide = true.obs;
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;
  RxBool showLoginCard = false.obs;

  final error = Rx<String?>(null);

  Future<void> login() async {
    final loadingUi = Get.find<LoadingUiController>();

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    loadingUi.beginLoading();

    try {
      await checkServer();
      final result = await loginService.loginWithEmail(
        email: email,
        password: password,
      );

      final role = result['role'];

      if (role != 'admin') {
        error.value = 'ACCESS DENIED 404';
        Error.buildErrorMessages();
        return;
      }

      Get.offAll(() => const DashboardScreen());
    } catch (e) {
      error.value = 'Error: $e';
      Error.buildErrorMessages();
    } finally {
      loadingUi.terminateLoading();
    }
  }

  Future<bool> checkServer() async {
    try {
      final response = await http.get(Uri.parse('http://172.20.20.98')).timeout(Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 500), () {
      checkServer();
      showLoginCard.value = true;
    });
    }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
