import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
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
          final isExpanded1 = controller.isExpanded1('Report Admin');
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.white,
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
                          : Colors.white,
                  fontWeight:
                      controller.selectedIndex.value == 9
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
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

    return ListTile(
      leading: Image.asset(imagePath, width: imageSize, height: imageSize),
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color:
              isSelected
                  ? controller.Selectedcolors
                  : controller.Unselectedcolors,
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
