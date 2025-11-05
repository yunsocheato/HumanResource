import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Employee/widgets/employee_profile_circleavatar.dart';
import '../controllers/apply_leave_screen_controller.dart';

class RequestLeaveFormWidget extends GetView<ApplyLeaveScreenController> {
  const RequestLeaveFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 900;
    final padding = EdgeInsets.all(isMobile ? 16.0 : 32.0);

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (isMobile) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileSidebar(),
                  const SizedBox(height: 20),
                  Container(
                    width: Get.width * 0.9,
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: padding,
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
                                      fontSize: 18,
                                      foreground:
                                          Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 2
                                            ..color = Colors.red[700]!,
                                    ),
                                  ),
                                  const Text(
                                    'Request Leave',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
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
                  ),
                ],
              ),
            );
          }
          else {
            return Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSidebar(),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                        minWidth: 400,
                      ),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: padding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Stack(
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
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              _buildFormFields(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Obx(() => buildProfileAvatar(controller.profileImageUrl.value)),
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
          Obx(
            () => Text(
              controller.emailText.value,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Text(
              controller.departmentText.value,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Text(
              controller.roleText.value,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          const Divider(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _headerBoxText(
                width: 150,
                height: 30,
                color: Colors.red,
                title: 'Total Annual Leave',
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerBoxText(
                width: 150,
                height: 30,
                color: Colors.orange,
                title: 'Total Sick Leave',
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _headerBoxText(
                width: 150,
                height: 30,
                color: Colors.green,
                title: 'Total Unpaid Leave',
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _headerBoxText(
                      width: 150,
                      height: 30,
                      color: Colors.red,
                      title: 'Request Number',
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: controller.requestNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Request Number',
                      prefixIcon: Icon(Icons.password, color: Colors.red),
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (val) => val == null || val.isEmpty ? "Required" : null,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: _headerBoxText(
                      width: 150,
                      height: 30,
                      color: Colors.green,
                      title: 'Request Date',
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
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
                      prefixIcon: Icon(Icons.date_range, color: Colors.green),
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (val) => val == null || val.isEmpty ? "Required" : null,
                  ),
                ],
              ),
            ),
          ],
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
                ["Sick Leave", "Unpaid Leave", "Annual Leave"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: (val) {
              if (val != null) {
                controller.selectedRequestType.value = val;
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        _headerBoxText(
          width: 120,
          height: 30,
          color: Colors.green,
          title: 'From Date',
        ),
        const SizedBox(height: 5),
        _buildDateField(
          controller: controller.startDateController,
          label: 'Enter a date',
        ),
        const SizedBox(height: 10),
        _headerBoxText(
          width: 120,
          height: 30,
          color: Colors.red,
          title: 'To Date',
        ),
        const SizedBox(height: 5),
        _buildDateField(
          controller: controller.endDateController,
          label: 'Enter a date',
        ),
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
        ),
        const SizedBox(height: 25),
        Align(
          alignment: Alignment.bottomRight,
          child: _buildButtons(controller),
        ),
      ],
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
          controller.text = date.toIso8601String().split("T").first;
        }
      },
      decoration: _getInputDecoration(
        suffixIcon: const Icon(
          EneftyIcons.calendar_2_bold,
          color: Colors.blue,
          size: 20,
        ),
      ).copyWith(hintText: label),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String text,
    String label,
    bool isEnabled,
    IconData icon,
    Color color,
  ) {
    if (ctrl.text != text) {
      ctrl.text = text;
    }
    return TextField(
      controller: ctrl,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: color),
        border: const OutlineInputBorder(),
      ),
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

  Widget _buildButtons(ApplyLeaveScreenController controller) {
    final isMobile = Get.width < 600;
    final buttons = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF673AB7),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 5,
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
          onPressed: controller.toggleEnable,
          child: const Text(
            'Enable Editing',
            style: TextStyle(color: Colors.white),
          ),
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
