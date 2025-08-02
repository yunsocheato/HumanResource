import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/controllers/Leave_Policy_controller.dart';

class LeavePolicy extends GetView<LeavePolicyController> {
   final _formKey1 = GlobalKey<FormState>();
   final _formKey2 = GlobalKey<FormState>();
   LeavePolicy({super.key,});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveAttendanceStaff() ;
  }

  Widget _buildResponsiveAttendanceStaff(){
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

   Widget _buildPopDialogMobile() {
     final controller = Get.find<LeavePolicyController>();
     return Obx(() {
       return SingleChildScrollView(
         child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Container(
                 height: 60,
                 decoration: BoxDecoration(
                   color: Colors.blue.shade900,
                   shape: BoxShape.rectangle,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                 ),
                 child: Padding(
                   padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'LEAVE POLICY',
                         overflow: TextOverflow.ellipsis,
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       Icon(Icons.settings,color: Colors.white,)
                     ],
                   ),
                 ),
               ),
               const Divider(height: 1),
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: controller.isLoading.value
                     ? Center(child: CircularProgressIndicator(
                     color: Colors.blue.shade900))
                     : Form(
                     key: _formKey1,
                     child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 8.0),
                             child: TextFormField(
                               initialValue: controller.Username.value,
                               decoration: InputDecoration(
                                 labelText: 'FIND USERNAME',
                                 suffixIcon: InkWell(
                                     onTap: () {},
                                     child: Icon(controller.icon, color: controller.color)),
                                 border: const OutlineInputBorder(),
                               ),
                               validator: (value) =>
                               value == null || value
                                   .trim()
                                   .isEmpty
                                   ? 'Please enter a username'
                                   : null,
                               onSaved: (value) =>
                               controller.Username.value = value ?? '',
                             ),
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Obx(() => SwitchListTile(
                                 title:  Text('Is Probation'),
                                 value: controller.isSwitched1.value,
                                 onChanged: (value) => controller.isSwitched1.value = value,
                               )),
                               Obx(() {
                                 if (!controller.isSwitched1.value) return const SizedBox.shrink();
                                 return Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 8.0),
                                   child: Column(
                                     children: [
                                       CheckboxListTile(
                                         title: const Text('Block Annual Leave'),
                                         value: controller.blockAnualleave.value,
                                         onChanged: (value) => controller.blockAnualleave.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Block Vacation Leave'),
                                         value: controller.blockVacationleave.value,
                                         onChanged: (value) => controller.blockVacationleave.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Block Sick Leave'),
                                         value: controller.blockSickleave.value,
                                         onChanged: (value) => controller.blockSickleave.value = value ?? false,
                                       ),
                                     ],
                                   ),
                                 );
                               }),
                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Obx(() => SwitchListTile(
                                 title: const Text('Is Deduction'),
                                 value: controller.isSwitched2.value,
                                 onChanged: (value) => controller.isSwitched2.value = value,
                               )),
                               Obx(() => controller.isSwitched2.value
                                   ? Padding(
                                 padding: const EdgeInsets.only(top: 8.0),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       child: TextFormField(
                                         initialValue: controller.MonthlySalary.value,
                                         decoration: const InputDecoration(
                                           labelText: 'Monthly Salary',
                                           border: OutlineInputBorder(),
                                         ),
                                         validator: (value) => value == null || value.trim().isEmpty
                                             ? 'Please enter Monthly Salary'
                                             : null,
                                         onSaved: (value) => controller.MonthlySalary.value = value ?? '',
                                       ),
                                     ),
                                     const SizedBox(width: 8),
                                     Expanded(
                                       child: TextFormField(
                                         initialValue: controller.DailySalary.value,
                                         decoration: const InputDecoration(
                                           labelText: 'Daily Salary',
                                           border: OutlineInputBorder(),
                                         ),
                                         validator: (value) => value == null || value.trim().isEmpty
                                             ? 'Please enter Daily Salary'
                                             : null,
                                         onSaved: (value) => controller.DailySalary.value = value ?? '',
                                       ),
                                     ),
                                     const SizedBox(width: 8),
                                     Expanded(
                                       child: TextFormField(
                                         initialValue: controller.isLeave.value.toString(),
                                         decoration: const InputDecoration(
                                           labelText: 'In Minutes',
                                           border: OutlineInputBorder(),
                                         ),
                                         validator: (value) => value == null || value.trim().isEmpty
                                             ? 'Please enter In Minutes'
                                             : null,
                                         onSaved: (value) =>
                                         controller.isLeave.value = int.tryParse(value ?? '') ?? 0,
                                       ),
                                     ),
                                   ],
                                 ),
                               ) : const SizedBox.shrink()),
                             ],
                           ),
                           Obx(() =>
                               SwitchListTile(
                                 title: const Text('Is OverBalance'),
                                 value: controller.isSwitched3.value,
                                 onChanged: (value) =>
                                 controller.isSwitched3.value = value,
                               )),
                           const SizedBox(height: 16),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               TextButton(
                                 child: const Text('Close',style: TextStyle(color: Colors.red)),
                                 onPressed: () => Get.back(),
                               ),
                               const SizedBox(width: 8),
                               ElevatedButton(
                                 style: ElevatedButton.styleFrom(
                                   backgroundColor: Colors.blue.shade900,
                                   foregroundColor: Colors.white,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                 ),
                                 child: const Text('Update'),
                                 onPressed: () {
                                   if (_formKey1.currentState?.validate() ??
                                       false) {
                                     _formKey1.currentState?.save();
                                     Get.snackbar(
                                       'Success',
                                       'Leave Type Updated: ${controller
                                           .LeaveType.value}',
                                       snackPosition: SnackPosition.BOTTOM,
                                       backgroundColor: Colors.green.shade100,
                                       colorText: Colors.black,
                                     );
                                     Get.close(0);
                                   }
                                 },
                               ),
                             ],
                           ),
                         ]
                     )
                 ),
               ),
             ]
         ),

       );
     });
   }


   Widget _buildPopDialogOther() {
     final controller = Get.find<LeavePolicyController>();
     return Obx(() {
       return SingleChildScrollView(
         child:Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded(
                     child: Text(
                       'LEAVE POLICY',
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         color: Colors.blue.shade900,
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                   IconButton(
                     icon: Icon(Icons.close, color: Colors.blue.shade900),
                     onPressed: () => Get.back(),
                   ),
                 ],
               ),
             ),
             Divider(height: 1),
             Flexible(
               child: SingleChildScrollView(
                 padding: const EdgeInsets.all(16.0),
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
                           const SizedBox(height: 16),
                           Column(
                             children: [
                               Obx(() => SwitchListTile(
                                 title: const Text('Is Probation'),
                                 value: controller.isSwitched1.value,
                                 onChanged: (bool value) {
                                   controller.isSwitched1.value = value;
                                 },
                               ),
                               ),
                               Obx(() => controller.isSwitched1.value
                                   ? ListTile(
                                 title: Row(
                                   children: [
                                     Checkbox(
                                       value: controller.blockAnualleave.value,
                                       onChanged: (bool? value) {
                                         controller.blockAnualleave.value = value!;
                                       },
                                     ),
                                     const Text('Block Annual Leave'),
                                   ],
                                 ),
                               )
                                   : const SizedBox.shrink(),
                               ),
                             ],
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
               ),
             ),
           ],
         ),
       );
     });
   }
}