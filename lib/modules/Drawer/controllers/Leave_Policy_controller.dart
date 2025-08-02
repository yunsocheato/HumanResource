import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeavePolicyController extends GetxController {
  final isSwitched1 = false.obs;
  final isSwitched2 = false.obs;
  final isSwitched3 = false.obs;

  final blockAnualleave = false.obs;
  final blockSickleave = false.obs;
  final blockVacationleave = false.obs;
  final blockOtherleave = false.obs;

  final isDeduction = false.obs;

  final isLoading = false.obs;

  final IconData icon = Icons.search ;
  final Color color = Colors.blue.shade900;

  final RxString LeaveType = ''.obs;
  final RxString Username = ''.obs;

  final RxString MonthlySalary = ''.obs;
  final RxString DailySalary = ''.obs;
  final Rx<int> isLeave= 0.obs;







  void submit() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.back();
  }
}