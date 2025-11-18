import 'package:awesome_snackbar_content/awesome_snackbar_content.dart'
    show ContentType;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../Utils/SnackBar/snack_bar.dart';
import '../controllers/fingerprint_setup_controller.dart';

class FingerPrintScreen extends GetView<FingerPrintController> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  FingerPrintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveFingerprintsetup();
  }

  Widget _buildResponsiveFingerprintsetup() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildPopDialogMobile() : _buildPopDialogOther();
  }

  Widget _buildPopDialogMobile() {
    final controller = Get.find<FingerPrintController>();
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red.shade900,
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
                      'FINGER PRINT SETUP',
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
                                initialValue: controller.fingerPrint.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'FingerPrint',
                                  suffixIcon: Icon(
                                    Icons.fingerprint,
                                    color: Colors.red,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                validator:
                                    (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Required FingerPrint ID'
                                            : null,
                                onSaved:
                                    (value) =>
                                        controller.fingerPrint.value =
                                            value ?? '',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('Restrict'),
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
                                    title: const Text('Unrestrict'),
                                    value: controller.usercanchange.value,
                                    onChanged:
                                        (value) =>
                                            controller.usercanchange.value =
                                                value ?? false,
                                  ),
                                ),
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
                                    backgroundColor: Colors.red.shade900,
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
                                          "Create FingerPrint",
                                          "The FingerprintID ${controller.fingerPrint.value}Setup on Username :${controller.Username.value} Successfully",
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
    final controller = Get.find<FingerPrintController>();
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red.shade900,
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
                      'FINGER PRINT SETUP',
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
                                initialValue: controller.fingerPrint.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'FingerPrint',
                                  suffixIcon: Icon(
                                    Icons.fingerprint,
                                    color: Colors.red,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                validator:
                                    (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Required FingerPrint ID'
                                            : null,
                                onSaved:
                                    (value) =>
                                        controller.fingerPrint.value =
                                            value ?? '',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('Restrict'),
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
                                    title: const Text('Unrestrict'),
                                    value: controller.usercanchange.value,
                                    onChanged:
                                        (value) =>
                                            controller.usercanchange.value =
                                                value ?? false,
                                  ),
                                ),
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
                                    backgroundColor: Colors.red.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Create'),
                                  onPressed: () {
                                    if (_formKey2.currentState?.validate() ??
                                        false) {
                                      _formKey2.currentState?.save();
                                      WidgetsBinding.instance.addPostFrameCallback((
                                        _,
                                      ) {
                                        showAwesomeSnackBarGetx(
                                          "Create FingerPrint",
                                          "The FingerprintID ${controller.fingerPrint.value}Setup on Username :${controller.Username.value} Successfully",
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
}
