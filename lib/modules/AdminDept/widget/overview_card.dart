import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controller/overview_controller.dart';

class Gridoverviewoverview extends GetView<OverViewController> {
  const Gridoverviewoverview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        int crossAxisCount;
        double childAspectRatio;
        double iconSize;
        double fontSize;

        if (maxWidth < 600) {
          iconSize = 25;
          fontSize = 14;
          crossAxisCount = 2;
          childAspectRatio = 2.5;
        } else if (maxWidth >= 600 && maxWidth < 900) {
          iconSize = 30;
          fontSize = 16;
          crossAxisCount = 4;
          childAspectRatio = 2.2;
        } else if (maxWidth >= 900 && maxWidth < 1024) {
          iconSize = 50;
          fontSize = 18;
          crossAxisCount = 4;
          childAspectRatio = 2.0;
        } else if (maxWidth >= 1024 && maxWidth < 1440) {
          iconSize = 100;
          fontSize = 20;
          crossAxisCount = 4;
          childAspectRatio = 2.8;
        } else {
          iconSize = 125;
          fontSize = 22;
          crossAxisCount = 5;
          childAspectRatio = 2.2;
        }

        return GridView.builder(
          itemCount: controller.overviewdashboard.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 3,
            mainAxisSpacing: 5,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return MouseRegion(
              onEnter: (_) => controller.hoveredIndex1.value = index,
              onExit: (_) => controller.hoveredIndex1.value = -1,
              cursor: SystemMouseCursors.click,
              child: Obx(() {
                final item = controller.overviewdashboard[index];
                final isHovered = controller.hoveredIndex1.value == index;
                final isSelected = controller.selectedIndex.value == index;
                Color bgColor;
                if (isSelected) {
                  bgColor = Colors.deepPurple.shade900;
                } else if (isHovered) {
                  bgColor = Colors.deepPurple.shade800;
                } else {
                  bgColor = Colors.grey.shade300;
                }
                Color textColor;
                if (isSelected) {
                  textColor = Colors.white;
                } else if (isHovered) {
                  textColor = Colors.white;
                } else {
                  textColor = Colors.deepPurple.shade900;
                }
                return GestureDetector(
                  onTap: () {
                    controller.selectedIndex.value = isSelected ? -1 : index;
                    if (item.onTap != null) item.onTap!();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:
                              isHovered
                                  ? Colors.deepPurple.shade900
                                  : Colors.deepPurple.shade300,
                          blurRadius: isHovered ? 15 : 5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        if (item.imagePath.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Image.asset(
                              item.imagePath,
                              width: iconSize,
                              height: iconSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        );
      },
    );
  }
}
