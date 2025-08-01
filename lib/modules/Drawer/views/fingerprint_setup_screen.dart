import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/Fingerprint_dialog_controller.dart';

class FingerPrintSetup extends GetView<FingerprintDialogController> {
   final _formKey1 = GlobalKey<FormState>();
   final _formKey2 = GlobalKey<FormState>();
   FingerPrintSetup({super.key,});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveAttendanceStaff() ;
  }

  Widget _buildResponsiveAttendanceStaff(){
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

   Widget _buildPopDialogMobile() {
    final controller = Get.find<FingerprintDialogController>();
     return Obx(() {
       return SingleChildScrollView(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             if (controller.isLoading.value)
               Center(child: CircularProgressIndicator(color: Colors.blue.shade900)),
             Form(
               key: _formKey1,
               child: Column(
                 children: [
                   Obx( () => TextFormField(
                       initialValue: controller.Username.value,
                       decoration: const InputDecoration(
                         labelText: 'USERNAME',
                         border: OutlineInputBorder(),
                       ),
                       validator: (value) {
                         if (value == null || value.trim().isEmpty) {
                           return 'Please enter a username';
                         }
                         return null;
                       },
                       onSaved: (value) => controller.Username.value = value ?? '',
                     ),
                   ),
                   const SizedBox(height: 5),
                   Obx(() => TextFormField(
                       initialValue: controller.LeaveType.value,
                       decoration: const InputDecoration(
                         labelText: 'LeaveType',
                         border: OutlineInputBorder(),
                       ),
                       validator: (value) {
                         if (value == null || value.trim().isEmpty) {
                           return 'Please enter a leave type';
                         }
                         return null;
                       },
                       onSaved: (value) => controller.LeaveType.value = value ?? '',
                     ),
                   ),
                   const SizedBox(height: 16),
                   Obx( () =>
                      SwitchListTile(
                       title: const Text('Is Probation'),
                       value: controller.isSwitched1.value,
                       onChanged: (bool value) {
                         controller.isSwitched1.value = value;
                       },
                     ),
                   ),
                   Obx(() =>
                      SwitchListTile(
                       title: const Text('Is Deduction'),
                       value: controller.isSwitched2.value,
                       onChanged: (bool value) {
                           controller.isSwitched2.value = value;
                       },
                     ),
                   ),
                   Obx(() =>
                       SwitchListTile(
                         title: const Text('Is OverBalance'),
                         value: controller.isSwitched3.value,
                         onChanged: (bool value) {
                           controller.isSwitched3.value = value;
                         },
                       )
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 16),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 TextButton(
                   child: const Text('Close'),
                   onPressed: () => Get.back(),
                 ),
                 const SizedBox(width: 8),
                 ElevatedButton(
                   child: const Text('Update'),
                   onPressed: () {
                     if (_formKey1.currentState?.validate() ?? false) {
                       _formKey1.currentState?.save();
                       Get.snackbar(
                         'Success',
                         'Leave Type Updated: ${controller.LeaveType.value}',
                         snackPosition: SnackPosition.BOTTOM,
                         backgroundColor: Colors.green.shade100,
                         colorText: Colors.black,
                       );
                       Get.back();
                     }
                   },
                 ),
               ],
             ),
           ],
         ),
       );
     });
   }
   Widget _buildPopDialogOther() {
     final controller = Get.find<FingerprintDialogController>();
     return Obx(() {
       return SingleChildScrollView(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             if (controller.isLoading.value)
               Center(child: CircularProgressIndicator(color: Colors.blue.shade900)),
             Form(
               key: _formKey2,
               child: Column(
                 children: [
                   Obx( () => TextFormField(
                     initialValue: controller.Username.value,
                     decoration: const InputDecoration(
                       labelText: 'USERNAME',
                       border: OutlineInputBorder(),
                     ),
                     validator: (value) {
                       if (value == null || value.trim().isEmpty) {
                         return 'Please enter a username';
                       }
                       return null;
                     },
                     onSaved: (value) => controller.Username.value = value ?? '',
                   ),
                   ),
                   const SizedBox(height: 5),
                   Obx(() => TextFormField(
                     initialValue: controller.LeaveType.value,
                     decoration: const InputDecoration(
                       labelText: 'LeaveType',
                       border: OutlineInputBorder(),
                     ),
                     validator: (value) {
                       if (value == null || value.trim().isEmpty) {
                         return 'Please enter a leave type';
                       }
                       return null;
                     },
                     onSaved: (value) => controller.LeaveType.value = value ?? '',
                   ),
                   ),
                   const SizedBox(height: 16),
                   Obx( () =>
                       SwitchListTile(
                         title: const Text('Is Probation'),
                         value: controller.isSwitched1.value,
                         onChanged: (bool value) {
                             controller.isSwitched1.value = value;
                         },
                       ),
                   ),
                   Obx(() =>
                       SwitchListTile(
                         title: const Text('Is Deduction'),
                         value: controller.isSwitched2.value,
                         onChanged: (bool value) {
                           controller.isSwitched2.value = value;
                         },
                       ),
                   ),
                   Obx(() =>
                       SwitchListTile(
                         title: const Text('Is OverBalance'),
                         value: controller.isSwitched3.value,
                         onChanged: (bool value) {
                           controller.isSwitched3.value = value;
                         },
                       )
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 16),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 TextButton(
                   child: const Text('Close'),
                   onPressed: () => Get.back(),
                 ),
                 const SizedBox(width: 8),
                 ElevatedButton(
                   child: const Text('Update'),
                   onPressed: () {
                     if (_formKey2.currentState?.validate() ?? false) {
                       _formKey2.currentState?.save();
                       Get.snackbar(
                         'Success',
                         'Leave Type Updated: ${controller.LeaveType.value}',
                         snackPosition: SnackPosition.BOTTOM,
                         backgroundColor: Colors.green.shade100,
                         colorText: Colors.black,
                       );
                       Get.back();
                     }
                   },
                 ),
               ],
             ),
           ],
         ),
       );
     });
   }
}