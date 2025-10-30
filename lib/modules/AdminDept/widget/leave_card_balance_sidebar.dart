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
          iconSize = 16;
          fontSize = 13;
          crossAxisCount = 2;
          childAspectRatio = 1.3;
        } else if (maxWidth < 900) {
          iconSize = 23;
          fontSize = 14;
          crossAxisCount = 3;
          childAspectRatio = 1.0;
        } else if (maxWidth < 1440) {
          iconSize = 25;
          fontSize = 15;
          crossAxisCount = 4;
          childAspectRatio = 1.0;
        } else {
          iconSize = 22;
          fontSize = 16;
          crossAxisCount = 5;
          childAspectRatio = 1.5;
        }

        return GridView.builder(
          itemCount: controller.TextLeave.length,
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
                final leave = controller.TextLeave[index];
                final title = leave[0] as String;
                final icon = leave[1] as IconData;
                final bg = leave[2];
                final isHovered = controller.hoveredIndex.value == index;

                BoxDecoration decoration;
                if (bg is String) {
                  decoration = BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(bg),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
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
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.bounceInOut,
                  transform:
                      isHovered
                          ? (Matrix4.identity()
                            ..translate(0, -10, 0)
                            ..rotateX(-0.05)
                            ..rotateY(0.05))
                          : Matrix4.identity(),
                  decoration: decoration.copyWith(
                    boxShadow: [
                      BoxShadow(
                        color: isHovered ? Colors.black26 : Colors.black12,
                        blurRadius: isHovered ? 25 : 5,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: iconSize,
                          ),
                        ),
                        const SizedBox(height: 6),
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
