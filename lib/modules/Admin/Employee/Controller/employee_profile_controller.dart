import 'dart:typed_data';

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
  XFile? imageFile;
  final  usernameSearchController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final positionController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final idCardController = TextEditingController();
  final joinDateController = TextEditingController();
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
  var joinDateText = ''.obs;
  var departmentText = ''.obs;
  var roleText = ''.obs;


  @override
  void onInit() {
    super.onInit();
    loadUserProfile();

    debounce(
      Username,
          (value) => fetchSuggestionsProfile(value),
      time: const Duration(milliseconds: 300),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      showlogincard1.value = true;
    });

    nameController.addListener(() => nameText.value = nameController.text);
    emailController.addListener(() => emailText.value = emailController.text);
    positionController.addListener(
          () => positionText.value = positionController.text,
    );
    phoneController.addListener(() => phoneText.value = phoneController.text);
    idCardController.addListener(
          () => idCardText.value = idCardController.text,
    );
    addressController.addListener(
          () => addressText.value = addressController.text,
    );
    joinDateController.addListener(
          () => joinDateText.value = joinDateController.text,
    );
    departmentController.addListener(
          () => departmentText.value = departmentController.text,
    );
    RoleUserTextController.addListener(
          () => roleText.value = RoleUserTextController.text,
    );
  }

  @override
  void onClose() {
    profileHCtrl.dispose();
    horizontalScrollController.dispose();
    verticalScrollController.dispose();
    nameController.dispose();
    emailController.dispose();
    positionController.dispose();
    addressController.dispose();
    phoneController.dispose();
    idCardController.dispose();
    joinDateController.dispose();
    departmentController.dispose();
    fingerprintidController.dispose();
    RoleUserTextController.dispose();

    super.onClose();
  }

  EmployeeProfileModel? get userProfile => _userprofiles.value;

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null || user.email == null) {
        Get.snackbar('Error', 'User not logged in!');
        return;
      }

      final profile = await _employeeProfilesql.getEmployeeProfile();

      _userprofiles.value = profile;

      if (profile != null) {
        mapDataFields(profile);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSuggestionsProfile(String query) async {
    suggestionList.value = await _employeeProfilesql
        .fetchUsernameSuggestionsEmployeeProfile(query);
  }

  Future<void> fetchbyusersemployeeProfile(String name) async {
    isLoading.value = true;
    clearDataFields();

    try {
      final data = await _employeeProfilesql.fetchUserByEmployeeProfile(name);
      if (data != null) {
        mapDataFields(data);
      } else {
        Get.snackbar('Error', 'User Not Found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserInfo() async {
    try {
      isLoading.value = true;

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not logged in!');
        return;
      }

      final updates = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'address': addressController.text.trim(),
        // 'fingerprint_id':
        // fingerprintidController.text.trim().isEmpty
        //     ? null
        //     : fingerprintidController.text.trim(),
        'position': positionController.text.trim(),
        'phone': phoneController.text.trim(),
        'id_card': idCardController.text.trim(),
        'department': departmentController.text.trim(),
        'role': RoleUserTextController.text.trim(),
        'created_at': joinDateController.text.trim(),
        'photo_url':
        profileImageUrl.value.isEmpty ? null : profileImageUrl.value,
      };

      updates.removeWhere((key, value) => value == null || (value.isEmpty));

      print("DEBUG: update payload -> $updates");

      final userId = user.id;

      await _employeeProfilesql.updateUserInfo(userId, updates);

      Get.snackbar('Success', 'Profile updated!');
      isEnabled.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Update failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickerImageProfile() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageFile = XFile(pickedFile.path);
      Get.dialog(
        AlertDialog(
          title: const Text('Upload Image'),
          content: FutureBuilder<List<int>?>(
            future: imageFile!.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('Error loading image');
              }
              if (snapshot.hasData && snapshot.data != null) {
                return Image.memory(
                  Uint8List.fromList(snapshot.data!),
                  fit: BoxFit.contain,
                );
              }
              return Image.asset('assets/images/profileuser.png'); // Fallback
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  final imageUrl = await _employeeProfilesql.uploadImage(
                    imageFile!,
                  );
                  profileImageUrl.value = imageUrl;
                  imageFile = null;
                  Get.back();
                } catch (e) {
                  Get.snackbar('Error', 'Failed to upload image: $e');
                }
              },
              child: const Text('Upload'),
            ),
            TextButton(
              onPressed: () {
                imageFile = null;
                Get.back();
              },
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
    joinDateController.clear();
    RoleUserTextController.clear();

    nameText.value = '';
    emailText.value = '';
    positionText.value = '';
    phoneText.value = '';
    idCardText.value = '';
    departmentText.value = '';
    addressText.value = '';
    roleText.value = '';
    joinDateText.value = '';
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
    joinDateController.text = data.join_date ?? '';
    // fingerprintidController.text = data.fingerprint_id?.toString() ?? '';
    RoleUserTextController.text = data.Role ?? '';
    profileImageUrl.value = data.photo_url ?? '';


    nameText.value = data.name ?? '';
    emailText.value = data.email ?? '';
    positionText.value = data.position ?? '';
    addressText.value = data.address ?? '';
    phoneText.value = data.phone ?? '';
    idCardText.value = data.id_card ?? '';
    departmentText.value = data.department ?? '';
    joinDateText.value = data.join_date ?? '';
    roleText.value = data.Role ?? '';
  }

  void refreshData() => loadUserProfile();
}
