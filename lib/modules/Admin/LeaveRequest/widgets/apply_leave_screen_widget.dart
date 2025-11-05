import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apply_leave_screen_controller.dart';
import '../views/apply_leave_screen.dart';

class ApplyLeaveWidget extends GetView<ApplyLeaveScreenController> {
  const ApplyLeaveWidget({super.key});
  static const routeName = '/apply-leave';


  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 600;
    return isMobile ? _buildMobile(context) : _buildDesktop(context);
  }

  Widget _buildMobile(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(title: 'Apply Leave', fontSize: 15, height: 30),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: controller.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue.shade900,
                ),
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildUsernameAutoSuggestField(),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text('Close',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDesktop(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(title: 'Apply Leave', fontSize: 18, height: 60),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: controller.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue.shade900,
                ),
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildUsernameAutoSuggestField(),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text('Close',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(
      {required String title, required double fontSize, required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.purpleAccent.shade700,
        borderRadius: const BorderRadius.only(
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
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.settings, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameAutoSuggestField() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: controller.Username.value,
            decoration: InputDecoration(
              labelText: 'FIND USERNAME',
              suffixIcon: IconButton(
                icon: Icon(controller.icon, color: controller.color),
                onPressed: () {
                  if (controller.Username.value.isNotEmpty) {
                    controller.fetchbyusersLeave(
                      controller.Username.value,
                    );
                    Get.to(() => ApplyLeaveScreen());
                  }
                },
              ),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              controller.Username.value = value;
            },
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
                      controller.Username.value = suggestion;
                      controller.fetchbyusersLeave(suggestion);
                      controller.suggestionList.clear();
                      Get.to(() => ApplyLeaveScreen());
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }
}
