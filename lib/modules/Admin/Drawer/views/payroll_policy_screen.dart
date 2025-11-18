import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../Utils/SnackBar/snack_bar.dart';
import '../controllers/payroll_policy_controller.dart';

class PayrollPolicyScreen extends GetView<PayrollPolicyController> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  PayrollPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveAttendanceStaff();
  }

  Widget _buildResponsiveAttendanceStaff() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

  Widget _buildPopDialogMobile() {
    final controller = Get.find<PayrollPolicyController>();
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.purple.shade900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'PAYROLL POLICY',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      )
                      : Form(
                        key: _formKey1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                initialValue: controller.Username.value,
                                decoration: InputDecoration(
                                  labelText: 'FIND USERNAME',
                                  suffixIcon: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      controller.icon,
                                      color: controller.color,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                validator:
                                    (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Please enter a username'
                                            : null,
                                onSaved:
                                    (value) =>
                                        controller.Username.value = value ?? '',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                initialValue: controller.SetSalary.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Set Salary',
                                  suffixIcon: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      controller.icon,
                                      color: controller.color,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                validator:
                                    (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Please Set Salary'
                                            : null,
                                onSaved:
                                    (value) =>
                                        controller.SetSalary.value =
                                            double.tryParse(value ?? '') ?? 0,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text(
                                      'User Cannot Change \n Salary without Admin',
                                    ),
                                    value: controller.usercannotchange.value,
                                    onChanged:
                                        (value) =>
                                            controller.usercannotchange.value =
                                                value ?? false,
                                  ),
                                ),
                                Expanded(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text(
                                      'User Can Change \n Salary their own',
                                    ),
                                    value: controller.usercanchange.value,
                                    onChanged:
                                        (value) =>
                                            controller.usercanchange.value =
                                                value ?? false,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                initialValue:
                                    controller.IncreaseSalary.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Set Amount (Optional)',
                                  suffixIcon: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      controller.icon,
                                      color: controller.color,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                onSaved:
                                    (value) =>
                                        controller.IncreaseSalary.value =
                                            double.tryParse(value ?? '') ?? 0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () => Get.back(),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                  onPressed: () {
                                    if (_formKey1.currentState?.validate() ??
                                        false) {
                                      _formKey1.currentState?.save();
                                      WidgetsBinding.instance.addPostFrameCallback((
                                        _,
                                      ) {
                                        showAwesomeSnackBarGetx(
                                          "Policy Setup",
                                          "Setup Policy  : ${controller.Username.value} Successfully",
                                          ContentType.success,
                                        );
                                      });
                                      Get.close(0);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPopDialogOther() {
    final controller = Get.find<PayrollPolicyController>();
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.purple.shade900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'PAYROLL POLICY',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      )
                      : Form(
                        key: _formKey1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                initialValue: controller.Username.value,
                                decoration: InputDecoration(
                                  labelText: 'FIND USERNAME',
                                  suffixIcon: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      controller.icon,
                                      color: controller.color,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                validator:
                                    (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Please enter a username'
                                            : null,
                                onSaved:
                                    (value) =>
                                        controller.Username.value = value ?? '',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                initialValue: controller.SetSalary.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Set Salary',
                                  suffixIcon: Icon(
                                    Icons.monetization_on,
                                    color: Colors.purple.shade900,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                validator:
                                    (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Please Set Salary'
                                            : null,
                                onSaved:
                                    (value) =>
                                        controller.SetSalary.value =
                                            double.tryParse(value ?? '') ?? 0,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    title: const Text(
                                      'Restrict',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    value: controller.usercannotchange.value,
                                    onChanged:
                                        (value) =>
                                            controller.usercannotchange.value =
                                                value ?? false,
                                  ),
                                ),
                                Expanded(
                                  child: CheckboxListTile(
                                    title: const Text(
                                      ' Unrestrict',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    value: controller.usercanchange.value,
                                    onChanged:
                                        (value) =>
                                            controller.usercanchange.value =
                                                value ?? false,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                initialValue:
                                    controller.IncreaseSalary.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Increase Amount (Optional)',
                                  suffixIcon: Icon(
                                    Icons.monetization_on,
                                    color: Colors.purple.shade900,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                onSaved:
                                    (value) =>
                                        controller.IncreaseSalary.value =
                                            double.tryParse(value ?? '') ?? 0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () => Get.back(),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                  onPressed: () {
                                    if (_formKey1.currentState?.validate() ??
                                        false) {
                                      _formKey1.currentState?.save();
                                      Get.snackbar(
                                        'New Create',
                                        'Set Policy Payroll on: ${controller.Username.value} Successfully',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green.shade100,
                                        colorText: Colors.black,
                                      );
                                      Get.close(0);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
            ),
          ],
        ),
      );
    });
  }
}
