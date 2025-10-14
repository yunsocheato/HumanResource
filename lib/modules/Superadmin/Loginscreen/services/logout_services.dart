import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../Utils/Loadingui/Loading_Screen.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../views/login_screen.dart';

class AuthController extends GetxController {
  final SupabaseClient _client = Supabase.instance.client;
  void logoutWithConfirmation() {
    final loadingUi = Get.put<LoadingUiController>(LoadingUiController());

    Get.defaultDialog(
      title: 'Logout?',
      middleText: 'Are you sure you want to log out?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Get.isSnackbarOpen ? null : Colors.white,
      barrierDismissible: false,
      onConfirm: () async {
        Get.back();

        loadingUi.beginLoading();
        Get.dialog(const LoadingScreen(), barrierDismissible: false);

        await Future.delayed(const Duration(seconds: 2));

        await _client.auth.signOut();

        loadingUi.terminateLoading();

        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        Get.offAll(() => const LoginScreen());
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
