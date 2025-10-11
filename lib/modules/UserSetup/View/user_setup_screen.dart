import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/modules/UserSetup/Controller/user_setup_controller.dart';

class UserSetupScreen extends GetView<UserSetupScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  UserSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveEmployeePolicy();
  }

  Widget _buildResponsiveEmployeePolicy() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

  Widget _buildPopDialogMobile() {
    final controller = Get.find<UserSetupController>();
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green.shade900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Employee Policy',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  controller.isLoading.value
                      ? Center(
                        child: LinearProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      )
                      : Form(
                        key: _formKey1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildUserInfoFields(controller),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () => Get.back(),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('CREATE'),
                                  onPressed: () async {
                                    await controller.createuser();
                                    Get.snackbar(
                                      'New Create User',
                                      'Set up New Account on : ${controller.NameController.text} Successfully',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.white.withOpacity(
                                        0.3,
                                      ),
                                      colorText: Colors.black,
                                    );
                                    Get.close(0);
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

  Widget _buildPopDialogOther() {
    final controller = Get.find<UserSetupController>();
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red.shade900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Create UserAccount',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      )
                      : Form(
                        key: _formKey2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildUserInfoFields(controller),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () => Get.back(),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('CREATE'),
                                  onPressed: () async {
                                    await controller.createuser();
                                    Get.snackbar(
                                      'New Create User',
                                      'Set up New Account on : ${controller.NameController.text} Successfully',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.white.withOpacity(
                                        0.3,
                                      ),
                                      colorText: Colors.black,
                                    );
                                    Get.close(0);
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

  Widget _buildUserInfoFields(UserSetupController controller) {
    return Column(
      children: [
        _buildField(
          label: 'FINGER PRINT',
          icon: Icons.fingerprint,
          controller: controller.fingerprint_idController,
        ),
        _buildField(
          label: 'USERNAME',
          icon: Icons.person,
          controller: controller.NameController,
        ),
        _buildField(
          label: 'EMAIL',
          icon: Icons.email,
          controller: controller.EmailController,
        ),
        _buildField(
          label: 'Password',
          icon: Icons.password,
          controller: controller.passwordController,
        ),
        _buildField(
          label: 'ROLE',
          icon: Icons.star,
          controller: controller.RoleController,
        ),
        _buildField(
          label: 'Position',
          icon: Icons.chair,
          controller: controller.poisitionController,
        ),
        _buildField(
          label: 'DEPARTMENT',
          icon: Icons.apartment,
          controller: controller.DepartmentController,
        ),
        _buildField(
          label: 'ID CARD',
          icon: Icons.photo_camera_front_rounded,
          controller: controller.id_cardController,
        ),
        _buildField(
          label: 'PHONE',
          icon: Icons.phone,
          controller: controller.PhoneController,
        ),
        _buildField(
          label: 'ADDRESS',
          icon: Icons.add_location_alt_outlined,
          controller: controller.AddressController,
        ),
        _buildField(
          label: 'JOIN DATE',
          icon: Icons.calendar_month,
          controller: controller.createAtController,
        ),
        // Column(
        //   children: [
        //     Row(
        //       children: [
        //         Expanded(
        //           child: CheckboxListTile(
        //             contentPadding: EdgeInsets.zero,
        //             title: const Text('Restrict'),
        //             value: controller.usercannotchange.value,
        //             onChanged: (value) =>
        //             controller.usercannotchange.value = value ?? false,
        //           ),
        //         ),
        //         Expanded(
        //           child: CheckboxListTile(
        //             contentPadding: EdgeInsets.zero,
        //             title: const Text('Unrestrict'),
        //             value: controller.usercanchange.value,
        //             onChanged: (value) =>
        //             controller.usercanchange.value = value ?? false,
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 8),
        //     Row(
        //       children: [
        //         Expanded(
        //           child: CheckboxListTile(
        //             contentPadding: EdgeInsets.zero,
        //             title: const Text('Restrict'),
        //             value: controller.usercannotchange.value,
        //             onChanged: (value) =>
        //             controller.usercannotchange.value = value ?? false,
        //           ),
        //         ),
        //         Expanded(
        //           child: CheckboxListTile(
        //             contentPadding: EdgeInsets.zero,
        //             title: const Text('Unrestrict'),
        //             value: controller.usercanchange.value,
        //             onChanged: (value) =>
        //             controller.usercanchange.value = value ?? false,
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 8),
        //     Row(
        //       children: [
        //         Expanded(
        //           child: CheckboxListTile(
        //             contentPadding: EdgeInsets.zero,
        //             title: const Text('Restrict'),
        //             value: controller.usercannotchange.value,
        //             onChanged: (value) =>
        //             controller.usercannotchange.value = value ?? false,
        //           ),
        //         ),
        //         Expanded(
        //           child: CheckboxListTile(
        //             contentPadding: EdgeInsets.zero,
        //             title: const Text('Unrestrict'),
        //             value: controller.usercanchange.value,
        //             onChanged: (value) =>
        //             controller.usercanchange.value = value ?? false,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    final controller1 = Get.find<UserSetupController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: controller1.color),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
