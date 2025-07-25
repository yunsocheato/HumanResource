import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Employee/views/employee_screen.dart';
import '../controllers/drawer_controller.dart';

class Employeepolicy extends GetView<AppDrawerController> {
  const Employeepolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerTile(controller, context);
  }

  Widget _buildDrawerTile(BuildContext, context) {
    return Obx(() {
      final isExpanded1 = controller.isExpanded1('Employee');
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // remove expansion tile divider
          unselectedWidgetColor: Colors.white, // arrow color
        ),
        child: ExpansionTile(
          initiallyExpanded: isExpanded1,
          onExpansionChanged:
              (bool expanded) => controller.toggleTile1('Employee'),
          leading: Icon(Icons.person_2, color: Colors.white),
          title: InkWell(
            onTap: () => Get.toNamed(EmployeeScreen.routeName),
            child: Text(
              'Employee',
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
            ListTile(
              title: Text(
                'Staff Profile',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/hr-policy'),
            ),
            ListTile(
              title: Text(
                'Career History',
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
