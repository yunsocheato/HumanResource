import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/views/Leave_Policy_screen.dart';
import 'package:hrms/modules/Drawer/views/employee_policy_screen.dart';
import '../../DialogScreen/DialogScreen.dart';
import '../../UserSetup/View/user_setup_screen.dart';
import '../controllers/drawer_controller.dart';
import '../views/OT_policy_screen.dart';
import '../views/access_feature_screen.dart';

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
          final isExpanded1 = controller.isExpanded1('Policy Set up');
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.white,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded1,
              onExpansionChanged:
                  (bool expanded) => controller.toggleTile1('Policy Set up'),
              leading: Icon(
                EneftyIcons.setting_4_bold,
                size: iconSize,
                color:
                    controller.selectedIndex.value == 3
                        ? Colors.blue.shade900
                        : Colors.white,
              ),
              title: Text(
                'Policy Set up',
                style: TextStyle(
                  fontSize: fontSizeTitle,
                  color:
                      controller.selectedIndex.value == 3
                          ? Colors.blue.shade900
                          : Colors.white,
                  fontWeight:
                      controller.selectedIndex.value == 3
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              childrenPadding: EdgeInsets.only(left: 32),
              children: [
                _buildSubTile(
                  title: 'User Setup',
                  fontSize: fontSizeBody,
                  icon: EneftyIcons.user_cirlce_add_bold,
                  iconSize: iconSize,
                  index: 24,
                  onTap: () => DialogScreen(context, UserSetupScreen()),
                ),
                _buildSubTile(
                  title: 'User Update',
                  fontSize: fontSizeBody,
                  icon: EneftyIcons.user_minus_bold,
                  iconSize: iconSize,
                  index: 5,
                  onTap: () => DialogScreen(context, EmployeePolicyScreen()),
                ),
                _buildSubTile(
                  title: 'Leave Policy',
                  fontSize: fontSizeBody,
                  icon: Boxicons.bx_walk,
                  iconSize: iconSize,
                  index: 4,
                  onTap: () => DialogScreen(context, LeavePolicy()),
                ),
                // _buildSubTile(
                //   title: 'OT Policy',
                //   fontSize: fontSizeBody,
                //   icon: EneftyIcons.clock_2_bold,
                //   index: 6,
                //   iconSize: iconSize,
                //   onTap: () => DialogScreen(context, OTPolicyScreen()),
                // ),
                // _buildSubTile(
                //   title: 'Access Feature Policy',
                //   iconSize: iconSize,
                //   fontSize: fontSizeBody,
                //   icon: EneftyIcons.picture_frame_bold,
                //   index: 7,
                //   onTap: () => DialogScreen(context, AccessFeatureScreen()),
                // ),
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
