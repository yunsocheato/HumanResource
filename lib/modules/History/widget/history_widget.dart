import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:hrms/modules/History/controller/history_controller.dart';

import '../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';

class HistoryWidget extends GetView<HistoryController>{
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildContentResponsive();
  }

  Widget _buildContentResponsive() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileResponsive();
        } else {
          return _buildDesktopResponsive();
        }
      },
    );
  }

  Widget _buildMobileResponsive(){
    final HoverMouseController controller = Get.put(HoverMouseController());

    return Container(
      height: 200,
      width: double.infinity,
      child: MouseHover(
        keyId: 10,
        controller: controller,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
          )
        ),
      ),
    );
  }

  Widget _buildDesktopResponsive(){
    return Container();
  }

}