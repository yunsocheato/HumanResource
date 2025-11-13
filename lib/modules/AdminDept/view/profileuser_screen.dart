import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import '../../../Core/user_profile_controller.dart';
import '../../Admin/Drawer/views/drawer_screen.dart';
import '../../Admin/Employee/Controller/employee_profile_controller.dart';
import '../widget/bottom_appbar_widget1.dart';
import '../widget/drawer_widget.dart';

class UserProfileScreen extends GetView<EmployeeProfileController> {
  UserProfileScreen({super.key});
  static const String routeName = '/userprofile';

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<UserProfileController>();

    return Obx(() {
      final profile = profileController.userprofiles.value;

      if (profile == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final role = profile.role.toLowerCase();
      final isMobile = Get.width < 900;

      final contents =
          (role == 'admin' || role == 'superadmin')
              ? Drawerscreen(
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 10,
                        ),
                        child: _buildResponsiveContent(),
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
                        child: _buildResponsiveContent(),
                      ),
                    ],
                  ),
                ),
              );

      return isMobile ? BottomAppBarWidget1(body: contents) : contents;
    });
  }

  Widget _buildResponsiveContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return _buildMobileContent();
        } else {
          return _buildDesktopTabletContent();
        }
      },
    );
  }

  Widget _buildMobileContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileSidebar(),
          const SizedBox(height: 16),
          _buildInformationCard(
            color1: Colors.blue,
            color: Colors.blue.shade100,
            title: 'Basic Information',
            fields: _getBasicInformationFields(),
          ),
          const SizedBox(height: 16),
          _buildInformationCard(
            color1: Colors.green,
            color: Colors.green.shade100,
            title: 'Contact Information',
            fields: _getContactInformationFields(),
          ),
          const SizedBox(height: 16),
          _buildInformationCard(
            color1: Colors.orange,
            color: Colors.orange.shade100,
            title: 'Work Information',
            fields: _getWorkInformationFields(),
          ),
          const SizedBox(height: 30),
          _buildButtons(controller),
        ],
      ),
    );
  }

  Widget _buildDesktopTabletContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileSidebar(),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInformationCard(
                color1: Colors.blue,
                color: Colors.blue.shade900,
                title: 'Basic Information',
                fields: _getBasicInformationFields(),
              ),
              const SizedBox(height: 24),
              _buildInformationCard(
                color1: Colors.green,
                color: Colors.green.shade900,
                title: 'Contact Information',
                fields: _getContactInformationFields(),
              ),
              const SizedBox(height: 24),
              _buildInformationCard(
                color1: Colors.orange,
                color: Colors.orange.shade900,
                title: 'Work Information',
                fields: _getWorkInformationFields(),
              ),
              const SizedBox(height: 30),

              _buildButtons(controller),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSidebar() {
    final isMobile = Get.width < 900;
    return Container(
      width: isMobile ? Get.width : 300,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Obx(() {
                  final bool isAdminEditing = controller.adminEditing.value;

                  final String imageUrl =
                      isAdminEditing
                          ? controller.otherUserProfileImageUrl.value
                          : controller.profileImageUrl.value;

                  return CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                        imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : const AssetImage('assets/images/profileuser.png')
                                as ImageProvider,
                  );
                }),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Boxicons.bx_camera, color: Colors.blue),
                    iconSize: 22,
                    onPressed: controller.pickerImageProfile,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Center(
              child: Text(
                controller.nameText.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Obx(
            () => Center(
              child: Text(
                controller.positionText.value,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
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
      elevation: 15,
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
            ...fields.map((field) {
              return _buildInfoRow(
                field['label'] as String,
                field['icon'] as IconData,
                field['observable'] as RxString,
                field['controller'] as TextEditingController,
              );
            }).toList(),
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
        if (ctrl.text != value) {
          ctrl.text = value;
        }
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

  List<Map<String, dynamic>> _getBasicInformationFields() {
    return [
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
  }

  List<Map<String, dynamic>> _getContactInformationFields() {
    return [
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
  }

  List<Map<String, dynamic>> _getWorkInformationFields() {
    return [
      {
        'label': 'Join Date',
        'icon': Icons.date_range,
        'observable': controller.joinDateText,
        'controller': controller.joinDateController,
      },
      // {
      //   'label': 'Parking No.',
      //   'icon': Icons.car_rental,
      //   'observable': ''.obs,
      //   'controller': controller.departmentController,
      // },
    ];
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    controller.isEnabled.value ? Colors.red : Colors.blueGrey,
              ),
              onPressed: () {
                controller.toggleEnable();
              },
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
              side: const BorderSide(color: Colors.red),
            ),
            onPressed: () => Get.back(),
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
