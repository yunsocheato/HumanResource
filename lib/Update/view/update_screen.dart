import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/update_controller.dart';

class UpdateButtonScreen extends GetView<UpdateController> {
  const UpdateButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildButtonMobile();
  }

  Widget _buildButtonMobile() {
    final controller = Get.find<UpdateController>();
    final isMobile = Get.width < 600;
    return Obx(() {
      return controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
            onPressed: () {
              controller.GetUpdateFromGithubCode();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(45, 35),
              backgroundColor: Colors.black12,
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                'UPDATE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
    });
  }
}
