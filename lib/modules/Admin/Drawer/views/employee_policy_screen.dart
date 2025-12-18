import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/SnackBar/snack_bar.dart';
import '../controllers/employee_policy_controller.dart';

class EmployeePolicyScreen extends GetView<EmployeePolicyController> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  EmployeePolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveEmployeePolicy();
  }

  Widget _buildResponsiveEmployeePolicy() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

  Widget _buildPopDialogMobile() {
    final controller = Get.find<EmployeePolicyController>();
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
                      'USER UPDATE',
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: _buildSearchField(controller),
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
                                  child: const Text('UPDATE'),
                                  onPressed: () async {
                                    await controller.UpdateChange();
                                    WidgetsBinding.instance.addPostFrameCallback((
                                      _,
                                    ) {
                                      showAwesomeSnackBarGetx(
                                        "Success Update",
                                        "Update UserInfo on: ${controller.NameController.text} Successfully",
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
    final controller = Get.find<EmployeePolicyController>();
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
                      'USER UPDATE',
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: _buildSearchField(controller),
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
                                    controller.clearDataFields();
                                    controller.usernameSearchController.clear();
                                    controller.suggestionList.clear();
                                    Get.back();
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
                                  child: const Text('UPDATE'),
                                  onPressed: () async {
                                    await controller.UpdateChange();
                                    WidgetsBinding.instance.addPostFrameCallback((
                                      _,
                                    ) {
                                      showAwesomeSnackBarGetx(
                                        "UPDATE!",
                                        "Update UserInfo on: ${controller.Username.value} Successfully",
                                        ContentType.success,
                                      );
                                    });
                                    controller.clearDataFields();
                                    controller.usernameSearchController.clear();
                                    controller.suggestionList.clear();
                                    Get.back();
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

  Widget _buildUserInfoFields(EmployeePolicyController controller) {
    return Column(
      children: [
        _buildField(
          label: 'USER-ID',
          icon: Icons.verified_user,
          controller: controller.UserIDController,
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
          label: 'FINGER PRINT',
          icon: Icons.fingerprint,
          controller: controller.fingerprint_idController,
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
          label: 'ROLE',
          icon: Icons.star,
          controller: controller.RoleController,
        ),
        _buildField(
          label: 'JOIN DATE',
          icon: Icons.calendar_month,
          controller: controller.createAtController,
        ),
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

  Widget _buildUsernameAutoSuggestField(EmployeePolicyController controller) {
    final TextEditingController textController = TextEditingController(
      text: controller.Username.value,
    );

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: textController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'FIND USERNAME',
              suffixIcon: IconButton(
                icon: Icon(controller.icon, color: controller.color),
                onPressed: () {
                  controller.fetchbyusersemployee(textController.text);
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
                      textController.text = suggestion;
                      controller.Username.value = suggestion;
                      controller.fetchbyusersemployee(suggestion);
                      controller.suggestionList.clear();
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }

  Widget _buildSearchField(EmployeePolicyController controller) {
    return Obx(() {
      return Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.search,
            controller: controller.usernameSearchController,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            onFieldSubmitted: (value) {
              final query = value.trim();
              if (query.isNotEmpty) {
                controller.fetchbyusersemployee(query);
                controller.usernameSearchController.clear();
                controller.suggestionList.clear();
              }
            },
            decoration: InputDecoration(
              hintText: 'Search by Username',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final query = controller.usernameSearchController.text.trim();
                  if (query.isNotEmpty) {
                    controller.fetchbyusersemployee(query);
                    controller.usernameSearchController.clear();
                    controller.suggestionList.clear();
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) {
              controller.Username.value = v;
              if (v.trim().isNotEmpty) {
                controller.fetchSuggestions(v.trim());
              } else {
                controller.usernameSearchController.clear();
                controller.suggestionList.clear();
              }
            },
          ),
          if (controller.suggestionList.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 6),
              constraints: const BoxConstraints(maxHeight: 150),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.builder(
                itemCount: controller.suggestionList.length,
                itemBuilder: (_, index) {
                  final s = controller.suggestionList[index];
                  return ListTile(
                    title: Text(s),
                    onTap: () {
                      controller.usernameSearchController.text = s;
                      controller.Username.value = s;
                      controller.fetchbyusersemployee(s);
                      controller.usernameSearchController.clear();
                      controller.suggestionList.clear();
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
