import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../modules/Superadmin/Dashboard/views/dashboard_screen.dart';
import '../../../modules/Superadmin/Loginscreen/views/login_screen.dart';

class SplashController extends GetxController {
  final SupabaseClient client = Supabase.instance.client;
  bool get isAuthenticated => client.auth.currentSession != null;

  final progress = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    for (int i = 1; i <= 20; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      progress.value = i / 20;
    }

    if (isAuthenticated) {
      Get.offAllNamed(DashboardScreen.routeName);
    } else {
      Get.offAllNamed(LoginScreen.routeName);
    }
  }
}
