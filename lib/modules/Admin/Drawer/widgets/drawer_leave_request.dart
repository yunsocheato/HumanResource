import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
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
          fontSizeTitle = 10;
          fontSizeBody = 10;
          iconSize = 15;
        } else if (isTablet) {
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 20;
        } else if (isDesktop) {
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 20;
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

    return ListTile(
      leading: Image.asset(Imagepath, width: iconSize, height: iconSize),
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
