import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controller/setting_controller.dart';

class SettingScreenWidgetappereanceMobile extends GetView<SettingController>{
  const SettingScreenWidgetappereanceMobile ({super.key });


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
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
            leading: IconButton(onPressed: (){
              Get.close(1);
            }, icon: Icon(Icons.close, color: Colors.white,))
        ),
        body: Container(),
      ),
    );
  }

}