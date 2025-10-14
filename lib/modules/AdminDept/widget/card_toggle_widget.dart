import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controller/overview_controller.dart';

class ControlToggleCard extends GetView<OverViewController> {
  final String title;
  final IconData icon;
  final Color color;
  final RxBool toggleState;
  final Function(bool) onChanged;

  const ControlToggleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.toggleState,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => Switch(
                    value: toggleState.value,
                    onChanged: onChanged,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
