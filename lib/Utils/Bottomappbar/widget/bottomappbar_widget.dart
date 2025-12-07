import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bottomappbar_controller.dart';

class BottomAppBarWidget extends GetView<BottomAppBarController> {
  final Widget body;

  const BottomAppBarWidget({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomAppBarController>();

    return Stack(
      children: [
        Positioned.fill(child: Container(color: Colors.white, child: body)),

        Obx(
          () => AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: 15.0 - controller.bottomBarPosition.value,
            left: 15,
            right: 15,
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white24,
                border: Border.all(color: Colors.blue, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(4, (index) {
                  final labels = [
                    "Overview",
                    "Attendance",
                    "Report",
                    "Setting",
                  ];
                  final icons = [
                    'assets/icon/overview.png',
                    'assets/icon/calendar.png',
                    'assets/icon/folder.png',
                    'assets/icon/setting.png',
                  ];
                  return _buildBottomBarButton(
                    controller,
                    index,
                    labels[index],
                    icons[index],
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBarButton(
    BottomAppBarController controller,
    int index,
    String label,
    String iconPath,
  ) {
    return Obx(() {
      final isSelected = controller.isSelectedindex.value == index;
      return GestureDetector(
        onTap: () => controller.SelectedIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(iconPath, width: 30, height: 30),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.blue : Colors.black54,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
