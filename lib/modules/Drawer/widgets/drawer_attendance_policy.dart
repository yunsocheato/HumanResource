import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Attendance/controllers/attendance_widget_controller.dart';

import '../../../ErrorScreen/Controller/ErrorMessage.dart';
import '../../../Loadingui/Loading_Screen.dart';
import '../../../Loadingui/loading_controller.dart';
import '../../Attendance/views/attendance_screen.dart';
import '../controllers/drawer_controller.dart';
import '../controllers/drawer_dialog_screen_controller.dart';
import 'Method_drawer_policy_button.dart';
import 'attendance_dialog_widget.dart';

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
          children: [
            ListTile(
              title: Text(
                'Fingerprint Setup',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                final controller = Get.find<DialogScreenController>();
                controller.ShowcustomDialog(AttendanceDialog());
              },
            ),
            ListTile(
              title: Text(
                'Attendance Policy',
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
// if (controller.isNullOrBlank!) {
// if (Get.isRegistered<LoadingUiController>()) {
// Get.put<LoadingUiController>(LoadingUiController());
// }
// Get.toNamed(AttendanceScreen.routeName);
// } else {
// error.error.value = 'No Employee Data Found';
// error.buildErrorMessages();
// }