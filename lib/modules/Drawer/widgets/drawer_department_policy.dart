import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Department/views/department_screen.dart';
import '../controllers/drawer_controller.dart';
import 'Method_drawer_policy_button.dart';

class Departmentpolicy extends GetView<AppDrawerController> {
  const Departmentpolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerTile(controller, context);
  }

  Widget _buildDrawerTile(BuildContext, context) {
    return Obx(() {
      final isExpanded1 = controller.isExpanded1('Department');
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          unselectedWidgetColor: Colors.white,
        ),
        child: ExpansionTile(
          initiallyExpanded: isExpanded1,
          onExpansionChanged:
              (bool expanded) => controller.toggleTile1('Department'),
          leading: Icon(EneftyIcons.buildings_2_bold, color: Colors.white),
          title: InkWell(
            onTap: () => MethodButton4(),
            child: Text(
              'Department',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          childrenPadding: EdgeInsets.only(left: 32),
          children: [
            // ListTile(
            //   title: Text(
            //     'Department Setup',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () => Get.toNamed('/hr-policy'),
            // ),
            ListTile(
              leading: Icon(EneftyIcons.home_3_outline, color: Colors.white),
              title: Text(
                'Department Announcement',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/it-policy'),
            ),
          ],
        ),
      );
    });
  }
}
