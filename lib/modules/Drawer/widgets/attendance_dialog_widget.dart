import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/attendance_dialog_controller.dart';

class AttendanceDialog extends GetView<AttendanceDialogController> {
  const AttendanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator:
                (value) => !value!.contains('@') ? 'Invalid email' : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.submit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
