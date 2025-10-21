import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/Leave_Policy_controller.dart';

class LeavePolicy extends GetView<LeavePolicyController> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  LeavePolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveAttendanceStaff();
  }

  Widget _buildResponsiveAttendanceStaff() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

  Widget _buildPopDialogMobile() {
    final controller = Get.find<LeavePolicyController>();
    final TextEditingController textController = TextEditingController(
      text: controller.Username.value,
    );
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LEAVE POLICY',
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
                                controller: textController,
                                decoration: InputDecoration(
                                  labelText: 'Find Username',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.icon,
                                      color: controller.color,
                                    ),
                                    onPressed: () {
                                      controller.fetchUserByLeavePolicy(
                                        textController.text,
                                      );
                                    },
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  controller.Username.value = value;
                                },
                              ),
                            ),
                            if (controller.suggestionList.isNotEmpty &&
                                controller.Username.value.isNotEmpty)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                constraints: const BoxConstraints(
                                  maxHeight: 150,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.suggestionList.length,
                                  itemBuilder: (context, index) {
                                    final suggestion =
                                        controller.suggestionList[index];
                                    return ListTile(
                                      title: Text(suggestion),
                                      onTap: () {
                                        textController.text = suggestion;
                                        controller.Username.value = suggestion;
                                        controller.fetchUserByLeavePolicy(
                                          suggestion,
                                        );
                                        controller.suggestionList.clear();
                                      },
                                    );
                                  },
                                ),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => SwitchListTile(
                                    title: Text(
                                      'Policy Probation',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    value: controller.isBlockLeave.value,
                                    onChanged:
                                        (value) =>
                                            controller.isBlockLeave.value =
                                                value,
                                  ),
                                ),
                                Obx(() {
                                  if (!controller.isBlockLeave.value)
                                    return const SizedBox.shrink();
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Column(
                                      children: [
                                        CheckboxListTile(
                                          title: const Text(
                                            'Block Annual Leave',
                                          ),
                                          value:
                                              controller.blockAnualLeave.value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .blockAnualLeave
                                                      .value = value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Block Unpaid Leave',
                                          ),
                                          value:
                                              controller.blockUnpaidLeave.value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .blockUnpaidLeave
                                                      .value = value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text('Block Sick Leave'),
                                          value:
                                              controller.blockSickLeave.value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .blockSickLeave
                                                      .value = value ?? false,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => SwitchListTile(
                                    title: const Text(
                                      'Policy Deduction',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    value: controller.isDeduction.value,
                                    onChanged:
                                        (value) =>
                                            controller.isDeduction.value =
                                                value,
                                  ),
                                ),
                                Obx(
                                  () =>
                                      controller.isDeduction.value
                                          ? Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                          labelText:
                                                              'Monthly Salary',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                    onChanged:
                                                        (val) =>
                                                            controller
                                                                    .monthly
                                                                    .value =
                                                                int.tryParse(
                                                                  val,
                                                                ) ??
                                                                0,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                          labelText:
                                                              'Daily Salary',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                    onChanged:
                                                        (val) =>
                                                            controller
                                                                    .daily
                                                                    .value =
                                                                double.tryParse(
                                                                  val,
                                                                ) ??
                                                                0.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                          labelText:
                                                              'In Minutes',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                    onChanged:
                                                        (val) =>
                                                            controller
                                                                    .inMinute
                                                                    .value =
                                                                double.tryParse(
                                                                  val,
                                                                ) ??
                                                                0.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Obx(
                                  () => SwitchListTile(
                                    title: const Text(
                                      'Policy OverBalance',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    value: controller.isAgreement.value,
                                    onChanged:
                                        (value) =>
                                            controller.isAgreement.value =
                                                value,
                                  ),
                                ),
                                Obx(() {
                                  if (!controller.isAgreement.value)
                                    return const SizedBox.shrink();
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Column(
                                      children: [
                                        CheckboxListTile(
                                          title: const Text(
                                            'User have Limited on Leave Balance',
                                          ),
                                          value: controller.limitLeave.value,
                                          onChanged:
                                              (value) =>
                                                  controller.limitLeave.value =
                                                      value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Cannot Leave During Probation',
                                          ),
                                          value:
                                              controller
                                                  .notLeaveProbation
                                                  .value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .notLeaveProbation
                                                      .value = value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Only Unpaid Leave during Probation',
                                          ),
                                          value:
                                              controller
                                                  .unpaidLeaveAvailable
                                                  .value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .unpaidLeaveAvailable
                                                      .value = value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Sick leave Need Doctor Certificate',
                                          ),
                                          value:
                                              controller.sickLeaveCertif.value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .sickLeaveCertif
                                                      .value = value ?? false,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
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
                                    backgroundColor: Colors.blue.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                  onPressed: () async {
                                    await controller.InsertData();
                                    Get.snackbar(
                                      'New Create',
                                      'Access Leave Policy on: ${controller.Username.value} Successfully',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.white.withOpacity(
                                        0.3,
                                      ),
                                      colorText: Colors.black,
                                    );
                                    Get.close(0);
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
    final controller = Get.find<LeavePolicyController>();
    final TextEditingController textController = TextEditingController(
      text: controller.Username.value,
    );
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LEAVE POLICY',
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
                        key: _formKey2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  labelText: 'Find Username',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.icon,
                                      color: controller.color,
                                    ),
                                    onPressed: () {
                                      controller.fetchUserByLeavePolicy(
                                        textController.text,
                                      );
                                    },
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  controller.Username.value = value;
                                },
                              ),
                            ),
                            if (controller.suggestionList.isNotEmpty &&
                                controller.Username.value.isNotEmpty)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                constraints: const BoxConstraints(
                                  maxHeight: 150,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.suggestionList.length,
                                  itemBuilder: (context, index) {
                                    final suggestion =
                                        controller.suggestionList[index];
                                    return ListTile(
                                      title: Text(suggestion),
                                      onTap: () {
                                        textController.text = suggestion;
                                        controller.Username.value = suggestion;
                                        controller.fetchUserByLeavePolicy(
                                          suggestion,
                                        );
                                        controller.suggestionList.clear();
                                      },
                                    );
                                  },
                                ),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => SwitchListTile(
                                    title: Text(
                                      'Policy Probation',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    value: controller.isBlockLeave.value,
                                    onChanged:
                                        (value) =>
                                            controller.isBlockLeave.value =
                                                value,
                                  ),
                                ),
                                Obx(() {
                                  if (!controller.isBlockLeave.value)
                                    return const SizedBox.shrink();
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Column(
                                      children: [
                                        CheckboxListTile(
                                          title: const Text(
                                            'Block Annual Leave',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value:
                                              controller.blockAnualLeave.value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .blockAnualLeave
                                                      .value = value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Block Unpaid Leave',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value:
                                              controller.blockUnpaidLeave.value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .blockUnpaidLeave
                                                      .value = value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Block Sick Leave',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value:
                                              controller.blockSickLeave.value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .blockSickLeave
                                                      .value = value ?? false,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => SwitchListTile(
                                    title: const Text(
                                      'Policy Deduction',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    value: controller.isDeduction.value,
                                    onChanged:
                                        (value) =>
                                            controller.isDeduction.value =
                                                value,
                                  ),
                                ),
                                Obx(
                                  () =>
                                      controller.isDeduction.value
                                          ? Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                          labelText:
                                                              'Monthly Salary',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                    onChanged:
                                                        (val) =>
                                                            controller
                                                                    .monthly
                                                                    .value =
                                                                int.tryParse(
                                                                  val,
                                                                ) ??
                                                                0,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                          labelText:
                                                              'Daily Salary',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                    onChanged:
                                                        (val) =>
                                                            controller
                                                                    .daily
                                                                    .value =
                                                                double.tryParse(
                                                                  val,
                                                                ) ??
                                                                0.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                          labelText:
                                                              'In Minutes',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                    onChanged:
                                                        (val) =>
                                                            controller
                                                                    .inMinute
                                                                    .value =
                                                                double.tryParse(
                                                                  val,
                                                                ) ??
                                                                0.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Obx(
                                  () => SwitchListTile(
                                    title: const Text(
                                      'Policy OverBalance',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    value: controller.isAgreement.value,
                                    onChanged:
                                        (value) =>
                                            controller.isAgreement.value =
                                                value,
                                  ),
                                ),
                                Obx(() {
                                  if (!controller.isAgreement.value)
                                    return const SizedBox.shrink();
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Column(
                                      children: [
                                        CheckboxListTile(
                                          title: const Text(
                                            'User have Limited on Leave Balance',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value: controller.limitLeave.value,
                                          onChanged:
                                              (value) =>
                                                  controller.limitLeave.value =
                                                      value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Cannot Leave During Probation',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value:
                                              controller
                                                  .notLeaveProbation
                                                  .value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .notLeaveProbation
                                                      .value = value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Only Unpaid Leave during Probation',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value:
                                              controller
                                                  .unpaidLeaveAvailable
                                                  .value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .unpaidLeaveAvailable
                                                      .value = value ?? false,
                                        ),
                                        CheckboxListTile(
                                          title: const Text(
                                            'Sick leave Need Doctor Certificate',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value:
                                              controller.sickLeaveCertif.value,
                                          onChanged:
                                              (value) =>
                                                  controller
                                                      .sickLeaveCertif
                                                      .value = value ?? false,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
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
                                    backgroundColor: Colors.blue.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                  onPressed: () async {
                                    await controller.InsertData();
                                    Get.snackbar(
                                      'New Create',
                                      'Access Leave Policy on: ${controller.Username.value} Successfully',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.white.withOpacity(
                                        0.3,
                                      ),
                                      colorText: Colors.black,
                                    );
                                    Get.close(0);
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
