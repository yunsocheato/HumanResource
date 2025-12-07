import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkError extends GetxController {
  final RxString error = ''.obs;
  final RxString slow = ''.obs;
  final RxString DataLimit = ''.obs;
  final RxBool isChecking = false.obs;

  Future<void> ErrorNetwork() async {
    await Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white.withOpacity(0.7),
        title: const Text(
          'ERROR!',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.error, color: Colors.red, size: 50),
        content: Text(error.value),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Try again'),
          ),
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ],
      ),
    );
  }
}
