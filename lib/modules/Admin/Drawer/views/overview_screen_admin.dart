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
import '../widgets/Method_drawer_policy_button.dart';

class OverviewAdmin extends GetView<AppDrawerController> {
  const OverviewAdmin({super.key});

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
          final isExpanded1 = controller.isExpanded1('Overview');
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.white,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded1,
              onExpansionChanged:
                  (bool expanded) => controller.toggleTile1('Overview'),
              leading: Image.asset(
                'assets/icon/overview.png',
                width: iconSize,
                height: iconSize,
              ),
              title: InkWell(
                onTap: () {
                  controller.selectedIndex.value = 0;
                  MethodButton1();
                },
                child: Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: fontSizeTitle,
                    color:
                        controller.selectedIndex.value == 0
                            ? Colors.blue.shade900
                            : Colors.white,
                    fontWeight:
                        controller.selectedIndex.value == 0
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
                  title: 'Own Profile',
                  fontSize: fontSizeBody,
                  Imagepath: 'assets/icon/user.png',
                  index: 100,
                  onTap: () => Get.offAllNamed('/userprofile'),
                ),
                _buildSubTile(
                  title: 'Mange Own Report',
                  fontSize: fontSizeBody,
                  Imagepath: 'assets/icon/folder.png',
                  index: 101,
                  onTap: () => Get.offAllNamed('/report'),
                ),
                _buildSubTile(
                  title: 'Your Attendance',
                  fontSize: fontSizeBody,
                  Imagepath: 'assets/icon/calendars.png',
                  index: 102,
                  onTap: () => Get.offAllNamed('/attendance_user'),
                ),
                _buildSubTile(
                  title: 'Change Password',
                  fontSize: fontSizeBody,
                  Imagepath: 'assets/icon/key.png',
                  index: 103,
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
    required String Imagepath,
    required int index,
    required VoidCallback onTap,
    double fontSize = 14,
    double imageSize = 22,
  }) {
    final controller = Get.find<AppDrawerController>();
    final isSelected = controller.selectedIndex.value == index;

    return ListTile(
      leading: Image.asset(Imagepath, width: imageSize, height: imageSize),
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
