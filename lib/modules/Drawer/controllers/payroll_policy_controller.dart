import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayrollPolicyController extends GetxController{
  final TextEditingController Usernames = TextEditingController();

  final RxDouble SetSalary = 0.0.obs;
  final RxDouble IncreaseSalary = 0.0.obs;
  final RxString Username = ''.obs;

  final usercannotchange = false.obs;
  final usercanchange = true.obs;

  final isLoading = false.obs;

  final IconData icon = Icons.search;
  final Color color= Colors.blue.shade900;
}