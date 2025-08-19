import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';
import 'Method_drawer_policy_button.dart';

class Attendancepolicy extends GetView<AppDrawerController> {
  const Attendancepolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerTile(controller, context);
  }

  Widget _buildDrawerTile(BuildContext, context) {
    final controller = Get.find<AppDrawerController>();
    return Obx(() {
      final isExpanded1 = controller.isExpanded1('Attendance');
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          unselectedWidgetColor: Colors.white,
        ),
        child: ExpansionTile(
          initiallyExpanded: isExpanded1,
          onExpansionChanged:
              (bool expanded) => controller.toggleTile1('Attendance'),
          leading: Icon(Icons.calendar_month_sharp, color: Colors.white),
          title: InkWell(
            onTap: () => MethodButton1(),
            child: Text(
              'Attendance',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          childrenPadding: EdgeInsets.only(left: 32),
        ),
      );
    });
  }
}
