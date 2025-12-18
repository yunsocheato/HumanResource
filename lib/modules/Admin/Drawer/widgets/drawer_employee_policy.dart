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
          fontSizeTitle = 12;
          fontSizeBody = 12;
          iconSize = 12;
        } else if (isTablet) {
          fontSizeTitle = 13;
          fontSizeBody = 10;
          iconSize = 12;
        } else if (isDesktop) {
          fontSizeTitle = 13;
          fontSizeBody = 10;
          iconSize = 12;
        } else if (isLargeDesktop) {
          fontSizeTitle = 13;
          fontSizeBody = 10;
          iconSize = 12;
        } else {
          fontSizeTitle = 13;
          fontSizeBody = 10;
          iconSize = 12;
        }
        return Obx(() {
          final isExpanded1 = controller.isExpanded1('Profile');
          bool isMobile = Get.width < 600;
          bool isDesktop = Get.width >= 1024;
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.blue,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded1,
              onExpansionChanged:
                  (bool expanded) => controller.toggleTile1('Profile'),
              leading: Image.asset(
                'assets/icon/user.png',
                width: iconSize,
                height: iconSize,
              ),
              title: InkWell(
                onTap: () {
                  controller.selectedIndex.value = 15;
                  MethodButton3();
                },
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: fontSizeTitle,
                    color:
                        controller.selectedIndex.value == 15
                            ? Colors.blue.shade900
                            : (isMobile ? Colors.blue : Colors.white),
                    fontWeight:
                        controller.selectedIndex.value == 15
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              ),
              iconColor: Colors.blue,
              collapsedIconColor: Colors.blue,
              childrenPadding: EdgeInsets.only(left: 32),
              children: [
                _buildSubTile(
                  Imagepath: 'assets/icon/manageuser.png',
                  fontSize: fontSizeBody,
                  title: 'Staff Profile',
                  index: 16,
                  onTap: () {
                    if (isMobile) {
                      Get.offAllNamed('/employee_profile_mobile');
                    } else {
                      DialogScreen(context, EmployeeProfileWidget());
                    }
                  },
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
    double fontSize = 12,
    double iconSize = 14,
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
