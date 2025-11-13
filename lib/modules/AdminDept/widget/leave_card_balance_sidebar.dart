import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/overview_controller.dart';

class GridoverviewLeavebalance extends GetView<OverViewController> {
  const GridoverviewLeavebalance({super.key});

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
          iconSize = 28;
          fontSize = 13;
          crossAxisCount = 2;
          childAspectRatio = 1.3;
        } else if (maxWidth < 900) {
          iconSize = 35;
          fontSize = 14;
          crossAxisCount = 3;
          childAspectRatio = 1.0;
        } else if (maxWidth < 1440) {
          iconSize = 40;
          fontSize = 15;
          crossAxisCount = 4;
          childAspectRatio = 1.0;
        } else {
          iconSize = 48;
          fontSize = 16;
          crossAxisCount = 5;
          childAspectRatio = 1.5;
        }

        return GridView.builder(
          itemCount: controller.TextLeaves.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return MouseRegion(
              onEnter: (_) => controller.hoveredIndex.value = index,
              onExit: (_) => controller.hoveredIndex.value = -1,
              cursor: SystemMouseCursors.click,
              child: Obx(() {
                final leave = controller.TextLeaves[index];
                final title = leave[0] as String;
                final imagePath = leave[1] as String;
                final bg = leave.length > 2 ? leave[2] : null;
                final isHovered = controller.hoveredIndex.value == index;

                BoxDecoration decoration;
                if (bg is String &&
                    (bg.startsWith('http') || bg.startsWith('https'))) {
                  decoration = BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(bg),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
                  );
                } else {
                  decoration = BoxDecoration(
                    color:
                        Colors
                            .primaries[index % Colors.primaries.length]
                            .shade300,
                    borderRadius: BorderRadius.circular(16),
                  );
                }
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutCubic,
                  decoration: decoration.copyWith(
                    boxShadow: [
                      BoxShadow(
                        color: isHovered ? Colors.black26 : Colors.black12,
                        blurRadius: isHovered ? 25 : 8,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          scale: isHovered ? 1.1 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              imagePath,
                              width: iconSize,
                              height: iconSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 6),
                        Flexible(
                          child: Text(
                            getLeaveValue(index),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize + 2,
                              fontWeight: FontWeight.bold,
                            ),
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

  String getLeaveValue(int index) {
    if (controller.leavecardbalance.isEmpty) return '0';
    final leave = controller.leavecardbalance[0];
    switch (index) {
      case 0:
        return leave.AnnualLeave;
      case 1:
        return leave.SickLeave;
      case 2:
        return leave.MaternityLeave;
      case 3:
        return leave.UnpaidLeave;
      default:
        return '0';
    }
  }
}
