import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/views/Leave_Policy_screen.dart';
import 'package:hrms/modules/Drawer/views/employee_policy_screen.dart';
import 'package:hrms/modules/Drawer/views/payroll_policy_screen.dart';

import '../../DialogScreen/DialogScreen.dart';
import '../controllers/drawer_controller.dart';
import '../views/OT_policy_screen.dart';
import '../views/access_feature_screen.dart';
import '../views/fingerprint_setup_screen.dart';

class PolicySetup extends GetView<AppDrawerController> {
  const PolicySetup({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerTile(controller, context);
  }

  Widget _buildDrawerTile(BuildContext, context) {
    return Obx(() {
      final isExpanded1 = controller.isExpanded1('Policy Set up');
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          unselectedWidgetColor: Colors.white,
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
                'Attendance Policy',
                style: TextStyle(color: Colors.white),
              ),
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
                'Employee Policy',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () =>DialogScreen(context, EmployeePolicyScreen())
            ),
            ListTile(
              title: Text('OT Policy', style: TextStyle(color: Colors.white)),
              onTap: () => DialogScreen(context, OTPolicyScreen()),
            ),
            ListTile(
              title: Text('Access Feature Policy', style: TextStyle(color: Colors.white)),
              onTap: () => DialogScreen(context,AccessFeatureScreen()),
            ),
          ],
        ),
      );
    });
  }
}
