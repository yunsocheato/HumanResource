import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Attendance/views/attendance_screen.dart';
import '../controllers/drawer_controller.dart';
import 'Method_drawer_policy_button.dart';

class LeaveRequest extends GetView<AppDrawerController> {
  const LeaveRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerTile(controller, context);
  }

  Widget _buildDrawerTile(BuildContext, context) {
    return Obx(() {
      final isExpanded1 = controller.isExpanded1('Leave');
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          unselectedWidgetColor: Colors.white,
        ),
        child: ExpansionTile(
          initiallyExpanded: isExpanded1,
          onExpansionChanged:
              (bool expanded) => controller.toggleTile1('Leave'),
          leading: Icon(Icons.stop_circle, color: Colors.white),
          title: InkWell(
            onTap: () => MethodButton5(),
            child: Text(
              'Leave Request',
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
                'Apply Leave',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/hr-policy'),
            ),
            ListTile(
              title: Text(
                'Leave Approved',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/it-policy'),
            ),
            ListTile(
              title: Text(
                'Leave Reject',
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
