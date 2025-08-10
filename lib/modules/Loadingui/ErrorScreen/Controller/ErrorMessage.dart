import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrormessageController extends GetxController {
  final RxString error = ''.obs;

  Future<void> buildErrorMessages() {
    return Get.dialog(
      Center(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white.withOpacity(0.7),
          title: const Text('ERROR!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          icon: const Icon(Icons.error, color: Colors.red, size: 50),
          content: Text(error.value),
          contentPadding: const EdgeInsets.all(16),

          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
