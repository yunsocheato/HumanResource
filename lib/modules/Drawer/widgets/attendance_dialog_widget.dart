import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/attendance_dialog_controller.dart';

class AttendanceDialog extends GetView<AttendanceDialogController> {
  final Widget content;
   AttendanceDialog(this.content, {super.key ,});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.5),
      shadowColor: Colors.grey,
      shape: CircleBorder(),
      child: AlertDialog(
        content: content,
      ),
    );
  }
}
