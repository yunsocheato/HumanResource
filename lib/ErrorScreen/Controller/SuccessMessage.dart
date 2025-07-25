import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessMesage extends GetxController{
  final RxString success = ''.obs;
  Future<void> buildSuccessMessages() {
    return Get.dialog(
      Center(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white.withOpacity(0.7),
          title: const Text('Success'),
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 50),
          content: Text(success.value),
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
        )
    );
  }
}