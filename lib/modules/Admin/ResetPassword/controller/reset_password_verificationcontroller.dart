import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../Core/user_profile_model.dart';

class ResetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final retypepasswordController = TextEditingController();
  final otpControllers = List.generate(4, (_) => TextEditingController()).obs;
  final errorMessage = ''.obs;
  final generatedOtp = ''.obs;
  RxBool isVerified = false.obs;
  RxString verifiedOtp = ''.obs;
  var currentUser = Rxn<User>();
  final userdata = <UserProfileModel>[].obs;

  var email = ''.obs;
  var otp = ''.obs;
  var isLoading = false.obs;
  var isOtpVerified = false.obs;
  var isOtpSent = false.obs;
  RxBool change = true.obs;
  RxBool isvisible = true.obs;
  RxBool hide1 = true.obs;
  RxBool hide2 = true.obs;
  RxBool hide3 = true.obs;
}
