import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controller/overview_controller.dart';

class Gridoverviewsidebar extends GetView<OverViewController> {
  const Gridoverviewsidebar({super.key});

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
          iconSize = 13;
          fontSize = 12;
          crossAxisCount = 2;
          childAspectRatio = 2.2;
        } else if (maxWidth >= 600 && maxWidth < 900) {
          iconSize = 14;
          fontSize = 13;
          crossAxisCount = 2;
          childAspectRatio = 2.2;
        } else if (maxWidth >= 900 && maxWidth < 1024) {
          iconSize = 15;
          fontSize = 14;
          crossAxisCount = 2;
          childAspectRatio = 1.2;
        } else if (maxWidth >= 1024 && maxWidth < 1440) {
          iconSize = 16;
          fontSize = 15;
          crossAxisCount = 2;
          childAspectRatio = 1.2;
        } else {
          iconSize = 17;
          fontSize = 16;
          crossAxisCount = 5;
          childAspectRatio = 1.2;
        }

        return GridView.builder(
          itemCount: controller.TextLeave.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => print('Clicked item $index'),
              child: Obx(() {
                final leave = controller.TextLeave[index];
                final title = leave[0] as String;
                final icon = leave[1] as IconData;

                return Container(
                  decoration: BoxDecoration(
                    color:
                        Colors
                            .primaries[index % Colors.primaries.length]
                            .shade300,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(icon, color: Colors.white, size: iconSize),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '0', // Left Leave Balance
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
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
