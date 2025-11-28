import 'dart:convert';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Core/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../Utils/SnackBar/snack_bar.dart';

class VerificationController extends GetxController {
  final emailController = TextEditingController();
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final retypepasswordController = TextEditingController();
  final otpControllers = List.generate(4, (_) => TextEditingController()).obs;
  final GlobalKey<ScaffoldState> stepback = GlobalKey<ScaffoldState>();
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
            '/otp',
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

  Future<void> sendOtp() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showError("Email cannot be empty");
      return;
    }

    isLoading.value = true;
    isOtpSent.value = false;
    final otp = (1000 + Random().nextInt(9000)).toString();
    generatedOtp.value = otp;

    try {
      final response = await http.post(
        Uri.parse('https://fastapi.cheato.top/send-otp'),
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
      } else {
        showError("Failed to send OTP. Status code: ${response.statusCode}");
        isOtpSent.value = false;
      }
    } catch (e) {
      showError("Failed to send OTP: $e");
      isOtpSent.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendopt() async {
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

  Future<void> verifyOtp() async {
    final enteredOtp = otpControllers.map((c) => c.text).join();
    final emailText = emailController.text.trim();

    if (emailText.isEmpty || enteredOtp.isEmpty) {
      showError("Email and OTP cannot be empty");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://fastapi.cheato.top/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': emailText, 'otp': enteredOtp}),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['status'] == 'success') {
        showSuccess(result['message']);
        verifiedOtp.value = enteredOtp;
        isOtpVerified.value = true;
        await Future.delayed(Duration(milliseconds: 500));
        Get.offAllNamed('/change_password');
      } else {
        showError(
          result['detail'] ?? result['message'] ?? "OTP verification failed",
        );
      }
    } catch (e) {
      showError("Server error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword() async {
    final email = emailController.text.trim();
    final otp = getOtpCode();
    final oldPassword = oldpasswordController.text.trim();
    final newPassword = newpasswordController.text.trim();
    final retypePassword = retypepasswordController.text.trim();

    if ([
      email,
      otp,
      oldPassword,
      newPassword,
      retypePassword,
    ].any((e) => e.isEmpty)) {
      showError("All fields are required");
      return;
    }

    if (newPassword.length < 12) {
      showError("Password must be at least 12 characters long");
      return;
    }

    if (newPassword != retypePassword) {
      showError("Passwords do not match");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://fastapi.cheato.top/change-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "otp": otp,
          "old_password": oldpasswordController.text.trim(),
          "new_password": newpasswordController.text.trim(),
          "retype_password": retypepasswordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSuccess(data['message'] ?? "Password updated successfully!");
        Get.offAllNamed('/overview');
        ClearDataField();
      } else {
        showError(
          data['detail'] ?? data['message'] ?? "Failed to update password",
        );
      }
    } catch (e) {
      showError("Failed to update password: $e");
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

  String maskEmail(String email) {
    if (email.isEmpty) return '';
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final name = parts[0];
    final domain = parts[1];

    final visible = name.length <= 2 ? name : name.substring(0, 2);
    final masked = '*' * (name.length - visible.length);

    return '$visible$masked@$domain';
  }

  String getOtpCode() {
    return otpControllers.map((c) => c.text.trim()).join();
  }
}
