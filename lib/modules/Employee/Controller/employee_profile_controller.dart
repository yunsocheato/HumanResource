import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../API/employee_profile_sql.dart';
import '../models/employee_profile_model.dart';

class EmployeeProfileController extends GetxController {
  final EmployeeProfilesql _employeeProfilesql = EmployeeProfilesql();
  final Rxn<EmployeeProfileModel> _userprofiles = Rxn<EmployeeProfileModel>();

  final IconData icon = Icons.search;
  final Color color = Colors.green.shade900;
  final RxString Username = ''.obs;
  final RxList<String> suggestionList = <String>[].obs;

  RxBool isLoading = true.obs;
  RxBool isEnabled = false.obs;

  RxString profileImageUrl = ''.obs;
  File? imageFile;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final positionController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final idCardController = TextEditingController();
  final departmentController = TextEditingController();
  final fingerprintidController = TextEditingController();
  final RoleUserTextController = TextEditingController();

  final ScrollController horizontalScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();
  final profileHCtrl = ScrollController();

  var showlogincard1 = true.obs;

  var nameText = ''.obs;
  var emailText = ''.obs;
  var positionText = ''.obs;
  var addressText = ''.obs;
  var phoneText = ''.obs;
  var idCardText = ''.obs;
  var departmentText = ''.obs;
  var roleText = ''.obs;
  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    debounce(Username, (value) {
      fetchSuggestionsProfile(value);
    }, time: const Duration(milliseconds: 300));
    Future.delayed(Duration(milliseconds: 500), () {
      showlogincard1.value = true;
    });
    nameController.addListener(() => nameText.value = nameController.text);
    emailController.addListener(() => emailText.value = emailController.text);
    positionController.addListener(() => positionText.value = positionController.text);
    phoneController.addListener(() => phoneText.value = phoneController.text);
    idCardController.addListener(() => idCardText.value = idCardController.text);
    addressController.addListener(() => addressText.value = addressController.text);
    fingerprintidController.addListener(() => fingerprintidController.text = fingerprintidController.text);
    departmentController.addListener(() => departmentText.value = departmentController.text);
    RoleUserTextController.addListener(() => roleText.value = RoleUserTextController.text);
  }
  @override
  void onClose() {
    profileHCtrl.dispose();
    super.onClose();
  }
  EmployeeProfileModel? get userProfile => _userprofiles.value;

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      final email = _employeeProfilesql.userEmail;
      if (email == null) return;

      final profile = await _employeeProfilesql.getEmployeeProfile(email);
      _userprofiles.value = profile;

      if (profile != null) {
        nameController.text = profile.name ?? '';
        emailController.text = profile.email ?? '';
        positionController.text = profile.position ?? '';
        addressController.text = profile.address ?? '';
        phoneController.text = profile.phone ?? '';
        idCardController.text = profile.id_card ?? '';
        departmentController.text = profile.department ?? '';
        fingerprintidController.text = profile.fingerprint_id?.toString() ?? '';
        RoleUserTextController.text = profile.Role ?? '';
        profileImageUrl.value = profile.photo_url!;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchSuggestionsProfile(String query) async {
    suggestionList.value =
    await _employeeProfilesql.fetchUsernameSuggestionsEmployeeProfile(query);
  }

  Future<void> fetchbyusersemployeeProfile(String name) async {
    isLoading.value = true;

    clearDataFields();

    try {
      var data = await _employeeProfilesql.fetchUserByEmployeeProfile(name);
      if (data != null) {
        mapDataFields(data);
      } else {
        Get.snackbar('Error', 'User Not Found');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load user: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserInfo() async {
    try {
      isLoading.value = true;
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      final updates = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'address': addressController.text.trim(),
        'fingerprint_id': fingerprintidController.text.trim(),
        'position': positionController.text.trim(),
        'phone': phoneController.text.trim(),
        'id_card': idCardController.text.trim(),
        'department': departmentController.text.trim(),
        'role': RoleUserTextController.text.trim(),
        'photo_url': profileImageUrl.value,
      };

      await _employeeProfilesql.UpdateUserInfo(user.id, updates);
      Get.snackbar('Success', 'Profile updated!');
      isEnabled.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Update failed: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> pickerImageProfile() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      Get.dialog(
        AlertDialog(
          title: const Text('Upload Image'),
          content: Image.file(imageFile!),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  final imageUrl = await _employeeProfilesql.uploadImage(imageFile!);
                  profileImageUrl.value = imageUrl;
                  imageFile = null;
                  Get.back();
                  Get.snackbar('Success', 'Image uploaded successfully!');
                } catch (e) {
                  Get.snackbar('Error', 'Failed to upload image: $e');
                }
              },
              child: const Text('Upload'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  void toggleEnable() => isEnabled.value = !isEnabled.value;

  void clearDataFields() {
    nameController.clear();
    emailController.clear();
    positionController.clear();
    addressController.clear();
    phoneController.clear();
    idCardController.clear();
    departmentController.clear();
    fingerprintidController.clear();
    RoleUserTextController.clear();

    nameText.value = '';
    emailText.value = '';
    positionText.value = '';
    phoneText.value = '';
    idCardText.value = '';
    departmentText.value = '';
    addressText.value = '';
    roleText.value = '';
    profileImageUrl.value = '';
    Username.value = '';
  }

  void mapDataFields(EmployeeProfileModel data) {
    Username.value = data.name ?? '';
    nameController.text = data.name ?? '';
    emailController.text = data.email ?? '';
    positionController.text = data.position ?? '';
    addressController.text = data.address ?? '';
    phoneController.text = data.phone ?? '';
    idCardController.text = data.id_card ?? '';
    departmentController.text = data.department ?? '';
    fingerprintidController.text = data.fingerprint_id.toString();
    RoleUserTextController.text = data.Role ?? '';
    profileImageUrl.value = data.photo_url ?? '';
  }

  void refreshData() => updateUserInfo();
}
