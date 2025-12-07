import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../controllers/department_controller.dart';
import 'announcement_card_widget.dart';
import 'department_card_widget.dart';

class ButtonWidget extends GetView<DepartmentScreenController> {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return buildAppbarbutton(context);
  }

  Widget buildAppbarbutton(BuildContext context) {
    final isMobile = Get.width < 600;
    final HoverMouseController controller1 = Get.put(HoverMouseController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return Row(
              mainAxisAlignment:
                  isMobile
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.start,
              children: List.generate(controller.departments.length, (index) {
                final selected = controller.isSelectedindex.value == index;
                return MouseHover(
                  keyId: 9,
                  controller: controller1,
                  child: GestureDetector(
                    onTap: () {
                      controller.SelectedIndex(index);
                      controller.pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: controller
                          .boxDecoration(index)
                          .copyWith(
                            color:
                                selected
                                    ? Colors.blue.shade900
                                    : Colors.transparent,
                          ),
                      child: Text(
                        controller.departments[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: controller.iconColor(index),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
        Obx(() {
          switch (controller.isSelectedindex.value) {
            case 0:
              return const DepartmentCard();
            case 1:
              return const AnnounceMentCard();
            default:
              return const DepartmentCard();
          }
        }),
      ],
    );
  }
}
