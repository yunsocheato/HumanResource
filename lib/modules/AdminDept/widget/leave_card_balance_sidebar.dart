import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/overview_controller.dart';

class GridoverviewLeavebalance extends GetView<OverViewController> {
  const GridoverviewLeavebalance({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 900;
    final bool isLaptop = screenWidth >= 900 && screenWidth < 1200;
    final bool isDesktop = screenWidth >= 1200 && screenWidth < 1440;
    final bool isLargeDesktop = screenWidth >= 1440;

    int crossAxisCount;
    double iconSize;
    double fontSize;
    double itemHeight;

    if (isMobile) {
      crossAxisCount = 2;
      iconSize = 16;
      fontSize = 12;
      itemHeight = 140;
    } else if (isTablet) {
      crossAxisCount = 2;
      iconSize = 16;
      fontSize = 12;
      itemHeight = 140;
    } else if (isLaptop) {
      crossAxisCount = 2;
      iconSize = 16;
      fontSize = 12;
      itemHeight = 650;
    } else if (isDesktop) {
      crossAxisCount = 2;
      iconSize = 16;
      fontSize = 12;
      itemHeight = 650;
    } else if (isLargeDesktop) {
      crossAxisCount = 2;
      iconSize = 16;
      fontSize = 12;
      itemHeight = 650;
    } else {
      return const Text('Unknown device');
    }

    const double spacing = 3;

    final double itemWidth =
        (screenWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
    final double childAspectRatio = itemWidth / itemHeight;

    return GridView.builder(
      itemCount: controller.TextLeaves.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(spacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
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
                (bg.startsWith("http") || bg.startsWith("https"))) {
              decoration = BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(bg),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.45),
                    BlendMode.darken,
                  ),
                ),
              );
            } else {
              decoration = BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    Colors.primaries[index % Colors.primaries.length].shade300,
              );
            }

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: decoration.copyWith(
                boxShadow: [
                  BoxShadow(
                    color: isHovered ? Colors.black26 : Colors.black12,
                    blurRadius: isHovered ? 25 : 10,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: isHovered ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        imagePath,
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    getLeaveValue(index),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  String getLeaveValue(int index) {
    if (controller.leavecardbalance.isEmpty) return "0";
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
        return "0";
    }
  }
}
