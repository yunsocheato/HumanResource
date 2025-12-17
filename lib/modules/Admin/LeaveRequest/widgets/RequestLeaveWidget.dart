import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/widget/leave_card_balance_sidebar.dart';
import '../../Employee/widgets/employee_profile_circleavatar.dart';
import '../controllers/apply_leave_screen_controller.dart';

class RequestLeaveFormWidget extends GetView<ApplyLeaveScreenController> {
  const RequestLeaveFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.all(32.0);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildFormCard(isMobile: false, padding: padding),
              ),
              const SizedBox(width: 20),
              Expanded(flex: 1, child: _buildProfileSidebar(isMobile: false)),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildProfileSidebar({required bool isMobile}) {
    return Container(
      width: isMobile ? Get.width : null,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Obx(
              () => Column(
                children: [
                  buildProfileAvatar(controller.profileImageUrl.value),
                  const SizedBox(height: 10),
                  Text(
                    controller.nameController.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.positionController.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Email',
            valueListenable: controller.emailController,
            labelColor: Colors.blue.shade900,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'ID-Card',
            valueListenable: controller.idCardController,
            labelColor: Colors.blue.shade900,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Department',
            valueListenable: controller.departmentController,
            labelColor: Colors.blue.shade900,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            label: 'Role',
            valueListenable: controller.RoleUserTextController,
            labelColor: Colors.blue.shade900,
          ),
          const Divider(height: 32),
          SizedBox(height: 350, child: GridoverviewLeavebalance()),
        ],
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required ValueNotifier<TextEditingValue> valueListenable,
    Color labelColor = Colors.black,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: labelColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (context, TextEditingValue value, child) {
            return Text(
              value.text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    final isMobile = Get.width < 900;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) const SizedBox(height: 10),
        if (!isMobile)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'CREATE USER LEAVE',
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: '7TH.ttf',
              ),
            ),
          ),
        if (!isMobile) const SizedBox(height: 20),
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
                controller.selectedRequestType.value.isNotEmpty
                    ? controller.selectedRequestType.value
                    : null,
            hint: const Text('Select...'),
            decoration: _getInputDecoration(),
            items:
                ['Sick Leave', 'Unpaid Leave', 'Annual Leave', 'MaternityLeave']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: (val) {
              if (val != null) controller.selectedRequestType.value = val;
            },
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(() {
          final canSubmit =
              controller.userProfile.value != null &&
              controller.selectedSubmit.value != null;

          return ElevatedButton(
            onPressed:
                controller.isLoading.value || !canSubmit
                    ? null
                    : () async {
                      await controller.submitLeave();
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF673AB7),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                    : const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
          );
        }),
        const SizedBox(width: 5),

        // Reviewer Button
        Obx(() {
          final reviewer = controller.selectedSubmit.value;
          return ElevatedButton(
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
              backgroundColor: Colors.blueAccent.shade700,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
            child: Text(
              reviewer != null
                  ? 'Submit to: ${reviewer['name'] ?? 'Unknown'}'
                  : 'Select Reviewer',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }),
        const SizedBox(width: 5),

        // Cancel Button
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.red.shade900,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          onPressed: () => {controller.clearDataFields(), Get.back()},
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
