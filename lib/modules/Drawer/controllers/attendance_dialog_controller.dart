import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AttendanceDialogController extends GetxController {
  final isLoading = false.obs;
  final isExpanded = false.obs;
  final formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final issubmitted = false.obs;

  void submit() async {

  }
}