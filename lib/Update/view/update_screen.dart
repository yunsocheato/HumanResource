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
      if (controller.hasNewUpdate.value) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black12,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () => controller.fetchAllFiles(),
          child: controller.isLoading.value
              ? CircularProgressIndicator(color: Colors.blue)
              : Text('UPDATE',style: TextStyle(color: Colors.white)),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }
}
