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
    return _buildDesktop(context);
  }

  // Widget _buildMobile(BuildContext context) {
  //   return Obx(() {
  //     return SingleChildScrollView(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           _buildHeader(title: 'Apply Leave', fontSize: 15, height: 30),
  //           const Divider(height: 1),
  //           Padding(
  //             padding: const EdgeInsets.all(12.0),
  //             child: controller.isLoading.value
  //                 ? Center(
  //               child: CircularProgressIndicator(
  //                 color: Colors.blue.shade900,
  //               ),
  //             )
  //                 : Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 _buildUsernameAutoSuggestField(),
  //                 const SizedBox(height: 16),
  //                 Align(
  //                   alignment: Alignment.centerRight,
  //                   child: TextButton(
  //                     child: const Text('Close',
  //                         style: TextStyle(color: Colors.red)),
  //                     onPressed: () => Get.back(),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

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
              child:
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      )
                      : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildUsernameAutoSuggestField(controller),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Colors.red),
                              ),
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

  Widget _buildHeader({
    required String title,
    required double fontSize,
    required double height,
  }) {
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

  Widget _buildUsernameAutoSuggestField(ApplyLeaveScreenController controller) {
    return Obx(() {
      return Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.search,
            controller: controller.usernameSearchController,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            onFieldSubmitted: (value) async {
              if (value.trim().isEmpty) return; // prevent empty search

              controller.isSelectingSuggestion.value = true;
              controller.Username.value = value;
              await controller.fetchbyusersLeave(value);
              controller.isSelectingSuggestion.value = false;

              Get.to(() => const ApplyLeaveScreen());

              controller.usernameSearchController.clear();
              controller.suggestionList.clear();
            },
            decoration: InputDecoration(
              hintText: 'FIND USERNAME',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  final value = controller.Username.value.trim();
                  if (value.isEmpty) return;

                  controller.isSelectingSuggestion.value = true;
                  await controller.fetchbyusersLeave(value);
                  controller.isSelectingSuggestion.value = false;

                  Get.to(() => const ApplyLeaveScreen());
                  controller.usernameSearchController.clear();
                  controller.suggestionList.clear();
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) async {
              if (controller.isSelectingSuggestion.value) return;

              controller.Username.value = v;

              if (v.isNotEmpty) {
                await controller.fetchSuggestionsLeave(v);
              } else {
                controller.suggestionList.clear();
              }
            },
          ),

          if (controller.suggestionList.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 6),
              constraints: const BoxConstraints(maxHeight: 150),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.builder(
                itemCount: controller.suggestionList.length,
                itemBuilder: (_, index) {
                  final s = controller.suggestionList[index];
                  return ListTile(
                    title: Text(s),
                    onTap: () async {
                      controller.isSelectingSuggestion.value = true;

                      controller.usernameSearchController.text = s;
                      controller.Username.value = s;

                      await controller.fetchbyusersLeave(s);

                      controller.isSelectingSuggestion.value = false;

                      Get.to(() => const ApplyLeaveScreen());

                      controller.suggestionList.clear();
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
