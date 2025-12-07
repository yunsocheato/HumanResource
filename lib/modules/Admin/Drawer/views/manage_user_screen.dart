import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:hrms/modules/Admin/Drawer/controllers/manage_users_controller.dart';

class ManageUserScreen extends GetView<ManageUsersController> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  ManageUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveEmployeePolicy();
  }

  Widget _buildResponsiveEmployeePolicy() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

  Widget _buildPopDialogMobile() {
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
                      'Manage Users',
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: _buildUsernameAutoSuggestField(controller),
                            ),
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
                                  onPressed: () {
                                    controller.suggestionList1.clear();
                                    controller.suggestionList2.clear();
                                    controller.suggestionList3.clear();

                                    controller.Username1.value = '';
                                    controller.Username2.value = '';
                                    controller.Username3.value = '';

                                    controller.NameController.clear();
                                    controller.UserIDController.clear();
                                    controller.Managebyname.clear();
                                    controller.headname.clear();
                                    controller.headposition.clear();

                                    if (Get.isDialogOpen == true ||
                                        Get.isBottomSheetOpen == true) {
                                      Get.back();
                                    }
                                  },
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
                                    await controller.createManageUser();
                                    WidgetsBinding.instance.addPostFrameCallback((
                                      _,
                                    ) {
                                      showAwesomeSnackBarGetx(
                                        "Manage User",
                                        "Set up Manage Username : ${controller.NameController.text} Successfully",
                                        ContentType.success,
                                      );
                                    });
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
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade900,
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
                      'Manage Users',
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: _buildUsernameAutoSuggestField(controller),
                            ),
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
                                    await controller.createManageUser();
                                    WidgetsBinding.instance.addPostFrameCallback((
                                      _,
                                    ) {
                                      showAwesomeSnackBarGetx(
                                        "Manage User",
                                        "Set up Manage Username : ${controller.NameController.text} Successfully",
                                        ContentType.success,
                                      );
                                    });
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

  Widget _buildUserInfoFields(ManageUsersController controller) {
    return Column(
      children: [
        _buildField(
          label: 'User ID',
          icon: Icons.perm_identity_outlined,
          controller: controller.UserIDController,
        ),
        _buildField(
          label: 'Staff Name',
          icon: Icons.person,
          controller: controller.NameController,
        ),
        _buildField(
          label: 'Staff Manager',
          icon: Icons.group,
          controller: controller.Managebyname,
        ),
        _buildField(
          label: 'Head Department Name',
          icon: Icons.person_2,
          controller: controller.headname,
        ),
        _buildField(
          label: 'Head Department Position',
          icon: Icons.star,
          controller: controller.headposition,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green.shade900),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildUsernameAutoSuggestField(ManageUsersController controller) {
    final textController1 = TextEditingController(
      text: controller.Username1.value,
    );
    final textController2 = TextEditingController(
      text: controller.Username2.value,
    );
    final textController3 = TextEditingController(
      text: controller.Username3.value,
    );

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: textController1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Staff Name',
              suffixIcon: IconButton(
                icon: Icon(Icons.person_2, color: controller.color),
                onPressed: () {
                  controller.fetchbyusersemployee(textController1.text);
                },
              ),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              controller.Username1.value = value;
            },
          ),
          if (controller.suggestionList1.isNotEmpty &&
              controller.Username1.value.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              constraints: const BoxConstraints(maxHeight: 150),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.suggestionList1.length,
                itemBuilder: (context, index) {
                  final suggestion = controller.suggestionList1[index];
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      textController1.text = suggestion;
                      controller.Username1.value = suggestion;
                      controller.fetchbyusersemployee(
                        suggestion,
                        fieldIndex: 1,
                      );
                      controller.suggestionList1.clear();
                    },
                  );
                },
              ),
            ),
          SizedBox(height: 16),
          TextFormField(
            controller: textController2,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Staff Manager',
              suffixIcon: IconButton(
                icon: Icon(Icons.person_2, color: controller.color),
                onPressed: () {
                  controller.fetchbyusersemployee(textController2.text);
                },
              ),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              controller.Username2.value = value;
            },
          ),
          if (controller.suggestionList2.isNotEmpty &&
              controller.Username2.value.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              constraints: const BoxConstraints(maxHeight: 150),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.suggestionList2.length,
                itemBuilder: (context, index) {
                  final suggestion = controller.suggestionList2[index];
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      textController2.text = suggestion;
                      controller.Username2.value = suggestion;
                      controller.fetchbyusersemployee(
                        textController2.text,
                        fieldIndex: 2,
                      );
                      controller.suggestionList2.clear();
                    },
                  );
                },
              ),
            ),
          SizedBox(height: 16),
          TextFormField(
            controller: textController3,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Head Department Name',
              suffixIcon: IconButton(
                icon: Icon(Icons.person_2, color: controller.color),
                onPressed: () {
                  controller.fetchbyusersemployee(textController3.text);
                },
              ),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              controller.Username3.value = value;
            },
          ),
          if (controller.suggestionList2.isNotEmpty &&
              controller.Username3.value.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              constraints: const BoxConstraints(maxHeight: 150),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.suggestionList3.length,
                itemBuilder: (context, index) {
                  final suggestion = controller.suggestionList3[index];
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      textController3.text = suggestion;
                      controller.Username3.value = suggestion;
                      controller.fetchbyusersemployee(
                        textController3.text,
                        fieldIndex: 3,
                      );
                      controller.suggestionList3.clear();
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }
}
