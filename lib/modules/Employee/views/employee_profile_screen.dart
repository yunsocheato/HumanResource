import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../Controller/employee_profile_controller.dart';
import '../widgets/employee_profile_circleavatar.dart';

class EmployeeProfileScreen extends GetView<EmployeeProfileController> {
  const EmployeeProfileScreen({super.key});

  static const String routeName = '/employeeprofile';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LoadingUiController>()) {
      Get.put(LoadingUiController());
    }
    final loading = Get.find<LoadingUiController>();

    return Drawerscreen(
      content: Scaffold(
        backgroundColor: const Color(0xFFF7F7F5),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _buildHeader(),
                ),
                Expanded(
                  child: Scrollbar(
                    controller: controller.verticalScrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: controller.verticalScrollController,
                      padding: const EdgeInsets.all(16.0),
                      child: _buildResponsiveContent(),
                    ),
                  ),
                ),
              ],
            ),
            if (loading.isLoading.value) const LoadingScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final ctx = Get.context ?? Get.overlayContext;
    final isMobile =
        ctx != null ? MediaQuery.of(ctx).size.width < 600 : Get.width < 600;
    return Obx(
      () => AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: controller.showlogincard1.value ? 1.0 : 0.0,
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.only(
            top: controller.showlogincard1.value ? 0 : 100,
          ),
          child: SizedBox(
            height: 70,
            child: Card(
              color: Colors.white,
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 5),
                        isMobile
                            ? Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'EMPLOYEE PROFILE',
                                      style: TextStyle(
                                        fontSize: 16,
                                        foreground:
                                            Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = Colors.green[700]!,
                                      ),
                                    ),
                                    const Text(
                                      'EMPLOYEE PROFILE',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : Row(
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'EMPLOYEE PROFILE',
                                      style: TextStyle(
                                        fontSize: 24,
                                        foreground:
                                            Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = Colors.green[700]!,
                                      ),
                                    ),
                                    const Text(
                                      'EMPLOYEE PROFILE',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => controller.refreshData(),
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.green,
                            size: isMobile ? 16 : 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
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
                Obx(() => buildProfileAvatar(controller.profileImageUrl.value)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: IconButton(
                    onPressed: () => controller.pickerImageProfile(),
                    icon: const Icon(Boxicons.bx_camera, color: Colors.blue),
                    iconSize: 20,
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
          _buildSidebarItem('Status', 'Onboarding', Colors.black54, Icons.star),
          _buildSidebarItem(
            'Email',
            controller.emailText.value,
            Colors.blue,
            Icons.email,
          ),
          _buildSidebarItem(
            'Phone Number',
            controller.phoneText.value,
            Colors.black54,
            Icons.phone,
          ),
          _buildSidebarItem(
            'Address',
            controller.addressText.value,
            Colors.blue,
            Icons.location_on,
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    String label,
    String value,
    Color valueColor,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.yellow.shade200, size: 10),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor,
                fontWeight: FontWeight.w500,
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
            ...fields.map((field) {
              return _buildInfoRow(
                field['label'] as String,
                field['text'] as String,
                field['controller'] as TextEditingController,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, TextEditingController ctrl) {
    return Obx(() {
      final isEnabled = controller.isEnabled.value;
      if (isEnabled) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildTextField(ctrl, value, label, isEnabled),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  '$label:',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value,
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
        'label': 'Full Name',
        'text': controller.nameText.value,
        'controller': controller.nameController,
      },
      {
        'label': 'Employee ID',
        'text': controller.idCardText.value,
        'controller': controller.idCardController,
      },
      {
        'label': 'Position',
        'text': controller.positionText.value,
        'controller': controller.positionController,
      },
      {
        'label': 'Department',
        'text': controller.departmentText.value,
        'controller': controller.departmentController,
      },
      {
        'label': 'Role',
        'text': controller.roleText.value,
        'controller': controller.RoleUserTextController,
      },
    ];
  }

  List<Map<String, dynamic>> _getContactInformationFields() {
    return [
      {
        'label': 'Email',
        'text': controller.emailText.value,
        'controller': controller.emailController,
      },
      {
        'label': 'Phone',
        'text': controller.phoneText.value,
        'controller': controller.phoneController,
      },
      {
        'label': 'Address',
        'text': controller.addressText.value,
        'controller': controller.addressController,
      },
    ];
  }

  List<Map<String, dynamic>> _getWorkInformationFields() {
    return [
      {
        'label': 'Join Date',
        'text': controller.joinDateText.value,
        'controller': controller.nameController,
      },
      {
        'label': 'Position',
        'text': controller.phoneText.value,
        'controller': controller.positionController,
      },
      {
        'label': 'Parking No.',
        'text': 'P1-21',
        'controller': controller.departmentController,
      },
    ];
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String text,
    String label,
    bool isEnabled,
  ) {
    if (ctrl.text != text) {
      ctrl.text = text;
    }
    return TextField(
      controller: ctrl,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildTextFieldRow3(
    TextEditingController ctrl1,
    String text1,
    String label1,
    TextEditingController ctrl2,
    String text2,
    String label2,
    TextEditingController ctrl3,
    String text3,
    String label3,
    bool isEnabled,
  ) {
    if (ctrl1.text != text1) ctrl1.text = text1;
    if (ctrl2.text != text2) ctrl2.text = text2;
    if (ctrl3.text != text3) ctrl3.text = text3;

    return Row(
      children: [
        Expanded(child: _buildTextField(ctrl1, text1, label1, isEnabled)),
        const SizedBox(width: 12),
        Expanded(child: _buildTextField(ctrl2, text2, label2, isEnabled)),
        const SizedBox(width: 12),
        Expanded(child: _buildTextField(ctrl3, text3, label3, isEnabled)),
      ],
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
                  controller.isEnabled.value ? controller.updateUserInfo : null,
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
