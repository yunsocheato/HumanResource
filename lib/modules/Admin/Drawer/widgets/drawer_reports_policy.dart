import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';
import 'Method_drawer_policy_button.dart';

class ReportPolicy extends GetView<AppDrawerController> {
  const ReportPolicy({super.key});

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
          bool isMobile = Get.width < 600;
          bool isDesktop = Get.width >= 1024;
          final isExpanded1 = controller.isExpanded1('Report Admin');
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.blue,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded1,
              onExpansionChanged:
                  (bool expanded) => controller.toggleTile1('Report Admin'),
              leading: Image.asset(
                'assets/icon/folder.png',
                width: iconSize,
                height: iconSize,
              ),
              title: Text(
                'Report Admin',
                style: TextStyle(
                  fontSize: fontSizeTitle,
                  color:
                      controller.selectedIndex.value == 9
                          ? Colors.blue.shade900
                          : (isMobile ? Colors.blue : Colors.white),
                  fontWeight:
                      controller.selectedIndex.value == 9
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
              iconColor: Colors.blue,
              collapsedIconColor: Colors.blue,
              childrenPadding: const EdgeInsets.only(left: 32),
              children: [
                _buildSubTile(
                  imagePath: 'assets/icon/usercheckin.png',
                  fontSize: fontSizeBody,
                  title: 'Checkin Report',
                  index: 10,
                  onTap: () => MethodButton6(),
                ),
                _buildSubTile(
                  imagePath: 'assets/icon/userlate.png',
                  fontSize: fontSizeBody,
                  title: 'Late Report',
                  index: 11,
                  onTap: () => MethodButton7(),
                ),
                _buildSubTile(
                  imagePath: 'assets/icon/userabsent.png',
                  fontSize: fontSizeBody,
                  title: 'Absent Report',
                  index: 12,
                  onTap: () => MethodButton9(),
                ),
                _buildSubTile(
                  imagePath: 'assets/icon/userleave.png',
                  fontSize: fontSizeBody,
                  title: 'Leave Report',
                  index: 13,
                  onTap: () => MethodButton8(),
                ),
                // _buildSubTile(
                //   fontSize: fontSizeBody,
                //   iconSize: iconSize,
                //   title: 'OT Report',
                //   icon: EneftyIcons.alarm_bold,
                //   index: 14,
                //   onTap: () => MethodButton10(),
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
