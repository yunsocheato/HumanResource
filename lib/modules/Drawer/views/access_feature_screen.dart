import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../controllers/access_feature_controller.dart';

class AccessFeatureScreen extends GetView<AccessFeatureController> {
  var _formkey1 = GlobalKey<FormState>();
  var _formkey2 = GlobalKey<FormState>();

  AccessFeatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveOTpolicy();
  }

  Widget _buildResponsiveOTpolicy() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

  Widget _buildPopDialogMobile() {
    final controller = Get.find<AccessFeatureController>();
    final context = Get.context;
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange.shade900,
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
                      'Access Feature Setup',
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
                        key: _formkey2,
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
                              padding: const EdgeInsets.all(16.0),
                              child: Obx(
                                () => Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Wrap(
                                    spacing: 16,
                                    runSpacing: 16,
                                    children:
                                        UserRole.values.map((role) {
                                          final isSelected =
                                              controller.selectedRole.value ==
                                              role;
                                          return SizedBox(
                                            width:
                                                MediaQuery.of(
                                                      context!,
                                                    ).size.width /
                                                    2 -
                                                32,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RadioListTile<UserRole>(
                                                  title: Text(
                                                    role
                                                        .toString()
                                                        .split('.')
                                                        .last,
                                                  ),
                                                  value: role,
                                                  groupValue:
                                                      controller
                                                          .selectedRole
                                                          .value,
                                                  onChanged: (value) {
                                                    controller
                                                        .selectedRole
                                                        .value = value!;
                                                  },
                                                ),
                                                if (isSelected)
                                                  ...controller.featureaccessMap[role]!.map(
                                                    (feature) => Obx(
                                                      () => CheckboxListTile(
                                                        contentPadding:
                                                            const EdgeInsets.only(
                                                              left: 16,
                                                            ),
                                                        title: Text(feature),
                                                        value:
                                                            controller
                                                                .featureSelectionMap[role]![feature]!
                                                                .value,
                                                        onChanged: (val) {
                                                          controller
                                                              .featureSelectionMap[role]![feature]!
                                                              .value = val!;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ),
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
                                    backgroundColor: Colors.orange.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                  onPressed: () {
                                    if (_formkey2.currentState?.validate() ??
                                        false) {
                                      _formkey2.currentState?.save();
                                      Get.snackbar(
                                        'New Create',
                                        'Access Feature Policy on: ${controller.Username.value} Successfully',
                                        snackPosition: SnackPosition.TOP,
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

  Widget _buildPopDialogOther() {
    final controller = Get.find<AccessFeatureController>();
    final roles = UserRole.values;
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange.shade900,
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
                      'Access Feature Setup',
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
                        key: _formkey2,
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
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Role',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: (roles.length / 2).ceil(),
                                    itemBuilder: (context, index) {
                                      final role1 = roles[index * 2];
                                      final role2 =
                                      (index * 2 + 1 < roles.length) ? roles[index * 2 + 1] : null;

                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(child: _buildRoleItem(role1)),
                                          if (role2 != null) Expanded(child: _buildRoleItem(role2)),
                                        ],
                                      );
                                    },
                                  ),
                                ],
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
                                    backgroundColor: Colors.orange.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                  onPressed: () {
                                    if (_formkey2.currentState?.validate() ??
                                        false) {
                                      _formkey2.currentState?.save();
                                      Get.snackbar(
                                        'New Create',
                                        'Access Feature Policy on: ${controller.Username.value} Successfully',
                                        snackPosition: SnackPosition.TOP,
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
  Widget buildRoleList() {
    final roles = UserRole.values;

    return ListView.builder(
      itemCount: (roles.length / 2).ceil(),
      itemBuilder: (context, index) {
        int firstIndex = index * 2;
        int secondIndex = firstIndex + 1;

        UserRole role1 = roles[firstIndex];
        UserRole? role2 = secondIndex < roles.length ? roles[secondIndex] : null;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildRoleItem(role1)),
            if (role2 != null) Expanded(child: _buildRoleItem(role2)),
            if (role2 == null) Spacer(),
          ],
        );
      },
    );
  }
  Widget _buildRoleItem(UserRole role) {
    final controller = Get.find<AccessFeatureController>();

    return Obx(() {
      final isSelected = controller.selectedRole.value == role;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListTile<UserRole>(
            title: Text(role.toString().split('.').last),
            value: role,
            groupValue: controller.selectedRole.value,
            onChanged: (value) {
              controller.selectedRole.value = value!;
            },
          ),
          if (isSelected)
            ...controller.featureaccessMap[role]!.map(
                  (feature) => Obx(() => CheckboxListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 16),
                title: Text(feature),
                value: controller.featureSelectionMap[role]![feature]!.value,
                onChanged: (val) {
                  controller.featureSelectionMap[role]![feature]!.value = val!;
                },
              )),
            ),
        ],
      );
    });
  }
}
