import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/views/Leave_Policy_screen.dart';
import 'package:hrms/modules/Drawer/views/employee_policy_screen.dart';
import '../../DialogScreen/DialogScreen.dart';
import '../controllers/drawer_controller.dart';
import '../views/OT_policy_screen.dart';
import '../views/access_feature_screen.dart';

class PolicySetup extends GetView<AppDrawerController> {
  const PolicySetup({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerTile(controller, context);
  }

  Widget _buildDrawerTile(BuildContext, context) {
    return Obx(() {
      final controller = Get.find<AppDrawerController>();
      final isExpanded1 = controller.isExpanded1('Policy Set up');

      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          unselectedWidgetColor: Colors.white,
        ),
        child: ExpansionTile(
          initiallyExpanded: isExpanded1,
          onExpansionChanged: (bool expanded) =>
              controller.toggleTile1('Policy Set up'),
          leading: Icon(
            EneftyIcons.setting_4_bold,
            color: controller.selectedIndex.value == 3
                ? Colors.blue.shade900
                : Colors.white,
          ),
          title: Text(
            'Policy Set up',
            style: TextStyle(
              color: controller.selectedIndex.value == 3
                  ? Colors.blue.shade900
                  : Colors.white,
              fontWeight: controller.selectedIndex.value == 3
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          childrenPadding: EdgeInsets.only(left: 32),
          children: [
            _buildSubTile(
              title: 'Leave Policy',
              icon: Boxicons.bx_walk,
              index: 4,
              onTap: () => DialogScreen(context, LeavePolicy()),
            ),
            _buildSubTile(
              title: 'Employee Policy',
              icon: EneftyIcons.user_minus_bold,
              index: 5,
              onTap: () => DialogScreen(context, EmployeePolicyScreen()),
            ),
            _buildSubTile(
              title: 'OT Policy',
              icon: EneftyIcons.clock_2_bold,
              index: 6,
              onTap: () => DialogScreen(context, OTPolicyScreen()),
            ),
            _buildSubTile(
              title: 'Access Feature Policy',
              icon: EneftyIcons.picture_frame_bold,
              index: 7,
              onTap: () => DialogScreen(context, AccessFeatureScreen()),
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

