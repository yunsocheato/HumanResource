import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';

import '../../Utils/HoverMouse/controller/hover_mouse_controller.dart';

void DialogScreen(BuildContext context, Widget content) {
  final isMobile = MediaQuery.of(context).size.width < 600;
  final HoverMouseController controller = Get.put(HoverMouseController());

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return MouseHover(
        keyId: 9,
        controller: controller,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          insetPadding: EdgeInsets.all(16), // dialog margin
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 500,
            constraints: BoxConstraints(maxHeight: 350),
            child: content,
          ),
        ),
      );
    },
  );
}
