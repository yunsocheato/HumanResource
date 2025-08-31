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
    final loading = Get.find<LoadingUiController>();
    final isMobile = Get.width < 600;

    return Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Scrollbar(
              controller: controller.verticalScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: controller.verticalScrollController,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    if (isMobile)
                      _buildHeader(),
                    if (!isMobile)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildHeader(),
                      ),
                    const SizedBox(height: 15),
                    _buildResponsiveContent(),
                  ],
                ),
              ),
            ),
            if (loading.isLoading.value) const LoadingScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final context = Get.context;
    final isMobile = MediaQuery.of(context!).size.width < 600;
    return Obx(
          () =>
          AnimatedOpacity(
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
                            const SizedBox(width: 10),
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
                                  child: Icon(
                                    Icons.folder_copy,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'PROFILE EMPLOYEE',
                                      style: TextStyle(
                                        fontSize: 16,
                                        foreground:
                                        Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.green[700]!,
                                      ),
                                    ),
                                    Text(
                                      'PROFILE EMPLOYEE',
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
                                      'PROFILE EMPLOYEE',
                                      style: TextStyle(
                                        fontSize: 24,
                                        foreground:
                                        Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.green[700]!,
                                      ),
                                    ),
                                    Text(
                                      'PROFILE EMPLOYEE',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.folder_copy,
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
                            isMobile
                                ? IconButton(
                              onPressed: () => controller.refreshData(),
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.green,
                                size: 16,
                              ),
                            )
                                : IconButton(
                              onPressed: () => controller.refreshData(),
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.green,
                                size: 24,
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
        if (constraints.maxWidth < 600) {
          return _buildMobileContent();
        } else {
          return _buildDesktopTabletContent();
        }
      },
    );
  }

  Widget _buildMobileContent() {
    final isMobile = Get.width < 600;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
          SizedBox(height: 10),
          _buildUserInfoFieldsMobile(),
        ],
      ),
    );
  }
  Widget _buildDesktopTabletContent() {
    return _buildUserInfoFieldsDesktop();
  }

  Widget _buildUserInfoFieldsMobile() {
    final controller = Get.find<EmployeeProfileController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Obx(() => buildProfileAvatar(controller.profileImageUrl.value)),
              IconButton(
                onPressed: () => controller.pickerImageProfile(),
                icon: const Icon(Boxicons.bx_camera, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() => _buildTextField(
            controller.nameController,
            controller.nameText.value,
            'Name',
            controller.isEnabled.value,
          )),
          const SizedBox(height: 10),
          Obx(() => _buildTextField(
            controller.emailController,
            controller.emailText.value,
            'Email',
            controller.isEnabled.value,
          )),
          const SizedBox(height: 10),
          Obx(() => _buildTextField(
            controller.phoneController,
            controller.phoneText.value,
            'Phone',
            controller.isEnabled.value,
          )),
          const SizedBox(height: 10),
          Obx(() => _buildTextField(
            controller.positionController,
            controller.positionText.value,
            'Position',
            controller.isEnabled.value,
          )),
          const SizedBox(height: 10),
          Obx(() => _buildTextField(
            controller.departmentController,
            controller.departmentText.value,
            'Department',
            controller.isEnabled.value,
          )),
          const SizedBox(height: 20),
          _buildButtons(controller),
        ],
      ),
    );
  }

  Widget _buildUserInfoFieldsDesktop() {
    final controller = Get.find<EmployeeProfileController>();

    return Scrollbar(
      controller: controller.verticalScrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: controller.verticalScrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.9,
              height: 290,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Scrollbar(
                controller: controller.horizontalScrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: controller.horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        height: 250,
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          color: Colors.white,
                          child: Scrollbar(
                            controller: controller.profileHCtrl,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              controller: controller.profileHCtrl,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 140,
                                        height: 23,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade900,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'PROFILES',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,

                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox( width: 15,height: 16),
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Obx(() => buildProfileAvatar(controller.profileImageUrl.value)
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: IconButton(
                                              onPressed: () =>
                                                  controller.pickerImageProfile(),
                                              icon: const Icon(
                                                  Boxicons.bx_camera, color: Colors.blue),
                                              iconSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 15,width: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Obx(() =>
                                            SizedBox(
                                              width: 270,
                                              child: _buildTextField(
                                                controller.nameController,
                                                controller.nameText.value,
                                                'Name',
                                                controller.isEnabled.value,
                                              ),
                                            )),
                                        const SizedBox(height: 10),
                                        Obx(() =>
                                            SizedBox(
                                              width: 270,
                                              child: _buildTextField(
                                                controller.positionController,
                                                controller.positionText.value,
                                                'Position',
                                                controller.isEnabled.value,
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15,width: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Obx(() =>
                                            SizedBox(
                                              width: 270,
                                              child: _buildTextField(
                                                controller.departmentController,
                                                controller.departmentText.value,
                                                'Department',
                                                controller.isEnabled.value,
                                              ),
                                            )),
                                        const SizedBox(height: 10),
                                        Obx(() =>
                                            SizedBox(
                                              width: 270,
                                              child: _buildTextField(
                                                controller.RoleUserTextController,
                                                controller.roleText.value,
                                                'Role',
                                                controller.isEnabled.value,
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),
                      SizedBox(
                        width: Get.width * 0.4,
                        height: 250,
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 140,
                                    height: 23,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade900,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'PROGRESS',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18,

                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Card(
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Employee Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextFieldRow3(
                            controller.addressController,
                            controller.addressText.value,
                            'Address',
                            controller.emailController,
                            controller.emailText.value,
                            'Email',
                            controller.phoneController,
                            controller.phoneText.value,
                            'Phone',
                            controller.isEnabled.value,
                          ),
                          const SizedBox(height: 12),
                          _buildTextFieldRow3(
                            controller.positionController,
                            controller.positionText.value,
                            'Position',
                            controller.departmentController,
                            controller.departmentText.value,
                            'Department',
                            controller.RoleUserTextController,
                            controller.roleText.value,
                            'Role',
                            controller.isEnabled.value,
                          ),
                          const SizedBox(height: 12),
                          _buildTextFieldRow3(
                            controller.idCardController,
                            controller.idCardText.value,
                            'Staff ID',
                            controller.nameController,
                            controller.nameText.value,
                            'Join Date',
                            controller.positionController,
                            controller.positionText.value,
                            'Salary',
                            controller.isEnabled.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Card(
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red.shade900,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Employee History',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextFieldRow3(
                            controller.addressController,
                            controller.addressText.value,
                            'Address',
                            controller.emailController,
                            controller.emailText.value,
                            'Email',
                            controller.phoneController,
                            controller.phoneText.value,
                            'Phone',
                            controller.isEnabled.value,
                          ),
                          const SizedBox(height: 12),
                          _buildTextFieldRow3(
                            controller.positionController,
                            controller.positionText.value,
                            'Position',
                            controller.departmentController,
                            controller.departmentText.value,
                            'Department',
                            controller.RoleUserTextController,
                            controller.roleText.value,
                            'Role',
                            controller.isEnabled.value,
                          ),
                          const SizedBox(height: 12),
                          _buildTextFieldRow3(
                            controller.idCardController,
                            controller.idCardText.value,
                            'Staff ID',
                            controller.nameController,
                            controller.nameText.value,
                            'Join Date',
                            controller.positionController,
                            controller.positionText.value,
                            'Salary',
                            controller.isEnabled.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildButtons(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController ctrl, String text, String label, bool isEnabled) {
    if (ctrl.text != text) {
      ctrl.text = text;
    }
    return TextField(
      controller: ctrl,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
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
    final isMobile = Get.width < 600;
    final Button = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
          onPressed: (){
            controller.toggleEnable();
          },
          child: const Text('Enable Editing',
              style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style:
          ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
          onPressed: controller.updateUserInfo,
          child:
          const Text('Save Changes', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey),
          onPressed: () => Get.back(),
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
    if(!isMobile){
      return Button;
    }else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Button,
      );
    }
  }

}
