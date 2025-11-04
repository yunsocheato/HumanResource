import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controller/hover_mouse_controller.dart';

class MouseHover extends GetView<HoverMouseController> {
  final int keyId;
  final Widget child;
  final HoverMouseController controller;
  const MouseHover({
    required this.child,
    required this.keyId,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hovering = controller.isHovering(keyId);
      return MouseRegion(
        onEnter: (_) => controller.setHovering(keyId, true),
        onExit: (_) => controller.setHovering(keyId, false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          transform: hovering ? Matrix4.identity() : Matrix4.identity(),
          child: Transform.translate(
            offset: hovering ? const Offset(0, -10) : Offset.zero,
            child: child,
          ),
        ),
      );
    });
  }
}
