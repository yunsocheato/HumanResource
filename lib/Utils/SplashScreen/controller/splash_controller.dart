import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../Permission/Permission.dart';
import '../../../modules/Admin/Dashboard/views/dashboard_screen.dart';
import '../../../modules/Admin/Loginscreen/views/login_screen.dart';
import '../../../modules/AdminDept/view/overview_screen.dart';

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

    final session = client.auth.currentSession;

    if (session != null) {
      try {
        final userId = session.user.id;
        final roleResult =
            await client
                .from('signupuser')
                .select('role')
                .eq('user_id', userId)
                .maybeSingle();

        final roleString = roleResult?['role']?.toString().toLowerCase();
        final role = UserRoleExtension.fromString(roleString ?? '');

        if (role != null) {
          switch (role) {
            case UserRole.admin:
              Get.offAllNamed(DashboardScreen.routeName);
              break;
            case UserRole.adminDept:
              Get.offAllNamed(OverViewScreen.routeName);
              break;
            case UserRole.user:
              Get.offAllNamed(OverViewScreen.routeName);
              break;
          }
        } else {
          Get.offAllNamed(LoginScreen.routeName);
        }
      } catch (_) {
        Get.offAllNamed(LoginScreen.routeName);
      }
    } else {
      Get.offAllNamed(LoginScreen.routeName);
    }
  }
}
