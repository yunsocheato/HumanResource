import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/widgets/Method_drawer_policy_button.dart';
import 'package:hrms/modules/Employee/views/employee_profile_screen.dart';
import '../../DialogScreen/DialogScreen.dart';
import '../../Employee/views/employee_screen.dart';
import '../../Employee/widgets/employee_profile_widget.dart';
import '../controllers/drawer_controller.dart';
import '../views/Leave_Policy_screen.dart';

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
          dividerColor: Colors.transparent,
          unselectedWidgetColor: Colors.white,
        ),
        child: ExpansionTile(
          initiallyExpanded: isExpanded1,
          onExpansionChanged:
              (bool expanded) => controller.toggleTile1('Employee'),
          leading: Icon(Icons.person_2, color: Colors.white),
          title: InkWell(
            onTap: () => MethodButton3(),
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
              leading: Icon(EneftyIcons.security_user_bold, color: Colors.white),
              title: Text(
                'Employee Profile',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () =>  DialogScreen(context,EmployeeProfileWidget()) ,
            ),
          ],
        ),
      );
    });
  }
}
