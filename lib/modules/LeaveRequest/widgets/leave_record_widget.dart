import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:hrms/modules/LeaveRequest/controllers/apply_leave_screen_controller.dart';
import '../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../../Employee/widgets/employee_profile_circleavatar.dart';

class LeaveRecord extends GetView<ApplyLeaveScreenController> {
  const LeaveRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildEmployeeResponsive();
  }

  Widget _buildEmployeeResponsive() {
    final isMobile = Get.width < 600;
    return isMobile
        ? _buildUserInfoFieldsMobile()
        : _buildUserInfoFieldsDesktop();
  }

  Widget _buildUserInfoFieldsMobile() {
    final controller = Get.find<ApplyLeaveScreenController>();
    final HoverMouseController controller1 = Get.put(HoverMouseController());

    return MouseHover(
      keyId: 11,
      controller: controller1,
      child: Card(
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(() => buildProfileAvatar(controller.profileImageUrl.value)),
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
              // buildApplyLeave(),
              _buildButtons(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoFieldsDesktop() {
    final controller = Get.find<ApplyLeaveScreenController>();

    return Scrollbar(
      controller: controller.verticalScrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: controller.verticalScrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Scrollbar(
              controller: controller.horizontalScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: controller.horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.9,
                      height: 250,
                      child: Card(
                        elevation: 15,
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
                                          'Information',
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
                                              controller.emailController,
                                              controller.emailText.value,
                                              'Email',
                                              controller.isEnabled.value,
                                            ),
                                          )),
                                      const SizedBox(height: 10),
                                      Obx(() =>
                                          SizedBox(
                                            width: 270,
                                            child: _buildTextField(
                                              controller.departmentController,
                                              controller.departmentText.value,
                                              'Department',
                                              controller.isEnabled.value,
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() =>
                                          SizedBox(
                                            width: 270,
                                            child: _buildTextField(
                                              controller.phoneController,
                                              controller.phoneText.value,
                                              'Phonenumber',
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
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
                      child: buildApplyLeave(),
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

  Widget buildApplyLeave() {
    final controller = Get.find<ApplyLeaveScreenController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 220,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              'Apply Leave',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),),

        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.requestNumberController,
                decoration: const InputDecoration(
                  labelText: 'Request Number',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                val == null || val.isEmpty ? "Required" : null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller.requestDateController,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    controller.requestDateController.text =
                        date.toIso8601String().split("T").first;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Request Date',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                val == null || val.isEmpty ? "Required" : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: controller.locationController,
          decoration: const InputDecoration(
            labelText: 'Location',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        DropdownButtonFormField<String>(
          value: controller.selectedRequestType.value,
          decoration: const InputDecoration(
            labelText: 'Request Type',
            border: OutlineInputBorder(),
          ),
          items: ["Sick Leave", "Casual Leave", "Annual Leave"]
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) {
            controller.selectedRequestType.value = val;
          },
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: controller.reasonController,
          decoration: const InputDecoration(
            labelText: 'Reason (optional)',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.startDateController,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    controller.startDateController.text =
                        date.toIso8601String().split("T").first;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller.endDateController,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    controller.endDateController.text =
                        date.toIso8601String().split("T").first;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: controller.leaveCountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Leave Count',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String text, String label,
      bool isEnabled) {
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

  Widget _buildButtons(ApplyLeaveScreenController controller) {
    final isMobile = Get.width < 600;
    final buttons = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
          onPressed: (){},
          // onPressed: controller.applyLeave,
          child: const Text('Apply Leave',
              style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
          onPressed: controller.toggleEnable,
          child: const Text('Enable Editing',
              style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(backgroundColor: Colors.red.shade900),
          onPressed: () => Get.back(),
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
    if (!isMobile) {
      return buttons;
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: buttons,
      );
    }
  }

}
