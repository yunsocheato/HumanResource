import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPolicyController extends GetxController{
  final StartFrom = DateTime.now();
  final EndDate = DateTime.now().add(Duration(days: 7));

  final isLoading = false.obs;
  final isSwitched1 = false.obs;
  final isSwitched2 = false.obs;
  final isSwitched3= false.obs;

  final Username = ''.obs;
  final IconData icon = Icons.search;
  final Color color = Colors.orange.shade900;

  final usercannotchange = false.obs;
  final usercanchange = false.obs;

  final ifTechnical = false.obs;
  final ifNonTechnical = false.obs;


}