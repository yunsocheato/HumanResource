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

        if (maxWidth < 600) {
          crossAxisCount = 2;
          childAspectRatio = 2.2;
        } else if (maxWidth >= 600 && maxWidth < 900) {
          crossAxisCount = 4;
          childAspectRatio = 1.7;
        } else if (maxWidth >= 900 && maxWidth < 1024) {
          crossAxisCount = 4;
          childAspectRatio = 1.3;
        } else if (maxWidth >= 1024 && maxWidth < 1440) {
          crossAxisCount = 4;
          childAspectRatio = 2.8;
        } else {
          crossAxisCount = 5;
          childAspectRatio = 2.2;
        }

        return GridView.builder(
          itemCount: controller.TextLeave.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print('Clicked item $index');
              },
              child: Obx(() {
                final leave = controller.overviewdashboard[index];
                final title = leave[0] as String;
                final icon = leave[1] as IconData;
                final color = leave[2] as Color;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade600,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 7,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: Colors.white, size: 28),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
