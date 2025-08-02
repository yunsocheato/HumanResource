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
                                 title:  Text('Policy Probation',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
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
                                 title: const Text('Policy Deduction',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
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
                           Column(
                             children: [
                               Obx(() =>
                                   SwitchListTile(
                                     title: const Text('Policy OverBalance',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                     value: controller.isSwitched3.value,
                                     onChanged: (value) =>
                                     controller.isSwitched3.value = value,
                                   )
                               ),
                               Obx(() {
                                 if (!controller.isSwitched3.value) return const SizedBox.shrink();
                                 return Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 8.0),
                                   child: Column(
                                     children: [
                                       CheckboxListTile(
                                         title: const Text('User have Limited on Leave Balance'),
                                         value: controller.leavebalancepolicy.value,
                                         onChanged: (value) => controller.leavebalancepolicy.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Cannot Leave During Probation'),
                                         value: controller.useragreement.value,
                                         onChanged: (value) => controller.useragreement.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Only Unpaid Leave during Probation'),
                                         value: controller.leavepolicyagreement.value,
                                         onChanged: (value) => controller.leavepolicyagreement.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Sick leave Need Doctor Certificate'),
                                         value: controller.leaveagreement.value,
                                         onChanged: (value) => controller.leaveagreement.value = value ?? false,
                                       ),
                                     ],
                                   ),
                                 );
                               }),
                             ],
                           ),
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
                                 child: const Text('Create'),
                                 onPressed: () {
                                   if (_formKey1.currentState?.validate() ??
                                       false) {
                                     _formKey1.currentState?.save();
                                     Get.snackbar(
                                       'Success',
                                       'Leave Policy Create: ${controller
                                           .Usernames.value}',
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
                     key: _formKey2,
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
                                 title:  Text('Policy Probation',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
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
                                         title: const Text('Block Annual Leave',style: TextStyle(fontSize: 12),),
                                         value: controller.blockAnualleave.value,
                                         onChanged: (value) => controller.blockAnualleave.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Block Vacation Leave',style: TextStyle(fontSize: 12),),
                                         value: controller.blockVacationleave.value,
                                         onChanged: (value) => controller.blockVacationleave.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Block Sick Leave',style: TextStyle(fontSize: 12),),
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
                                 title: const Text('Policy Deduction',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
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
                           Column(
                             children: [
                               Obx(() =>
                                   SwitchListTile(
                                     title: const Text('Policy OverBalance',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                     value: controller.isSwitched3.value,
                                     onChanged: (value) =>
                                     controller.isSwitched3.value = value,
                                   )
                               ),
                               Obx(() {
                                 if (!controller.isSwitched3.value) return const SizedBox.shrink();
                                 return Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 8.0),
                                   child: Column(
                                     children: [
                                       CheckboxListTile(
                                         title: const Text('User have Limited on Leave Balance',style: TextStyle(fontSize: 12),),
                                         value: controller.leavebalancepolicy.value,
                                         onChanged: (value) => controller.leavebalancepolicy.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Cannot Leave During Probation',style: TextStyle(fontSize: 12),),
                                         value: controller.useragreement.value,
                                         onChanged: (value) => controller.useragreement.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Only Unpaid Leave during Probation',style: TextStyle(fontSize: 12),),
                                         value: controller.leavepolicyagreement.value,
                                         onChanged: (value) => controller.leavepolicyagreement.value = value ?? false,
                                       ),
                                       CheckboxListTile(
                                         title: const Text('Sick leave Need Doctor Certificate',style: TextStyle(fontSize: 12),),
                                         value: controller.leaveagreement.value,
                                         onChanged: (value) => controller.leaveagreement.value = value ?? false,
                                       ),
                                     ],
                                   ),
                                 );
                               }),
                             ],
                           ),
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
                                 child: const Text('Create'),
                                 onPressed: () {
                                   if (_formKey2.currentState?.validate() ??
                                       false) {
                                     _formKey2.currentState?.save();
                                     Get.snackbar(
                                       'Success',
                                       'Leave Policy Created: ${controller
                                           .Usernames.value}',
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
}