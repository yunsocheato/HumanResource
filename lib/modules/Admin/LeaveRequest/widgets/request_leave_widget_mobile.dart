import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hrms/Core/user_profile_controller.dart';
import 'package:hrms/modules/Admin/Drawer/views/drawer_screen.dart';
import 'package:hrms/modules/Admin/Employee/widgets/employee_profile_circleavatar.dart';
import 'package:hrms/modules/Admin/LeaveRequest/controllers/apply_leave_screen_controller.dart';
import 'package:hrms/modules/AdminDept/widget/bottom_appbar_widget1.dart';
import 'package:hrms/modules/AdminDept/widget/drawer_widget.dart';
import 'package:hrms/modules/AdminDept/widget/leave_card_balance_sidebar.dart';

class RequestLeaveWidgetMobile extends GetView<ApplyLeaveScreenController> {
  const RequestLeaveWidgetMobile({super.key});
  static const String routeName = '/request-leave-mobile';

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<UserProfileController>().userprofiles.value;
    final role = profile?.role ?? '';
    final isMobile = Get.width < 600;
    if (!isMobile) {
      Future.microtask(() {
        Get.offAllNamed('/dashboard');
      });
    }
    final contents =
        (role == 'admin' || role == 'superadmin')
            ? Drawerscreen(
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 10,
                      ),
                      child: _buildMobileLayout(context),
                    ),
                  ],
                ),
              ),
            )
            : DrawerAdmin(
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 10,
                      ),
                      child: _buildMobileLayout(context),
                    ),
                  ],
                ),
              ),
            );
    return isMobile ? BottomAppBarWidget1(body: contents) : contents;
  }

  Widget _buildMobileLayout(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double searchHeight = 60;

    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade600],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned.fill(
              top: searchHeight + 40,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: kBottomNavigationBarHeight + 40,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 15),
                        _buildUsernameAutoSuggestField(controller),
                        const SizedBox(height: 15),
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
                              Divider(height: 32, color: Colors.grey.shade400),
                              const SizedBox(height: 10),
                              GridoverviewLeavebalance(),
                              Divider(height: 32, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              _buildFormCard(
                                isMobile: true,
                                padding: const EdgeInsets.all(16),
                              ),
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
                  controller.suggestionList.clear();
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
            'CREATE USER LEAVE',
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

  Widget _buildUsernameAutoSuggestField(ApplyLeaveScreenController controller) {
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
                controller.fetchbyusersLeave(value);
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
                  controller.fetchbyusersLeave(controller.Username.value);
                  controller.suggestionList.clear();
                  controller.usernameSearchController.clear();
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) {
              if (controller.isSelectingSuggestion.value) return;

              controller.Username.value = v;

              if (v.isNotEmpty) {
                controller.fetchSuggestionsLeave(v);
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
                    onTap: () async {
                      controller.isSelectingSuggestion.value = true;

                      controller.suggestionList.clear();

                      controller.usernameSearchController.text = s;
                      controller.Username.value = s;

                      await controller.fetchbyusersLeave(s);

                      controller.isSelectingSuggestion.value = false;
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }

  Widget _buildFormCard({required bool isMobile, required EdgeInsets padding}) {
    return Padding(
      padding: padding,
      child: Form(
        key: controller.formKey,
        child: Column(children: [_buildFormFields()]),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'APPLY USER LEAVE',
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: '7TH.ttf',
            ),
          ),
        ),
        const SizedBox(height: 15),
        _buildTwoFieldsRow(
          'Request Number',
          controller.requestNumberController,
          'Request Date',
          controller.requestDateController,
          Colors.red,
          Colors.green,
          isDate2: true,
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller.locationController,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: 'Location',
            prefixIcon: Icon(Icons.location_on, color: Colors.purple),
            border: OutlineInputBorder(),
          ),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 5),
        Obx(
          () => DropdownButtonFormField<String>(
            initialValue:
                controller.selectedRequestType.value.isEmpty
                    ? null
                    : controller.selectedRequestType.value,
            decoration: _getInputDecoration(),
            items: const [
              DropdownMenuItem(value: 'Sick Leave', child: Text('Sick Leave')),
              DropdownMenuItem(
                value: 'Unpaid Leave',
                child: Text('Unpaid Leave'),
              ),
              DropdownMenuItem(
                value: 'Annual Leave',
                child: Text('Annual Leave'),
              ),
              DropdownMenuItem(
                value: 'Maternity Leave',
                child: Text('Maternity Leave'),
              ),
            ],
            onChanged: (val) {
              if (val != null) controller.selectedRequestType.value = val;
            },
            validator: (val) => val == null ? 'Required' : null,
          ),
        ),

        Divider(height: 32, color: Colors.grey.shade400),
        const SizedBox(height: 10),
        _buildDateRow(),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller.leaveCountController,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Leave Count',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller.reasonController,
          decoration: const InputDecoration(
            labelText: 'Reason',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        Divider(height: 32, color: Colors.grey.shade400),
        const SizedBox(height: 15),
        Align(alignment: Alignment.bottomRight, child: _buildButtons()),
      ],
    );
  }

  Widget _buildTwoFieldsRow(
    String label1,
    TextEditingController controller1,
    String label2,
    TextEditingController controller2,
    Color color1,
    Color color2, {
    bool isDate2 = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller1,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: label1,
                  prefixIcon: Icon(Icons.text_fields, color: color2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator:
                    (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isDate2
                  ? _buildDateField(controller: controller2, label: label2)
                  : TextFormField(
                    controller: controller2,
                    decoration: InputDecoration(
                      labelText: label2,
                      prefixIcon: Icon(Icons.text_fields, color: color2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator:
                        (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              _buildDateField(
                controller: controller.startDateController,
                label: 'Start Date',
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              _buildDateField(
                controller: controller.endDateController,
                label: 'End Date',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
          context: Get.context!,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );
        if (date != null) {
          controller.text = date.toIso8601String().split('T').first;
        }
      },
      decoration: _getInputDecoration(
        suffixIcon: const Icon(
          EneftyIcons.calendar_2_bold,
          color: Colors.blue,
          size: 20,
        ),
      ).copyWith(hintText: label),
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: _getInputDecoration(
        suffixIcon: icon != null ? Icon(icon) : null,
      ).copyWith(hintText: label),
    );
  }

  Widget _buildDropdown() {
    return Obx(
      () => DropdownButtonFormField<String>(
        initialValue:
            controller.selectedRequestType.value.isNotEmpty
                ? controller.selectedRequestType.value
                : null,
        hint: const Text('Select Request Type'),
        decoration: _getInputDecoration(),
        items: const [
          DropdownMenuItem(value: 'Sick Leave', child: Text('Sick Leave')),
          DropdownMenuItem(value: 'Unpaid Leave', child: Text('Unpaid Leave')),
          DropdownMenuItem(value: 'Annual Leave', child: Text('Annual Leave')),
          DropdownMenuItem(
            value: 'Annual Leave',
            child: Text('Maternity Leave'),
          ),
        ],
        onChanged: (val) {
          if (val != null) controller.selectedRequestType.value = val;
        },
      ),
    );
  }

  InputDecoration _getInputDecoration({Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      suffixIcon: suffixIcon,
    );
  }

  Widget _buildButtons() {
    final isMobile = Get.width < 600;

    final bool hasSubmitter = controller.selectedSubmit.value != null;

    final buttons =
        isMobile
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                  () => ElevatedButton(
                    onPressed:
                        (controller.isLoading.value || !hasSubmitter)
                            ? null
                            : () async {
                              await controller.submitLeave();
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673AB7),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child:
                        controller.isLoading.value
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 10),

                Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () async {
                              await controller.selectedSubmits();
                            },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.blue.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),

                    child: Text(
                      controller.selectedSubmit.value != null
                          ? 'Submit to: ${controller.selectedSubmit.value!['name']}'
                          : 'Select Submitter',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.red.shade900,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => ElevatedButton(
                    onPressed:
                        (controller.isLoading.value || !hasSubmitter)
                            ? null
                            : () async {
                              await controller.submitLeave();
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child:
                        controller.isLoading.value
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                  ),
                ),
                const SizedBox(width: 10),

                Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () async {
                              await controller.selectedSubmits();
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      controller.selectedSubmit.value != null
                          ? 'Submit : ${controller.selectedSubmit.value!['name']}'
                          : 'Select Approver',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.red.shade900,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                  ),

                  onPressed: () {
                    Get.offAllNamed('/overview');
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
    return buttons;
  }
}
