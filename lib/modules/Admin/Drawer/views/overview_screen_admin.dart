import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';

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
          final isExpanded1 = controller.isExpanded1('Overview');
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
                            : (isMobile ? Colors.blue : Colors.white),
                    fontWeight:
                        controller.selectedIndex.value == 0
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
                  onTap: () => Get.offAllNamed('/email_verify'),
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
    final isMobile = Get.width < 600;
    return ListTile(
      leading: Image.asset(Imagepath, width: imageSize, height: imageSize),
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
