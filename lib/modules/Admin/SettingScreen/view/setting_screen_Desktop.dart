import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import '../controller/setting_controller.dart';
import '../widget/Desktop/setting_screen_widget_appeareance.dart';
import '../widget/Desktop/setting_screen_widget_general.dart';
import '../widget/Desktop/setting_screen_widget_notification.dart';

class SettingScreen extends GetView<SettingController> {
  final isMobile = Get.width < 600;

  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveContent();
  }

  Widget _buildResponsiveContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildResponsiveDesktop();
      },
    );
  }

  Widget _buildResponsiveDesktop() {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 170,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.black,
            ),
            child: Obx(
              () => ListView(
                children: [
                  SizedBox(
                    height: 63,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.black12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/setting_icons.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DODG5.ttf',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildSidebarItem(
                    index: 0,
                    icon: EneftyIcons.setting_3_bold,
                    label: "General",
                  ),
                  _buildSidebarItem(
                    index: 1,
                    icon: Boxicons.bx_aperture,
                    label: "Appearance",
                  ),
                  _buildSidebarItem(
                    index: 2,
                    icon: EneftyIcons.notification_2_bold,
                    label: "Notification",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              switch (controller.selectedIndex.value) {
                case 0:
                  return settingWidgetGenearal();
                case 1:
                  return settingWidgetAppeareance();
                case 2:
                  return settingWidgetNotification();
                default:
                  return settingWidgetGenearal();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.selectedIndex.value = index,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration:
            isSelected
                ? BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(8),
                )
                : null,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
