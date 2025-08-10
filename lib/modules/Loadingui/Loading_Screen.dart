import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'loading_controller.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoadingUiController>();

    return Obx(() {
      if (!controller.isLoading.value) return const SizedBox.shrink();

      final isMobile = Get.width < 600;

      return Center(
        child: isMobile
            ? Container(
          height: 120,
          width: 130,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: LoadingAnimationWidget.threeRotatingDots(
            color: Colors.blue.shade900,
            size: 60,
          ),
        ) : SizedBox(
          height: 150,
          width: 150,
          child: LoadingAnimationWidget.inkDrop(
            color: Colors.blue.shade900,
            size: 90,
          ),
        ),
      );
    });
  }
}
