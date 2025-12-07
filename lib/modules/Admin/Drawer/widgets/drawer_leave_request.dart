import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/DialogScreen/DialogScreen.dart';
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
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 12;
        } else if (isTablet) {
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 12;
        } else if (isDesktop) {
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 12;
        } else if (isLargeDesktop) {
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 12;
        } else {
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 12;
        }

        return Obx(() {
          final isExpanded1 = controller.isExpanded1('Leave');
          bool isMobile = Get.width < 600;
          bool isDesktop = Get.width >= 1024;
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.white,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded1,
              onExpansionChanged:
                  (bool expanded) => controller.toggleTile1('Leave'),
              leading: Image.asset(
                'assets/icon/policy.png',
                width: iconSize,
                height: iconSize,
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
                            : (isMobile ? Colors.blue : Colors.white),
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
                  Imagepath: 'assets/icon/userleave.png',
                  fontSize: fontSizeBody,
                  title: 'Create Leave Request',
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
    required String Imagepath,
    required int index,
    required VoidCallback onTap,
    double fontSize = 14,
    double iconSize = 22,
  }) {
    final controller = Get.find<AppDrawerController>();
    final isSelected = controller.selectedIndex.value == index;
    final isMobile = Get.width < 600;
    return ListTile(
      leading: Image.asset(Imagepath, width: iconSize, height: iconSize),
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color:
              isSelected
                  ? controller.Selectedcolors
                  : (isMobile ? Colors.blue : controller.Unselectedcolors),
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
