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

  Widget _buildPopDialogOther() {
    final controller = Get.find<AccessFeatureController>();
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
              child: controller.isLoading.value
                  ? Center(
                  child: CircularProgressIndicator(color: Colors.blue.shade900))
                  : Form(
                key: _formkey1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        initialValue: controller.Username.value,
                        decoration: InputDecoration(
                          labelText: 'FIND USERNAME',
                          suffixIcon: InkWell(
                            onTap: () {},
                            child: Icon(
                                controller.icon, color: controller.color),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        (value == null || value
                            .trim()
                            .isEmpty)
                            ? 'Please enter a username'
                            : null,
                        onSaved: (value) =>
                        controller.Username.value = value ?? '',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<UserRole>(
                            title: const Text('USER'),
                            value: UserRole.user,
                            groupValue: controller.selectedRole1.value,
                            onChanged: (value) {
                              if (value != null) controller.selectedRole1.value = value;
                            },
                          ),
                        ),
                        Expanded(
                            child:RadioListTile<UserRole>(
                              title: const Text('Admin'),
                              value: UserRole.admin,
                              groupValue: controller.selectedRole2.value,
                              onChanged: (value) {
                                if (value != null) controller.selectedRole2.value = value;
                              },
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: RadioListTile<UserRole>(
                              title: const Text('Supervisor'),
                              value: UserRole.supervisor,
                              groupValue: controller.selectedRole3.value,
                              onChanged: (value) {
                                if (value != null) controller.selectedRole3.value = value;
                              },
                            )
                        ),
                        Expanded(
                            child:RadioListTile<UserRole>(
                              title: const Text('SuperAdmin User'),
                              value: UserRole.superAdmin,
                              groupValue: controller.selectedRole4.value,
                              onChanged: (value) {
                                if (value != null) controller.selectedRole4.value = value;
                              },
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text(
                              'Close', style: TextStyle(color: Colors.red)),
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
                            if (_formkey1.currentState?.validate() ?? false) {
                              _formkey1.currentState?.save();
                              Get.snackbar(
                                'New Create',
                                'Set OT Policy on: ${controller.Username
                                    .value} Successfully',
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


  Widget _buildPopDialogMobile() {
    final controller = Get.find<AccessFeatureController>();
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
              child: controller.isLoading.value
                  ? Center(
                  child: CircularProgressIndicator(color: Colors.blue.shade900))
                  : Form(
                key: _formkey1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        initialValue: controller.Username.value,
                        decoration: InputDecoration(
                          labelText: 'FIND USERNAME',
                          suffixIcon: InkWell(
                            onTap: () {},
                            child: Icon(
                                controller.icon, color: controller.color),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        (value == null || value
                            .trim()
                            .isEmpty)
                            ? 'Please enter a username'
                            : null,
                        onSaved: (value) =>
                        controller.Username.value = value ?? '',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<UserRole>(
                            title: const Text('USER'),
                            value: UserRole.user,
                            groupValue: controller.selectedRole1.value,
                            onChanged: (value) {
                              if (value != null) controller.selectedRole1.value = value;
                            },
                          ),
                        ),
                        Expanded(
                            child:RadioListTile<UserRole>(
                              title: const Text('Admin'),
                              value: UserRole.admin,
                              groupValue: controller.selectedRole2.value,
                              onChanged: (value) {
                                if (value != null) controller.selectedRole2.value = value;
                              },
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: RadioListTile<UserRole>(
                              title: const Text('Supervisor'),
                              value: UserRole.supervisor,
                              groupValue: controller.selectedRole3.value,
                              onChanged: (value) {
                                if (value != null) controller.selectedRole3.value = value;
                              },
                            )
                        ),
                        Expanded(
                            child:RadioListTile<UserRole>(
                              title: const Text('SuperAdmin User'),
                              value: UserRole.superAdmin,
                              groupValue: controller.selectedRole4.value,
                              onChanged: (value) {
                                if (value != null) controller.selectedRole4.value = value;
                              },
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text(
                              'Close', style: TextStyle(color: Colors.red)),
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
                            if (_formkey1.currentState?.validate() ?? false) {
                              _formkey1.currentState?.save();
                              Get.snackbar(
                                'New Create',
                                'Set OT Policy on: ${controller.Username
                                    .value} Successfully',
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
}