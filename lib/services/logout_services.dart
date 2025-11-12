import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient _client = Supabase.instance.client;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startAutoLogoutTimer();
  }

  void startAutoLogoutTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(minutes: 10), () async {
      await logout();
    });
  }

  void resetTimer() {
    startAutoLogoutTimer();
  }

  Future<void> logout() async {
    final client = Supabase.instance.client;
    await client.auth.signOut();
    await GetStorage().erase();
    Get.offAllNamed('/logout');
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // void logoutWithConfirmation() {
  //   final loadingUi = Get.put<LoadingUiController>(LoadingUiController());
  //   Get.defaultDialog(
  //     title: 'Logout?',
  //     middleText: 'Are you sure you want to log out?',
  //     textConfirm: 'Yes',
  //     textCancel: 'No',
  //     confirmTextColor: Get.isSnackbarOpen ? null : Colors.white,
  //     barrierDismissible: false,
  //     onConfirm: () async {
  //       Get.back();
  //
  //       loadingUi.beginLoading();
  //       Get.dialog(const LoadingScreen(), barrierDismissible: false);
  //
  //       await Future.delayed(const Duration(seconds: 2));
  //
  //       await _client.auth.signOut();
  //
  //       loadingUi.terminateLoading();
  //
  //       if (Get.isDialogOpen ?? false) {
  //         Get.back();
  //       }
  //       Get.offAllNamed('/login');
  //     },
  //     onCancel: () {
  //       Get.back();
  //     },
  //   );
  // }
}
