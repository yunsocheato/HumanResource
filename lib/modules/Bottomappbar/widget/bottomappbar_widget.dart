import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../controller/bottomappbar_controller.dart';

class BottomAppBarWidget extends GetView<BottomAppBarController> {
  final Widget body;

  const BottomAppBarWidget({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(padding: const EdgeInsets.only(bottom: 90), child: body),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Obx(
            () => Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.SelectedIndex(0);
                    },
                    icon: Column(
                      children: [
                        Icon(
                          Icons.dashboard,
                          size: 30,
                          color: controller.iconColor(0),
                        ),
                        Center(
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 12,
                              color: controller.iconColor(0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.SelectedIndex(1);
                    },
                    icon: Column(
                      children: [
                        Icon(
                          EneftyIcons.calendar_2_bold,
                          size: 30,
                          color: controller.iconColor(1),
                        ),
                        Center(
                          child: Text(
                            "Schedule",
                            style: TextStyle(
                              fontSize: 12,
                              color: controller.iconColor(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.SelectedIndex(2);
                    },
                    icon: Column(
                      children: [
                        Icon(
                          EneftyIcons.document_2_bold,
                          size: 30,
                          color: controller.iconColor(2),
                        ),
                        Center(
                          child: Text(
                            "History",
                            style: TextStyle(
                              fontSize: 12,
                              color: controller.iconColor(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.SelectedIndex(3);
                    },
                    icon: Column(
                      children: [
                        Icon(
                          EneftyIcons.setting_2_bold,
                          size: 30,
                          color: controller.iconColor(3),
                        ),
                        Center(
                          child: Text(
                            "Setting",
                            style: TextStyle(
                              fontSize: 12,
                              color: controller.iconColor(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
