import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/DialogScreen/DialogScreen.dart';
import '../../Employee/widgets/employee_profile_widget.dart';
import '../controllers/drawer_controller.dart';
import 'Method_drawer_policy_button.dart';

class Employeepolicy extends GetView<AppDrawerController> {
  const Employeepolicy({super.key});

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
          final isExpanded1 = controller.isExpanded1('Employee Detail');
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.white,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded1,
              onExpansionChanged:
                  (bool expanded) => controller.toggleTile1('Employee Detail'),
              leading: Icon(
                size: iconSize,
                EneftyIcons.user_bold,
                color:
                    controller.selectedIndex.value == 15
                        ? Colors.blue.shade900
                        : Colors.white,
              ),
              title: InkWell(
                onTap: () {
                  controller.selectedIndex.value = 15;
                  MethodButton3();
                },
                child: Text(
                  'Employee Detail',
                  style: TextStyle(
                    fontSize: fontSizeTitle,
                    color:
                        controller.selectedIndex.value == 15
                            ? Colors.blue.shade900
                            : Colors.white,
                    fontWeight:
                        controller.selectedIndex.value == 15
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
                  title: 'Employee Profiles',
                  icon: EneftyIcons.user_tick_bold,
                  index: 16,
                  onTap: () => DialogScreen(context, EmployeeProfileWidget()),
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
