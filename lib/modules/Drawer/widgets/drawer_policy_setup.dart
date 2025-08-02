import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/views/Leave_Policy_screen.dart';

import '../../DialogScreen/DialogScreen.dart';
import '../controllers/drawer_controller.dart';

class Policysetup extends GetView<AppDrawerController> {
  const Policysetup({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerTile(controller, context);
  }

  Widget _buildDrawerTile(BuildContext, context) {
    return Obx(() {
      final isExpanded1 = controller.isExpanded1('Policy Set up');
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // remove expansion tile divider
          unselectedWidgetColor: Colors.white, // arrow color
        ),
        child: ExpansionTile(
          initiallyExpanded: isExpanded1,
          onExpansionChanged:
              (bool expanded) => controller.toggleTile1('Policy Set up'),
          leading: Icon(Icons.settings, color: Colors.white),
          title: Text(
            'Policy Set up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          childrenPadding: EdgeInsets.only(left: 32),
          children: [
            ListTile(
              title: Text(
                'Job Analysis',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/hr-policy'),
            ),
            ListTile(
              title: Text('Payroll', style: TextStyle(color: Colors.white)),
              onTap: () => Get.toNamed('/it-policy'),
            ),
            ListTile(
              title: Text(
                'Leave Policy',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => DialogScreen(context,LeavePolicy())
            ),
            ListTile(
              title: Text(
                'General Setting',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/it-policy'),
            ),
            ListTile(
              title: Text(
                'User Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/hr-policy'),
            ),
            ListTile(
              title: Text(
                'Telegram config',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/it-policy'),
            ),
            ListTile(
              title: Text('OT Settings', style: TextStyle(color: Colors.white)),
              onTap: () => Get.toNamed('/hr-policy'),
            ),
          ],
        ),
      );
    });
  }
}
