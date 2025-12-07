import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FingerPrintController extends GetxController {
  final isLoading = false.obs;
  final fingerPrint = ''.obs;
  final fingerPrintList = <String>[].obs;

  final RxString Username = ''.obs;
  final IconData icon = Icons.search;
  final Color color = Colors.red.shade900;

  final usercannotchange = false.obs;
  final usercanchange = false.obs;
}
