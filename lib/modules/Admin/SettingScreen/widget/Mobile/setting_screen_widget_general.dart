import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/setting_controller.dart';

class SettingScreenWidgetGeneralMobile extends GetView<SettingController> {
  const SettingScreenWidgetGeneralMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return buildSettingMobile();
  }

  Widget buildSettingMobile() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.items[controller.selectedIndex.value],
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 56,
        leading: IconButton(
          onPressed: () {
            Get.close(1);
          },
          icon: Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: Container(),
    );
  }
}
