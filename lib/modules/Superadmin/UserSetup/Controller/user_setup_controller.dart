import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final createdAt = createAtController.text.trim();

    isLoading.value = true;

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        Get.snackbar(
          'Error',
          'Failed to create user',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
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
        'created_at': createdAt,
      });
      Get.snackbar(
        'Success',
        'User created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      clearDataFields();
      Get.offNamed('/dashboard');
    } on AuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } on PostgrestException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
    createAtController.clear();
  }

  void mapDataFields(UserSetupModel data) {
    NameController.text = data.name ?? " ";
    EmailController.text = data.email ?? " ";
    DepartmentController.text = data.department ?? " ";
    poisitionController.text = data.position ?? " ";
    id_cardController.text = data.idCard ?? " ";
    fingerprint_idController.text = data.fingerprint?.toString() ?? '';
    PhoneController.text = data.phone ?? " ";
    AddressController.text = data.address ?? " ";
    RoleController.text = data.role ?? " ";
    createAtController.text = data.createdAt ?? " ";
  }
}
