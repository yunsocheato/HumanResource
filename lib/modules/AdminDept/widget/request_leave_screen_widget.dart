import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enefty_icons/enefty_icons.dart';

import '../../Admin/Employee/widgets/employee_profile_circleavatar.dart';
import '../controller/request_leave_controller.dart';

class RequestLeaveWidget extends GetView<RequestLeaveScreenController> {
  const RequestLeaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 900;
    final padding = EdgeInsets.all(isMobile ? 16.0 : 32.0);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child:
            isMobile
                ? Column(
                  children: [
                    _buildProfileSidebar(isMobile: true),
                    const SizedBox(height: 20),
                    _buildFormCard(isMobile: true, padding: padding),
                  ],
                )
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildProfileSidebar(isMobile: false),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: _buildFormCard(isMobile: false, padding: padding),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildFormCard({required bool isMobile, required EdgeInsets padding}) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    Text(
                      'Request Leave',
                      style: TextStyle(
                        fontSize: 24,
                        foreground:
                            Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.red[700]!,
                      ),
                    ),
                    const Text(
                      'Request Leave',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildFormFields(),
            ],
          ),
        ),
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
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Obx(
              () => buildProfileAvatar(controller.profileImageUrl.value),
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
            label: 'Department',
            valueListenable: controller.departmentController,
            labelColor: Colors.blue.shade900,
          ),

          const SizedBox(height: 16),

          _buildProfileField(
            label: 'Role',
            valueListenable: controller.roleController,
            labelColor: Colors.blue.shade900,

          ),
          const Divider(height: 32),
          _leaveSummaryBox('Total Annual Leave', Colors.red, '0'),
          const Divider(height: 32),
          _leaveSummaryBox('Total Sick Leave', Colors.orange, '0'),
          const Divider(height: 32),
          _leaveSummaryBox('Total Unpaid Leave', Colors.green, '0'),
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
          style: TextStyle(
            color: labelColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (context, TextEditingValue value, child) {
            return Text(
              value.text,
              style: const TextStyle(fontSize: 15, color: Colors.black54,fontWeight: FontWeight.bold),
            );
          },
        ),
      ],
    );
  }
  Widget _leaveSummaryBox(String title, Color color, String count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerBoxText(width: 150, height: 30, color: color, title: title),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            count,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTwoFieldsRow(
          'Request Number',
          controller.requestNumberController,
          'Request Date',
          controller.requestDateController,
          Colors.red,
          Colors.green,
          isDate2: true,
        ),
        const SizedBox(height: 15),
        _headerBoxText(
          width: 120,
          height: 30,
          color: Colors.purple,
          title: 'Location',
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller.locationController,
          decoration: const InputDecoration(
            labelText: 'Location',
            prefixIcon: Icon(Icons.location_on, color: Colors.purple),
            border: OutlineInputBorder(),
          ),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 15),
        _headerBoxText(
          width: 120,
          height: 30,
          color: Colors.blue,
          title: 'Request Type',
        ),
        const SizedBox(height: 5),
        Obx(
          () => DropdownButtonFormField<String>(
            value:
                controller.selectedRequestType.value.isNotEmpty
                    ? controller.selectedRequestType.value
                    : null,
            hint: const Text('Select...'),
            decoration: _getInputDecoration(),
            items:
                ['Sick Leave', 'Unpaid Leave', 'Annual Leave','MaternityLeave']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: (val) {
              if (val != null) controller.selectedRequestType.value = val;
            },
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          ),
        ),
        const SizedBox(height: 10),
        _buildDateFieldRow(),
        const SizedBox(height: 10),
        _headerBoxText(
          width: 120,
          height: 30,
          color: Colors.orange,
          title: 'Leave Count',
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller.leaveCountController,
          decoration: const InputDecoration(
            labelText: 'Leave Count',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 10),
        _headerBoxText(
          width: 120,
          height: 30,
          color: Colors.pink,
          title: 'Reason',
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller.reasonController,
          decoration: const InputDecoration(
            labelText: 'Reason',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 25),
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
              _headerBoxText(
                width: 150,
                height: 30,
                color: color1,
                title: label1,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: controller1,
                decoration: InputDecoration(
                  labelText: label1,
                  prefixIcon: Icon(Icons.text_fields, color: color1),
                  border: const OutlineInputBorder(),
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
              _headerBoxText(
                width: 150,
                height: 30,
                color: color2,
                title: label2,
              ),
              const SizedBox(height: 5),
              isDate2
                  ? _buildDateField(controller: controller2, label: label2)
                  : TextFormField(
                    controller: controller2,
                    decoration: InputDecoration(
                      labelText: label2,
                      prefixIcon: Icon(Icons.text_fields, color: color2),
                      border: const OutlineInputBorder(),
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

  Widget _buildDateFieldRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerBoxText(
                width: 120,
                height: 30,
                color: Colors.green,
                title: 'From Date',
              ),
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
              _headerBoxText(
                width: 120,
                height: 30,
                color: Colors.red,
                title: 'To Date',
              ),
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
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      suffixIcon: suffixIcon,
    );
  }

  Widget _headerBoxText({
    required double width,
    required double height,
    required Color color,
    required String title,
  }) {
    final isMobile = Get.width < 900;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildButtons() {
    final isMobile = Get.width < 600;

    final buttons = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(() => ElevatedButton(
          onPressed: controller.isLoading.value
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
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        )),
        const SizedBox(width: 10),
        Obx(() => ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : () async {
            await controller.selectReviewer();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          child: Text(
            controller.selectedReviewer.value != null
                ? 'Reviewer: ${controller.selectedReviewer.value!['name']}'
                : 'Select Reviewer',
            style: const TextStyle(color: Colors.white),
          ),
        )),
        const SizedBox(width: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(backgroundColor: Colors.red.shade900),
          onPressed: () => Get.back(),
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ],
    );

    if (!isMobile) return buttons;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: buttons,
    );
  }
}
