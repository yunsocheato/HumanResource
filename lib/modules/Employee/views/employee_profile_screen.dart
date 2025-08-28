import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Report/controller/employee_report_controller3.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../../Searchbar/view/search_bar_screen.dart';
import '../Controller/employee_profile_controller.dart';

class EmployeeProfileScreen extends GetView<EmployeeReportController3> {
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
                    SizedBox(height: 10),
                    if (isMobile) _buildHeader(),
                    SizedBox(height: 10),
                    if (!isMobile)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildHeader(),
                      ),
                    SizedBox(height: 15),
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
        final isMobile = constraints.maxWidth < 600;
        if (isMobile) {
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
          if (isMobile) SearchbarScreen(),
          SizedBox(height: 10),
          _buildUserInfoFields(),
        ],
      ),
    );
  }

  Widget _buildDesktopTabletContent() {
    return _buildUserInfoFields();
  }
  Widget _buildUserInfoFields() {
    final controller = Get.find<EmployeeProfileController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: Colors.blue.shade900));
      }

      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          height: Get.height * 1.0,
          child: Card(
            color: Colors.white,
            elevation: 10,
            shadowColor: Colors.grey.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Obx(()

                          => CircleAvatar(
                            radius: 70,
                            backgroundImage: controller.profileImageUrl.value != null
                                ? (controller.profileImageUrl.value!.startsWith('https')
                                ? NetworkImage(controller.profileImageUrl.value!)
                                : FileImage(File(controller.profileImageUrl.value!)) as ImageProvider)
                                : const AssetImage('assets/images/profileuser.png'),
                          )),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () => controller.pickerImageProfile(),
                              icon: const Icon(Boxicons.bx_camera, color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),

                         Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              spacing: 30,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => SizedBox(
                                      width: 230,
                                      child: TextFormField(
                                        controller: controller.RoleUserTextController,
                                        decoration: InputDecoration(
                                          labelText: 'Role',
                                          hintText: controller.roleText.value,
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.blue),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        enabled: controller.isEnabled.value,
                                      ),
                                    )
                                    ),
                                    const SizedBox(height: 10),
                                    Obx(() => SizedBox(
                                      width: 230,
                                      child: TextFormField(
                                        controller: controller.departmentController,
                                        decoration: InputDecoration(
                                          labelText: 'Department',
                                          hintText: controller.departmentText.value,
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.blue),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        enabled: controller.isEnabled.value,
                                      ),
                                    )
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => SizedBox(
                                      width: 230,
                                      child: TextFormField(
                                        controller: controller.RoleUserTextController,
                                        decoration: InputDecoration(
                                          labelText: 'Role',
                                          hintText: controller.roleText.value,
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.blue),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        enabled: controller.isEnabled.value,
                                      ),
                                    )
                                    ),
                                    const SizedBox(height: 10),
                                    Obx(() => SizedBox(
                                      width: 230,
                                      child: TextFormField(
                                        controller: controller.departmentController,
                                        decoration: InputDecoration(
                                          labelText: 'Department',
                                          hintText: controller.departmentText.value,
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.blue),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        enabled: controller.isEnabled.value,
                                      ),
                                    )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  width: Get.width * 9,
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: const Text('Employee Information',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 24)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Obx(() => SizedBox(
                                    width: 280,
                                    child: TextFormField(
                                      controller: controller.nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        hintText: controller.nameText.value,
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      enabled: controller.isEnabled.value,
                                    ),
                                  )
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Obx(() => SizedBox(
                                    width: 280,
                                    child: TextFormField(
                                      controller: controller.emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: controller.emailText.value,
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      enabled: controller.isEnabled.value,
                                    ),
                                  )
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Obx(() =>SizedBox(
                                    width: 280,
                                    child: TextFormField(
                                      controller: controller.phoneController,
                                      decoration: InputDecoration(
                                        labelText: 'Phonenumber',
                                        hintText: controller.phoneText.value,
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      enabled: controller.isEnabled.value,
                                    ),
                                  )
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Obx(() => SizedBox(
                                    width: 280,
                                    child: TextFormField(
                                      controller: controller.positionController,
                                      decoration: InputDecoration(
                                        labelText: 'Position',
                                        hintText: controller.positionText.value,
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      enabled: controller.isEnabled.value,
                                    ),
                                  )
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: Get.width * 7,
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text('Employee History',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 24)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(() => SizedBox(
                                  width: 280,
                                  child: TextFormField(
                                    controller: controller.nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: controller.nameText.value,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    enabled: controller.isEnabled.value,
                                  ),
                                )
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Obx(() => SizedBox(
                                  width: 280,
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      hintText: controller.emailText.value,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    enabled: controller.isEnabled.value,
                                  ),
                                )
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(() =>SizedBox(
                                  width: 280,
                                  child: TextFormField(
                                    controller: controller.phoneController,
                                    decoration: InputDecoration(
                                      labelText: 'Phonenumber',
                                      hintText: controller.phoneText.value,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    enabled: controller.isEnabled.value,
                                  ),
                                )
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Obx(() => SizedBox(
                                  width: 280,
                                  child: TextFormField(
                                    controller: controller.positionController,
                                    decoration: InputDecoration(
                                      labelText: 'Position',
                                      hintText: controller.positionText.value,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    enabled: controller.isEnabled.value,
                                  ),
                                )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(() => SizedBox(
                                  width: 280,
                                  child: TextFormField(
                                    controller: controller.nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: controller.nameText.value,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    enabled: controller.isEnabled.value,
                                  ),
                                )
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Obx(() => SizedBox(
                                  width: 280,
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      hintText: controller.emailText.value,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    enabled: controller.isEnabled.value,
                                  ),
                                )
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(() => SizedBox(
                                  width: 280,
                                  child: TextFormField(
                                    controller: controller.nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: controller.nameText.value,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    enabled: controller.isEnabled.value,
                                  ),
                                )
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Obx(() => SizedBox(
                                  width: 280,
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      hintText: controller.emailText.value,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    enabled: controller.isEnabled.value,
                                  ),
                                )
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                          onPressed: controller.toggleEnable,
                          child: const Text('Enable Editing', style: TextStyle(color: Colors.white))),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
                          onPressed: controller.updateUserInfo,
                          child: const Text('Save Changes', style: TextStyle(color: Colors.white))),
                      const SizedBox(width: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey),
                          onPressed: () => Get.back(),
                          child: const Text('Cancel', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }


}
