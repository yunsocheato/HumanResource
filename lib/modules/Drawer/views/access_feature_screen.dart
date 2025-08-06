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
                        key: _formkey1,
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
                              child: buildAccessRoleSection(),
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
                                  child: const Text('CREATE'),
                                    onPressed: () async {
                                      if (_formkey1.currentState?.validate() ?? false) {
                                        _formkey1.currentState?.save();

                                        await controller.InsertData();

                                        Get.snackbar(
                                          'New Create',
                                          'Access Feature Policy on: ${controller.Username.value} Successfully',
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.green.shade100,
                                          colorText: Colors.black,
                                        );

                                        Get.close(0);
                                      }
                                    }
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
    final TextEditingController textController = TextEditingController(text: controller.Username.value);
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          labelText: 'Find Username',
                          suffixIcon: IconButton(
                            icon: Icon(controller.icon, color: controller.color),
                            onPressed: () {
                              controller.fetchbyusersAccessFeatures(textController.text);
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
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        constraints: const BoxConstraints(maxHeight: 150),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.suggestionList.length,
                          itemBuilder: (context, index) {
                            final suggestion = controller.suggestionList[index];
                            return ListTile(
                              title: Text(suggestion),
                              onTap: () {
                                textController.text = suggestion;
                                controller.Username.value = suggestion;
                                controller.fetchbyusersAccessFeatures(suggestion);
                                controller.suggestionList.clear();
                              },
                            );
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildAccessRoleSection(),
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
                            child: const Text('CREATE'),
                            onPressed: () async {
                                await controller.InsertData();
                                Get.snackbar(
                                  'New Create',
                                  'Access Feature Policy on: ${controller.Username.value} Successfully',
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.green.shade100,
                                  colorText: Colors.black,
                                );
                                Get.close(0);
                              }
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


  Widget buildAccessRoleSection() {
    final controller = Get.find<AccessFeatureController>();

    return Obx(() {
      final selectedRole = controller.selectedRole.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Role',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          ...UserRole.values.map(
                (role) => RadioListTile<UserRole>(
              title: Text(role.name),
              value: role,
              groupValue: selectedRole,
              onChanged: (value) {
                controller.selectedRole.value = value;
                controller.initializeSelections(value!); // ensure maps are filled
              },
            ),
          ),

          if (selectedRole != null) ...[
            SizedBox(height: 12),
            Text("Select Permissions", style: TextStyle(fontWeight: FontWeight.bold)),

            if (controller.permissionSelectionMap[selectedRole] != null)
              ...controller.permissionSelectionMap[selectedRole]!.entries.map(
                    (entry) => Obx(() => CheckboxListTile(
                  title: Text(entry.key),
                  value: entry.value.value,
                  onChanged: (val) => entry.value.value = val!,
                )),
              )
            else
              Text("No permissions available"),

            SizedBox(height: 12),
            Text("Select Features", style: TextStyle(fontWeight: FontWeight.bold)),

            if (controller.featureSelectionMap[selectedRole] != null)
              ...controller.featureSelectionMap[selectedRole]!.entries.map(
                    (entry) => Obx(() => CheckboxListTile(
                  title: Text(entry.key),
                  value: entry.value.value,
                  onChanged: (val) => entry.value.value = val!,
                )),
              )
            else
              Text("No features available"),
          ]
        ],
      );
    });
  }
}
