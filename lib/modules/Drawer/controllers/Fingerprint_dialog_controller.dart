import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FingerprintDialogController extends GetxController {
  final isSwitched1 = false.obs;
  final isSwitched2 = false.obs;
  final isSwitched3 = false.obs;

  final isLoading = false.obs;

  final RxString LeaveType = ''.obs;
  final RxString Username = ''.obs;


  final TextEditingController Text1 = TextEditingController();
  final TextEditingController Text2 = TextEditingController();



  void submit() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.back();
  }
}