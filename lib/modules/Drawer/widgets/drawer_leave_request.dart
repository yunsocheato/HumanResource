import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import '../../Attendance/views/attendance_screen.dart';
import '../../DialogScreen/DialogScreen.dart';
import '../../LeaveRequest/widgets/apply_leave_screen_widget.dart';
import '../controllers/drawer_controller.dart';
import 'Method_drawer_policy_button.dart';

class TableLeaveRequest extends GetView<AppDrawerController> {
  const TableLeaveRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerTile(controller, context);
  }

  Widget _buildDrawerTile(BuildContext, context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isDesktop = width >= 1024 && width < 2560;
        final isLargeDesktop = width >= 2560 && width < 3840;
        double fontSizeTitle;
        double fontSizeBody;
        double iconSize;

        if (isMobile) {
          fontSizeTitle = 15;
          fontSizeBody = 12;
          iconSize = 22;
        } else if (isTablet) {
          fontSizeTitle = 16;
          fontSizeBody = 13;
          iconSize = 24;
        } else if (isDesktop) {
          fontSizeTitle = 18;
          fontSizeBody = 14;
          iconSize = 26;
        } else if (isLargeDesktop) {
          fontSizeTitle = 20;
          fontSizeBody = 16;
          iconSize = 28;
        } else {
          fontSizeTitle = 22;
          fontSizeBody = 18;
          iconSize = 32;
        }

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
              leading: Icon(
                Boxicons.bx_walk,
                size: iconSize,
                color:
                    controller.selectedIndex == 19
                        ? Colors.blue.shade900
                        : Colors.white,
              ),
              title: InkWell(
                onTap: () {
                  controller.selectedIndex.value = 19;
                  MethodButton5();
                },
                child: Text(
                  'Leave Request',
                  style: TextStyle(
                    fontSize: fontSizeTitle,
                    color:
                        controller.selectedIndex.value == 19
                            ? Colors.blue.shade900
                            : Colors.white,
                    fontWeight:
                        controller.selectedIndex.value == 19
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              ),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              childrenPadding: EdgeInsets.only(left: 32),
              children: [
                _buildSubTile(
                  iconSize: iconSize,
                  fontSize: fontSizeBody,
                  title: 'Create Leave Request',
                  icon: Boxicons.bx_walk,
                  index: 20,
                  onTap: () => DialogScreen(context, ApplyLeaveWidget()),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _buildSubTile({
    required String title,
    required IconData icon,
    required int index,
    required VoidCallback onTap,
    double fontSize = 14,
    double iconSize = 22,
  }) {
    final controller = Get.find<AppDrawerController>();
    final isSelected = controller.selectedIndex.value == index;

    return ListTile(
      leading: Icon(
        size: iconSize,
        icon,
        color: isSelected ? Colors.blue.shade900 : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: isSelected ? Colors.blue.shade900 : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        controller.setSelected(index);
        onTap();
      },
    );
  }
}
