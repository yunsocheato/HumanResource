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
          iconSize = 14;
          fontSize = 14;
          crossAxisCount = 2;
          childAspectRatio = 2.5;
        } else if (maxWidth >= 600 && maxWidth < 900) {
          iconSize = 16;
          fontSize = 16;
          crossAxisCount = 4;
          childAspectRatio = 2.2;
        } else if (maxWidth >= 900 && maxWidth < 1024) {
          iconSize = 18;
          fontSize = 18;
          crossAxisCount = 4;
          childAspectRatio = 2.0;
        } else if (maxWidth >= 1024 && maxWidth < 1440) {
          iconSize = 20;
          fontSize = 20;
          crossAxisCount = 4;
          childAspectRatio = 2.8;
        } else {
          iconSize = 22;
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
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return MouseRegion(
              onEnter: (_) => controller.hoveredIndex.value = index,
              onExit: (_) => controller.hoveredIndex.value = -1,
              cursor: SystemMouseCursors.click,
              child: Obx(() {
                final item = controller.overviewdashboard[index];
                final isHovered = controller.hoveredIndex.value == index;
                final isSelected = controller.selectedIndex.value == index;

                final bgColor =
                    isSelected
                        ? Colors.deepPurple.shade900
                        : Colors.grey.shade500;

                BoxDecoration decoration = BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isHovered ? Colors.black26 : Colors.black12,
                      blurRadius: isHovered ? 25 : 5,
                      offset: const Offset(3, 3),
                    ),
                  ],
                );

                return GestureDetector(
                  onTap: () {
                    controller.selectedIndex.value = isSelected ? -1 : index;

                    if (item.onTap != null) {
                      item.onTap!();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOutCubic,
                    transform:
                        isHovered ? Matrix4.identity() : Matrix4.identity(),
                    decoration: decoration,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          color:
                              isSelected
                                  ? Colors.white
                                  : Colors.deepPurple.shade900,
                          size: iconSize,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.title,
                          style: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : Colors.deepPurple.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
