import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/drawer_dialog_screen_controller.dart';

class DialogScreen extends GetView<DialogScreenController> {
  final Widget content;
  final bool isfullscreen;

  const DialogScreen(
      {super.key, required this.content, this.isfullscreen = false});

  @override
  Widget build(BuildContext context) {
    return isfullscreen ? _buildDailog(context) : _buildPopDialog(context);
  }

  Widget _buildDailog(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              controller.CloseDialog();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Obx(() {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: content,
            ),
            if (controller.isLoading.value)
              Positioned.fill(
                child: Container(
                  color: Colors.blue.shade900,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildPopDialog(BuildContext context) {
    return Dialog(
      child: Obx(() {
        return Padding(padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (controller.isLoading.value)
                CircularProgressIndicator(color: Colors.blue.shade900,)
              else
                content,
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: controller.toggleExpanded,
                child: Obx(() {
                  return Text(controller.isExpanded.value ? 'Hide' : 'Show');
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}