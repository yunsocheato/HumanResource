import 'dart:convert';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:http/http.dart' as http;
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

  @override
  void onInit() {
    super.onInit();
    ever(isOtpSent, (sent) {
      if (sent == true && emailController.text.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(
            '/otp_reset',
            arguments: {
              'email': emailController.text,
              'otp': generatedOtp.value,
            },
          );
        });
      }
    });

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        emailController.text = currentUser.value!.email ?? '';
        retypepasswordController.text = newpasswordController.text;
        oldpasswordController.text = newpasswordController.text;
        newpasswordController.text = newpasswordController.text;
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        userdata.clear();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      emailController.text = currentUser.value!.email ?? '';
      retypepasswordController.text = newpasswordController.text;
      oldpasswordController.text = newpasswordController.text;
      newpasswordController.text = newpasswordController.text;
    }
  }

  @override
  void onClose() {
    emailController.dispose();

    for (final c in otpControllers) {
      c.dispose();
    }
    oldpasswordController.dispose();
    newpasswordController.dispose();
    retypepasswordController.dispose();
    super.onClose();
    isOtpVerified.value = false;
    isLoading.value = false;
  }

  void ClearDataField() {
    emailController.clear();
    oldpasswordController.clear();
    newpasswordController.clear();
    retypepasswordController.clear();
    for (final c in otpControllers) {
      c.clear();
    }
  }

  Future<void> sendEmailOTP() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      errorMessage.value = 'Email cannot be empty';
      return;
    }
    isLoading.value = true;
    isOtpSent.value = false;
    final otp = (1000 + Random().nextInt(9000)).toString();
    generatedOtp.value = otp;
    try {
      final response = await http.post(
        Uri.parse('https://fastapi.cheato.top/send-reset-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          showSuccess("OTP sent to your email");
          isOtpSent.value = true;
        } else {
          showError(
            "Failed to send OTP: ${data['message'] ?? 'Unknown error'}",
          );
          isOtpSent.value = false;
        }
      }
    } catch (e) {
      showError("Failed to send OTP: $e");
      isOtpSent.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void showError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx("Error", message, ContentType.failure);
    });
  }

  void showSuccess(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx("Success", message, ContentType.success);
    });
  }

  Future<void> resend_opt_reset_password() async {
    final email = emailController.text.trim();
    if (email.isEmpty || isOtpSent.value) return;

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 3));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Successfully',
          'OTP CODE SENT TO YOUR EMAIL',
          ContentType.success,
        );
      });
      isOtpSent.value = true;
      isOtpVerified.value = true;
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Failed',
          'OTP CODE CANNOT SENT',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtpAndSendReset() async {
    final enteredOtp = otpControllers.map((c) => c.text.trim()).join();
    final emailText = emailController.text.trim();

    if (emailText.isEmpty || enteredOtp.isEmpty) {
      showError("Email and OTP cannot be empty");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://fastapi.cheato.top/verify-otp-reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': emailText, 'otp': enteredOtp}),
      );

      print("Response code: ${response.statusCode}");
      print("Response body: ${response.body}");

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          result['status'] != null &&
          result['status'].toString().toLowerCase() == 'success') {
        showSuccess(result['message'] ?? "OTP verified successfully");
        verifiedOtp.value = enteredOtp;
        isOtpVerified.value = true;
        await Future.delayed(Duration(milliseconds: 500));
        Get.offAllNamed('/check_mail');
      } else {
        showError(result['message'] ?? "OTP verification failed");
      }
    } catch (e) {
      showError("Server error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
