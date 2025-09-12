  import 'package:enefty_icons/enefty_icons.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_boxicons/flutter_boxicons.dart';
  import 'package:get/get.dart';
  import '../controllers/drawer_controller.dart';
  import 'Method_drawer_policy_button.dart';

  class ReportPolicy extends GetView<AppDrawerController> {
    const ReportPolicy({super.key});

    @override
    Widget build(BuildContext context) {
      return _buildDrawerTile(controller, context);
    }

    Widget _buildDrawerTile(BuildContext, context) {
      return Obx(() {
        final controller = Get.find<AppDrawerController>();
        final isExpanded1 = controller.isExpanded1('Report');

        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            unselectedWidgetColor: Colors.white,
          ),
          child: ExpansionTile(
            initiallyExpanded: isExpanded1,
            onExpansionChanged: (bool expanded) =>
                controller.toggleTile1('Report'),
            leading: Icon(
              EneftyIcons.document_2_bold,
              color: controller.selectedIndex.value == 9
                  ? Colors.blue.shade900
                  : Colors.white,
            ),
            title: Text(
              'Report',
              style: TextStyle(
                color: controller.selectedIndex.value == 9
                    ? Colors.blue.shade900
                    : Colors.white,
                fontWeight: controller.selectedIndex.value == 9
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            childrenPadding: const EdgeInsets.only(left: 32),
            children: [
              _buildSubTile(
                title: 'Employee Checkin',
                icon: EneftyIcons.user_tick_bold,
                index: 10,
                onTap: () => MethodButton6(),
              ),
              _buildSubTile(
                title: 'Employee Late',
                icon: EneftyIcons.user_minus_bold,
                index: 11,
                onTap: () => MethodButton7(),
              ),
              _buildSubTile(
                title: 'Employee Absent',
                icon: EneftyIcons.clock_bold,
                index: 12,
                onTap: () => MethodButton9(),
              ),
              _buildSubTile(
                title: 'Leave Summary',
                icon: Boxicons.bx_walk,
                index: 13,
                onTap: () => MethodButton8(),
              ),
              _buildSubTile(
                title: 'OT Report',
                icon: EneftyIcons.alarm_bold,
                index: 14,
                onTap: () => MethodButton10(),
              ),
            ],
          ),
        );
      });
    }


    Widget _buildSubTile({
      required String title,
      required IconData icon,
      required int index,
      required VoidCallback onTap,
    }) {
      final controller = Get.find<AppDrawerController>();
      final isSelected = controller.selectedIndex.value == index;

      return ListTile(
        leading: Icon(
            icon, color: isSelected ? Colors.blue.shade900 : Colors.white),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue.shade900 : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          controller.setSelected(index);
          onTap();
        },
      );
    }

  }
