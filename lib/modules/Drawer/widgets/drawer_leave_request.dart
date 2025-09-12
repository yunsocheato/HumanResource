import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import '../../Attendance/views/attendance_screen.dart';
import '../../DialogScreen/DialogScreen.dart';
import '../../LeaveRequest/widgets/apply_leave_screen_widget.dart';
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
          leading: Icon(Boxicons.bx_walk, color: Colors.white),
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
              leading: Icon(EneftyIcons.clock_2_bold, color: Colors.white),
              title: Text(
                'Apply Leave',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => DialogScreen(context,ApplyLeaveWidget())
            ),
            ListTile(
              leading: Icon(EneftyIcons.user_tick_bold, color: Colors.white),
              title: Text(
                'Leave Approved',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Get.toNamed('/Approved'),
            ),
            ListTile(
              leading: Icon(EneftyIcons.user_minus_bold, color: Colors.white),
              title: Text(
                'Leave Reject',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }
}
