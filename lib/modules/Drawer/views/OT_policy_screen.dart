import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hrms/modules/Drawer/controllers/OT_policy_controller.dart';

class OTPolicyScreen extends GetView<OTPolicyController>{
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
   OTPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveOTpolicy();
  }

  Widget _buildResponsiveOTpolicy(){
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

  Widget _buildPopDialogMobile() {
    final controller = Get.find<OTPolicyController>();
    final textController = TextEditingController(text: controller.Username.value);
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
                      'OT POLICY SETUP',
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
                  ? Center(child: CircularProgressIndicator(color: Colors.blue.shade900))
                  : Form(
                key: _formkey1,
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
                              controller.fetchUserByOTPolicy(textController.text);
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
                                controller.fetchUserByOTPolicy(suggestion);
                                controller.suggestionList.clear();
                              },
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Technical'),
                            value: controller.ifTechnical.value,
                            onChanged: (value) =>
                            controller.ifTechnical.value = value ?? false,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Non Technical'),
                            value: controller.ifNonTechnical.value,
                            onChanged: (value) =>
                            controller.ifNonTechnical.value = value ?? false,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Restrict Change'),
                            value: controller.usercannotchange.value,
                            onChanged: (value) =>
                            controller.usercannotchange.value = value ?? false,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Unrestrict Change'),
                            value: controller.usercanchange.value,
                            onChanged: (value) =>
                            controller.usercanchange.value = value ?? false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Close', style: TextStyle(color: Colors.red)),
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
                            onPressed: () async {
                              await controller.InsertData();
                              Get.snackbar(
                                'New Create',
                                'Access OT Policy on: ${controller.Username.value} Successfully',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white.withOpacity(0.3),
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


  Widget _buildPopDialogOther() {
    final controller = Get.find<OTPolicyController>();
    final textController = TextEditingController(text: controller.Username.value);
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
                      'OT POLICY SETUP',
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
                  ? Center(child: CircularProgressIndicator(color: Colors.blue.shade900))
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
                              controller.fetchUserByOTPolicy(textController.text);
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
                                controller.fetchUserByOTPolicy(suggestion);
                                controller.suggestionList.clear();
                              },
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Technical'),
                            value: controller.ifTechnical.value,
                            onChanged: (value) =>
                            controller.ifTechnical.value = value ?? false,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Non Technical'),
                            value: controller.ifNonTechnical.value,
                            onChanged: (value) =>
                            controller.ifNonTechnical.value = value ?? false,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Restrict Change'),
                            value: controller.usercannotchange.value,
                            onChanged: (value) =>
                            controller.usercannotchange.value = value ?? false,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Unrestrict Change'),
                            value: controller.usercanchange.value,
                            onChanged: (value) =>
                            controller.usercanchange.value = value ?? false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Close', style: TextStyle(color: Colors.red)),
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
                            onPressed: () async {
                              await controller.InsertData();
                              Get.snackbar(
                                'New Create',
                                'Access OT Policy on: ${controller.Username.value} Successfully',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white.withOpacity(0.3),
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

}