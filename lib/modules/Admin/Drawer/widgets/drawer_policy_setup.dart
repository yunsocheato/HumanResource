import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import '../../../../Utils/DialogScreen/DialogScreen.dart';
import '../../UserSetup/View/user_setup_screen.dart';
import '../controllers/drawer_controller.dart';
import '../views/Leave_Policy_screen.dart';

import '../views/employee_policy_screen.dart';
import '../views/manage_user_screen.dart';

class PolicySetup extends GetView<AppDrawerController> {
  const PolicySetup({super.key});

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
          fontSizeTitle = 22;
          fontSizeBody = 12;
          iconSize = 12;
        }
        return Obx(() {
          final isExpanded1 = controller.isExpanded1('Policy Set up');
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
                  (bool expanded) => controller.toggleTile1('Policy Set up'),
              leading: Image.asset(
                'assets/icon/policy.png',
                width: isMobile ? 22 : 14,
                height: isMobile ? 22 : 14,
              ),
              title: Text(
                'Policy Set up',
                style: TextStyle(
                  fontSize: fontSizeTitle,
                  color:
                      controller.selectedIndex.value == 3
                          ? Colors.blue.shade900
                          : (isMobile ? Colors.blue : Colors.white),
                  fontWeight:
                      controller.selectedIndex.value == 3
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
              iconColor: Colors.blue,
              collapsedIconColor: Colors.blue,
              childrenPadding: EdgeInsets.only(left: 32),
              children: [
                _buildSubTile(
                  title: 'User Setup',
                  imagePath: 'assets/icon/usersetup.png',
                  fontSize: fontSizeBody,
                  index: 24,
                  onTap: () => DialogScreen(context, UserSetupScreen()),
                ),
                _buildSubTile(
                  imagePath: 'assets/icon/userupdate.png',
                  title: 'User Update',
                  fontSize: fontSizeBody,
                  index: 5,
                  onTap: () => DialogScreen(context, EmployeePolicyScreen()),
                ),
                _buildSubTile(
                  imagePath: 'assets/icon/policy.png',
                  title: 'Leave Policy',
                  fontSize: fontSizeBody,
                  index: 4,
                  onTap: () => DialogScreen(context, LeavePolicy()),
                ),
                _buildSubTile(
                  imagePath: 'assets/icon/manageuser.png',
                  title: 'Manage Users',
                  fontSize: fontSizeBody,
                  index: 6,
                  onTap: () => DialogScreen(context, ManageUserScreen()),
                ),
                _buildSubTile(
                  imagePath: 'assets/icon/manageteam.png',
                  title: 'Manage Team Users',
                  fontSize: fontSizeBody,
                  index: 7,
                  onTap: () {},
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
    required String imagePath,
    required int index,
    required VoidCallback onTap,
    double fontSize = 14,
    double imageSize = 22,
  }) {
    final controller = Get.find<AppDrawerController>();
    final isSelected = controller.selectedIndex.value == index;
    final isMobile = Get.width < 600;
    return ListTile(
      leading: Image.asset(imagePath, width: imageSize, height: imageSize),
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
