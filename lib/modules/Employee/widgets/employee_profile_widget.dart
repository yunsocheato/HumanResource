import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Employee/views/employee_profile_screen.dart';
import '../Controller/employee_profile_controller.dart';

class EmployeeProfileWidget extends GetView<EmployeeProfileController> {
  const EmployeeProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 600;
    return isMobile ? _buildMobile(context) : _buildDesktop(context);
  }

  Widget _buildMobile(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(title: 'Employee Profile', fontSize: 15, height: 30),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: controller.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue.shade900,
                ),
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildUsernameAutoSuggestField(),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text('Close',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDesktop(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(title: 'Employee Profile', fontSize: 18, height: 60),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: controller.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue.shade900,
                ),
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildUsernameAutoSuggestField(),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text('Close',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(
      {required String title, required double fontSize, required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.settings, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameAutoSuggestField() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: controller.Username.value,
            decoration: InputDecoration(
              labelText: 'FIND USERNAME',
              suffixIcon: IconButton(
                icon: Icon(controller.icon, color: controller.color),
                onPressed: () {
                  if (controller.Username.value.isNotEmpty) {
                    controller.fetchbyusersemployeeProfile(
                      controller.Username.value,
                    );
                    Get.to(() => EmployeeProfileScreen());
                  }
                },
              ),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              controller.Username.value = value;
            },
          ),

          if (controller.suggestionList.isNotEmpty &&
              controller.Username.value.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              constraints: const BoxConstraints(maxHeight: 150),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.suggestionList.length,
                itemBuilder: (context, index) {
                  final suggestion = controller.suggestionList[index];
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      controller.Username.value = suggestion;
                      controller.fetchbyusersemployeeProfile(suggestion);
                      controller.suggestionList.clear();
                      Get.to(() => EmployeeProfileScreen());
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }

  // Widget _buildUserInfoFields() {
  //   return Obx(() {
  //     if (HoverMouse.isLoading.value) {
  //       return Center(
  //         child: CircularProgressIndicator(color: Colors.blue.shade900),
  //       );
  //     } else {
  //       return Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(8),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.5),
  //               spreadRadius: 2,
  //               blurRadius: 5,
  //               offset: const Offset(0, 3),
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               /// Avatar
  //               Center(
  //                 child: Stack(
  //                   alignment: Alignment.bottomRight,
  //                   children: [
  //                     CircleAvatar(
  //                       radius: 50,
  //                       backgroundImage: HoverMouse.userProfile?.image != null &&
  //                           HoverMouse.userProfile!.image!.isNotEmpty
  //                           ? NetworkImage(HoverMouse.userProfile!.image!)
  //                           : const AssetImage(
  //                           'assets/images/default_avatar.png')
  //                       as ImageProvider,
  //                     ),
  //                     IconButton(
  //                       onPressed: () => HoverMouse.updateUserInfo(),
  //                       icon: const Icon(Boxicons.bx_camera,
  //                           color: Colors.blue),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //
  //               /// Role
  //               const Text('Role', style: TextStyle(fontWeight: FontWeight.bold)),
  //               const SizedBox(height: 3),
  //               TextFormField(
  //                 initialValue: HoverMouse.RoleUserTextController.text,
  //                 decoration: const InputDecoration(labelText: 'Role'),
  //                 enabled: false,
  //               ),
  //
  //               /// Department
  //               const SizedBox(height: 12),
  //               const Text('Department',
  //                   style: TextStyle(fontWeight: FontWeight.bold)),
  //               const SizedBox(height: 3),
  //               TextFormField(
  //                 initialValue: HoverMouse.departmentController.text,
  //                 decoration: const InputDecoration(labelText: 'Department'),
  //                 onChanged: (val) => HoverMouse.updateUserInfo(),
  //               ),
  //
  //               const SizedBox(height: 20),
  //               const Text('Employee Information',
  //                   style: TextStyle(fontWeight: FontWeight.bold)),
  //               const SizedBox(height: 8),
  //
  //               TextFormField(
  //                 initialValue: HoverMouse.nameController.text,
  //                 decoration: const InputDecoration(labelText: 'First Name'),
  //                 enabled: false,
  //               ),
  //               TextFormField(
  //                 initialValue: HoverMouse.emailController.text,
  //                 decoration: const InputDecoration(labelText: 'Email Address'),
  //                 enabled: false,
  //               ),
  //               TextFormField(
  //                 initialValue: HoverMouse.phoneController.text,
  //                 decoration: const InputDecoration(labelText: 'Phone Number'),
  //                 enabled: false,
  //               ),
  //               TextFormField(
  //                 initialValue: HoverMouse.positionController.text,
  //                 decoration: const InputDecoration(labelText: 'Position'),
  //                 enabled: false,
  //               ),
  //
  //               const SizedBox(height: 20),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: () => HoverMouse.isEnabled(),
  //                     child: const Text('Enable Editing'),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   ElevatedButton(
  //                     onPressed: () => HoverMouse.updateUserInfo(),
  //                     child: const Text('Save Changes'),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   OutlinedButton(
  //                     onPressed: () => Get.back(),
  //                     child: const Text('Cancel'),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }
}
