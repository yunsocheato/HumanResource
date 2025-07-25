import 'package:get/get.dart';
import 'package:hrms/modules/Loginscreen/views/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../Loadingui/Loading_Screen.dart';
import '../../../Loadingui/loading_controller.dart';
import '../../Dashboard/views/dashboard_screen.dart';
import '../services/login_service.dart';

class LoginController extends GetxController {
  var Loading = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var isLogin = false.obs;
  var isPassword = true.obs;
  var isVisible = false.obs;

  final SupabaseClient _client = Supabase.instance.client;

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
        Get.find<LoadingUiController>().terminateLoading(); // ✅ hide loader
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


}
