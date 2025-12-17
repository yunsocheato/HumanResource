import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Model/user_setup_model.dart';

class UserSetupController extends GetxController {
  final NameController = TextEditingController();
  final UserIDController = TextEditingController();
  final EmailController = TextEditingController();
  final DepartmentController = TextEditingController();
  final AddressController = TextEditingController();
  final poisitionController = TextEditingController();
  final id_cardController = TextEditingController();
  final fingerprint_idController = TextEditingController();
  final PhoneController = TextEditingController();
  final RoleController = TextEditingController();
  final passwordController = TextEditingController();
  final createAtController = TextEditingController();
  final Color color = Colors.red.shade900;

  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    clearDataFields();
  }

  //   Future<void> createuser() async {
  //   final name = NameController.text.trim();
  //   final email = EmailController.text.trim();
  //   final department = DepartmentController.text.trim();
  //   final position = poisitionController.text.trim();
  //   final idCard = id_cardController.text.trim();
  //   final fingerprint = fingerprint_idController.text.trim();
  //   final phone = PhoneController.text.trim();
  //   final address = AddressController.text.trim();
  //   final role = RoleController.text.trim();
  //   final password = passwordController.text.trim();

  //   isLoading.value = true;

  //   try {
  //     print("DEBUG: starting signUp...");
  //     final response = await Supabase.instance.client.auth.signUp(
  //       email: email,
  //       password: password,
  //     );

  //     print("DEBUG: auth user: ${response.user}");
  //     if (response.user == null) {
  //       throw Exception("Auth signup failed");
  //     }

  //     final user = response.user!;

  //     // Insert into signupuser table
  //     final insertResponse = await Supabase.instance.client.from('signupuser').insert({
  //       'user_id': user.id,
  //       'name': name,
  //       'email': email,
  //       'department': department,
  //       'position': position,
  //       'id_card': idCard,
  //       'fingerprints_id': fingerprint,
  //       'phone': phone,
  //       'address': address,
  //       'role': role,
  //       'created_at': DateTime.now(),
  //     });

  //     print("DEBUG: insert response: $insertResponse");

  //     showAwesomeSnackBarGetx(
  //       "Success",
  //       "User created successfully",
  //       ContentType.success,
  //     );

  //     clearDataFields();
  //     Get.offNamed('/dashboard');
  //   } on AuthException catch (e) {
  //     print("AUTH ERROR: ${e.message}");
  //     showAwesomeSnackBarGetx("Error", e.message, ContentType.failure);
  //   } on PostgrestException catch (e) {
  //     print("DB ERROR: ${e.message}, details: ${e.details}, hint: ${e.hint}");
  //     showAwesomeSnackBarGetx("Error", e.message, ContentType.failure);
  //   } catch (e) {
  //     print("UNKNOWN ERROR: $e");
  //     showAwesomeSnackBarGetx("Error", e.toString(), ContentType.failure);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> createuser() async {
    final name = NameController.text.trim();
    final email = EmailController.text.trim();
    final department = DepartmentController.text.trim();
    final position = poisitionController.text.trim();
    final idCard = id_cardController.text.trim();
    final fingerprint = fingerprint_idController.text.trim();
    final phone = PhoneController.text.trim();
    final address = AddressController.text.trim();
    final role = RoleController.text.trim();
    final password = passwordController.text.trim();

    if (password.length < 12) {
      showAwesomeSnackBarGetx(
        "Error",
        "Password must be at least 12 characters.",
        ContentType.failure,
      );
      return;
    }
    isLoading.value = true;
    try {
      final existingUser = await Supabase.instance.client
          .from('signupuser')
          .select()
          .eq('email', email);

      if ((existingUser as List).isNotEmpty) {
        showAwesomeSnackBarGetx(
          "Error",
          "User with this email already exists.",
          ContentType.failure,
        );
        return;
      }
      print("DEBUG: starting signUp...");
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      print("DEBUG: auth user: ${response.user}");
      if (response.user == null) {
        throw Exception("Auth signup failed");
      }
      final user = response.user!;
      await Supabase.instance.client.from('signupuser').insert({
        'user_id': user.id,
        'name': name,
        'email': email,
        'department': department,
        'position': position,
        'id_card': idCard,
        'fingerprints_id': fingerprint,
        'phone': phone,
        'address': address,
        'role': role,
        'created_at': DateTime.now(),
      });

      showAwesomeSnackBarGetx(
        "Success",
        "User created successfully",
        ContentType.success,
      );

      clearDataFields();
      Get.offNamed('/dashboard');
    } on AuthException catch (e) {
      showAwesomeSnackBarGetx("Error", e.message, ContentType.failure);
    } on PostgrestException catch (e) {
      showAwesomeSnackBarGetx("Error", e.message, ContentType.failure);
    } catch (e) {
      showAwesomeSnackBarGetx("Error", e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  void clearDataFields() {
    NameController.clear();
    EmailController.clear();
    DepartmentController.clear();
    poisitionController.clear();
    id_cardController.clear();
    fingerprint_idController.clear();
    PhoneController.clear();
    AddressController.clear();
    RoleController.clear();
    // createAtController.clear();
  }

  void mapDataFields(UserSetupModel data) {
    NameController.text = data.name;
    EmailController.text = data.email;
    DepartmentController.text = data.department;
    poisitionController.text = data.position;
    id_cardController.text = data.idCard;
    fingerprint_idController.text = data.fingerprint?.toString() ?? '';
    PhoneController.text = data.phone;
    AddressController.text = data.address;
    RoleController.text = data.role;
    // createAtController.text = data.createdAt;
  }
}
