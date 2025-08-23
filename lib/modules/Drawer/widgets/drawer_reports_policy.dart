import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Report/view/employee_checkin_screen.dart';
import 'package:hrms/modules/Report/view/employee_leave_summary_screen.dart';
import '../../Report/view/employee_Late_screen.dart';
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
      final isExpanded1 = controller.isExpanded1('Leave');
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // remove expansion tile divider
          unselectedWidgetColor: Colors.white, // arrow color
        ),
        child: ExpansionTile(
          initiallyExpanded: isExpanded1,
          onExpansionChanged:
              (bool expanded) => controller.toggleTile1('Report'),
          leading: Icon(Icons.folder, color: Colors.white),
          title: Text(
            'Report',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          childrenPadding: EdgeInsets.only(left: 32),
          children: [
            ListTile(
              title: InkWell(
                onTap: () => MethodButton6(),
                child: Text(
                  'Employee Checkin',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => Get.toNamed(EmployeeCheckinScreen.routeName),
            ),
            ListTile(
              title: InkWell(
                onTap: () => MethodButton7(),
                child: Text(
                  'Employee Late',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => Get.toNamed(EmployeeLateScreen.routeName),
            ),
            ListTile(
              title: Text(
                'Employee Absent',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/hr-policy'),
            ),
            ListTile(
              title: InkWell(
                onTap: () => MethodButton8(),
                child: Text(
                  'Leave Summary',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => Get.toNamed(EmployeeLeaveSummaryScreen.routeName),
            ),
            ListTile(
              title: Text(
                'OT Reports',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/hr-policy'),
            ),
          ],
        ),
      );
    });
  }
}
