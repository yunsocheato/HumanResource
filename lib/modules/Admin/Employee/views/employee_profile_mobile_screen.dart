import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hrms/Core/user_profile_controller.dart';
import 'package:hrms/Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import 'package:hrms/modules/Admin/Drawer/views/drawer_screen.dart';
import 'package:hrms/modules/Admin/Employee/Controller/employee_profile_controller.dart';
import 'package:hrms/modules/Admin/Employee/widgets/employee_profile_circleavatar.dart';
import 'package:hrms/modules/AdminDept/widget/bottom_appbar_widget1.dart';
import 'package:hrms/modules/AdminDept/widget/drawer_widget.dart';

class EmployeeProfileMobile extends GetView<EmployeeProfileController> {
  const EmployeeProfileMobile({super.key});
  static const String routeName = '/employee_profile_mobile';

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<UserProfileController>();
    return Obx(() {
      final profile = profileController.userprofiles.value;
      if (profile == null) {
        return const Center(child: CircularProgressIndicator());
      }
      final role = profile.role.toLowerCase();
      final bool isAdmin = role == 'admin' || role == 'superadmin';
      final bool isUserSide = role == 'admindept' || role == 'user';

      final isMobile = Get.width < 900;
      if (!isMobile) {
        Future.microtask(() => Get.offAllNamed('/dashboard'));
        return const SizedBox();
      }

      final contents =
          isAdmin
              ? Drawerscreen(
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 10,
                        ),
                        child: _buildMobileContent(),
                      ),
                    ],
                  ),
                ),
              )
              : DrawerAdmin(
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 10,
                        ),
                        child: _buildMobileContent(),
                      ),
                    ],
                  ),
                ),
              );
      if (isMobile) {
        return isAdmin
            ? BottomAppBarWidget(body: contents)
            : BottomAppBarWidget1(body: contents);
      } else {
        return contents;
      }
    });
  }

  Widget _buildMobileContent() {
    final size = MediaQuery.of(Get.context!).size;
    final bottomBarHeight = kBottomNavigationBarHeight;

    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade700],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -30,
              right: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned.fill(
              top: size.height * 0.15,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 12,
                    right: 12,
                    bottom: bottomBarHeight + 12,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 16),
                        _buildUsernameAutoSuggestField(controller),
                        const SizedBox(height: 16),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue.shade900,
                              ),
                            );
                          }
                          if (controller.Username.value.isEmpty ||
                              controller.nameText.value.isEmpty) {
                            return const Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Not Search Yet',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Column(
                            children: [
                              Obx(
                                () => buildProfileAvatar(
                                  controller.profileImageUrl.value,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(
                                () => Text(
                                  controller.nameText.value,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Obx(
                                () => Text(
                                  controller.positionText.value,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(
                                () => _mobileInfoRow(
                                  'Email',
                                  controller.emailText.value,
                                ),
                              ),
                              Obx(
                                () => _mobileInfoRow(
                                  'ID CARD',
                                  controller.idCardText.value,
                                ),
                              ),
                              Obx(
                                () => _mobileInfoRow(
                                  'Department',
                                  controller.departmentText.value,
                                ),
                              ),
                              Obx(
                                () => _mobileInfoRow(
                                  'Type',
                                  controller.roleText.value,
                                ),
                              ),
                              const Divider(height: 32),
                              _buildSidebarItem(
                                'Status',
                                'Onboarding'.obs,
                                Colors.black54,
                                Icons.star,
                                null,
                              ),
                              _buildSidebarItem(
                                'Email',
                                controller.emailText,
                                Colors.blue,
                                Icons.email,
                                controller.emailController,
                              ),
                              _buildSidebarItem(
                                'Phone',
                                controller.phoneText,
                                Colors.blue,
                                Icons.phone,
                                controller.phoneController,
                              ),
                              _buildSidebarItem(
                                'Address',
                                controller.addressText,
                                Colors.blue,
                                Icons.location_on,
                                controller.addressController,
                              ),
                              const SizedBox(height: 16),
                              _buildInformationCard(
                                title: 'Basic Information',
                                color: Colors.blue.shade700,
                                color1: Colors.blue,
                                fields: _getBasicInformationFields(),
                              ),
                              const SizedBox(height: 16),
                              _buildInformationCard(
                                title: 'Contact Information',
                                color: Colors.green.shade700,
                                color1: Colors.green,
                                fields: _getContactInformationFields(),
                              ),
                              const SizedBox(height: 16),
                              _buildInformationCard(
                                title: 'Work Information',
                                color: Colors.orange.shade700,
                                color1: Colors.orange,
                                fields: _getWorkInformationFields(),
                              ),
                              const SizedBox(height: 30),
                              _buildButtons(controller),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameAutoSuggestField(EmployeeProfileController controller) {
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
              if (value.isNotEmpty) {
                controller.suggestionList.clear();
                controller.usernameSearchController.clear();
                controller.fetchbyusersemployeeProfile(value);
                Future.microtask(() {
                  controller.suggestionList.clear();
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Search by Username',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.fetchbyusersemployeeProfile(
                    controller.Username.value,
                  );
                  controller.suggestionList.clear();
                  controller.usernameSearchController.clear();
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) {
              controller.Username.value = v;
              if (v.isNotEmpty) {
                controller.fetchSuggestionsProfile(v);
              } else {
                controller.suggestionList.clear();
              }
            },
          ),

          if (controller.suggestionList.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 6),
              constraints: const BoxConstraints(maxHeight: 150),
              decoration: BoxDecoration(
                color: Colors.white24,
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
                      controller.fetchbyusersemployeeProfile(s);
                      controller.usernameSearchController.clear();
                      Future.microtask(() {
                        controller.suggestionList.clear();
                      });
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.offAllNamed('/dashboard');
                  controller.clearDataFields();
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'STAFF PROFILE',
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: '7TH.ttf',
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue.shade900,
              decorationThickness: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _mobileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    String label,
    RxString observable,
    Color valueColor,
    IconData icon,
    TextEditingController? ctrl,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.yellow, size: 14),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Obx(
              () => Text(
                observable.value,
                style: TextStyle(
                  fontSize: 14,
                  color: valueColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationCard({
    required String title,
    required List<Map<String, dynamic>> fields,
    required Color color,
    required Color color1,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Obx(
                  () => TextButton(
                    onPressed: controller.toggleEnable,
                    child: Text(
                      controller.isEnabled.value ? 'Cancel Edit' : 'Edit',
                      style: TextStyle(
                        color: color1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...fields.map(
              (field) => _buildInfoRow(
                field['label'] as String,
                field['icon'] as IconData,
                field['observable'] as RxString,
                field['controller'] as TextEditingController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    IconData icon,
    RxString observable,
    TextEditingController ctrl,
  ) {
    return Obx(() {
      final isEnabled = controller.isEnabled.value;
      final value = observable.value;

      if (isEnabled) {
        if (ctrl.text != value) ctrl.text = value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildTextField(ctrl, label, isEnabled),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Icon(icon, size: 18, color: Colors.blueGrey.shade400),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '$label:',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value.isEmpty ? 'N/A' : value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String label,
    bool isEnabled,
  ) {
    return TextField(
      controller: ctrl,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      style: const TextStyle(fontSize: 15),
    );
  }

  Widget _buildButtons(EmployeeProfileController controller) {
    final isMobile = Get.width < 900;
    return Padding(
      padding: EdgeInsets.only(right: isMobile ? 0 : 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),

                backgroundColor:
                    controller.isEnabled.value ? Colors.red : Colors.blueGrey,
              ),
              onPressed: controller.toggleEnable,
              child: Text(
                controller.isEnabled.value ? 'Cancel Edit' : 'Enable Editing',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: Colors.white,
                minimumSize:
                    isMobile ? const Size(120, 40) : const Size(150, 48),
              ),
              onPressed:
                  controller.isEnabled.value
                      ? controller.handleSaveButtonPress
                      : null,
              child: const Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(color: Colors.red),
            ),
            onPressed: () {
              Get.offAllNamed('/dashboard');
              controller.clearDataFields();
            },
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getBasicInformationFields() => [
    {
      'label': 'USERID',
      'icon': Icons.card_membership,
      'observable': controller.useridText,
      'controller': controller.userIdController,
    },
    {
      'label': 'Full Name',
      'icon': Icons.person,
      'observable': controller.nameText,
      'controller': controller.nameController,
    },
    {
      'label': 'Employee ID',
      'icon': Icons.badge,
      'observable': controller.idCardText,
      'controller': controller.idCardController,
    },
    {
      'label': 'Position',
      'icon': Icons.work,
      'observable': controller.positionText,
      'controller': controller.positionController,
    },
    {
      'label': 'Department',
      'icon': Icons.apartment,
      'observable': controller.departmentText,
      'controller': controller.departmentController,
    },
    {
      'label': 'Role',
      'icon': Icons.star,
      'observable': controller.roleText,
      'controller': controller.RoleUserTextController,
    },
  ];

  List<Map<String, dynamic>> _getContactInformationFields() => [
    {
      'label': 'Email',
      'icon': Icons.email,
      'observable': controller.emailText,
      'controller': controller.emailController,
    },
    {
      'label': 'Phone',
      'icon': Icons.phone,
      'observable': controller.phoneText,
      'controller': controller.phoneController,
    },
    {
      'label': 'Address',
      'icon': Icons.location_on,
      'observable': controller.addressText,
      'controller': controller.addressController,
    },
  ];

  List<Map<String, dynamic>> _getWorkInformationFields() => [
    {
      'label': 'Join Date',
      'icon': Icons.date_range,
      'observable': controller.joinDateText,
      'controller': controller.joinDateController,
    },
  ];
}
