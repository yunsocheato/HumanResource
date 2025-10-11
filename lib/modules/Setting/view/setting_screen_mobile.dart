import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Setting/controller/setting_controller.dart';

import '../widget/Mobile/setting_screen_widget_appereance.dart';
import '../widget/Mobile/setting_screen_widget_general.dart';
import '../widget/Mobile/setting_screen_widget_notification.dart';


class SettingScreenMobile extends GetView<SettingController> {
  final context = Get.context;
   SettingScreenMobile({super.key});
  static const routeName = '/settingmobile';

  @override
  Widget build(BuildContext context) {
    return buildSettingMobile();
  }

  Widget buildSettingMobile() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(builder: (context)
            => IconButton(
              icon: Icon(EneftyIcons.arrow_circle_left_bold, color: Colors.white),
              onPressed: () => Get.back(),
            ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(EneftyIcons.menu_2_outline, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
        title: Text(
          'ACCOUNT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      endDrawer: _buildDrawerTile(),
    );
  }

  Widget _buildDrawerTile() {
    return Drawer(
      backgroundColor: Colors.black,
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
              Expanded(
                child: Obx(() {
                  switch (controller.selectedIndex.value) {
                    case 0:
                      return SettingScreenWidgetGeneralMobile();
                    case 1:
                      return SettingScreenWidgetappereanceMobile();
                    case 2:
                      return SettingScreenWidgetNotification();
                    default:
                      return SettingScreenWidgetGeneralMobile();
                  }
                }),
              ),
            ],
          ),
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
        decoration: isSelected ? BoxDecoration(
          color:  Colors.blue.shade900 ,
          borderRadius: BorderRadius.circular(8),
        ) : null,
        child: Row(
          children: [
            Icon(
              icon,
              color:  Colors.white,
              size: 14,
            ),
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
