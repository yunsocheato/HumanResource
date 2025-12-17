import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Core/user_profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../Utils/SnackBar/snack_bar.dart';
import '../API/employee_profile_sql.dart';
import '../models/employee_profile_model.dart';

class EmployeeProfileController extends GetxController {
  final EmployeeProfilesql _employeeProfilesql = EmployeeProfilesql();
  final Rxn<EmployeeProfileModel> _userprofiles = Rxn<EmployeeProfileModel>();
  final usernameSearchController = TextEditingController();
  final RxString Username = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final RxString otherUserProfileImageUrl = ''.obs;
  final RxBool isLoading = true.obs;
  final RxBool isEnabled = false.obs;
  final RxBool adminEditing = false.obs;
  ScrollController? verticalScrollController;
  var showlogincard1 = true.obs;

  final RxList<String> suggestionList = <String>[].obs;

  XFile? imageFile;

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController joinDateController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController RoleUserTextController = TextEditingController();
  var currentUser = Rxn<User>();
  var loadprofile = <UserProfileModel>[].obs;

  var useridText = ''.obs;
  var nameText = ''.obs;
  var emailText = ''.obs;
  var positionText = ''.obs;
  var addressText = ''.obs;
  var phoneText = ''.obs;
  var idCardText = ''.obs;
  var joinDateText = ''.obs;
  var departmentText = ''.obs;
  var roleText = ''.obs;

  String? selectedUserId;

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
    userIdController.addListener(
      () => useridText.value = userIdController.text,
    );
    nameController.addListener(() => nameText.value = nameController.text);
    emailController.addListener(() => emailText.value = emailController.text);
    positionController.addListener(
      () => positionText.value = positionController.text,
    );
    addressController.addListener(
      () => addressText.value = addressController.text,
    );
    phoneController.addListener(() => phoneText.value = phoneController.text);
    idCardController.addListener(
      () => idCardText.value = idCardController.text,
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
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        loadUserProfile();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        loadprofile.clear();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      loadUserProfile();
    }
  }

  @override
  void onClose() {
    usernameSearchController.dispose();
    userIdController.dispose();
    nameController.dispose();
    emailController.dispose();
    positionController.dispose();
    addressController.dispose();
    phoneController.dispose();
    idCardController.dispose();
    joinDateController.dispose();
    departmentController.dispose();
    RoleUserTextController.dispose();
    super.onClose();
  }

  EmployeeProfileModel? get userProfile => _userprofiles.value;

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      final profile = await _employeeProfilesql.getEmployeeProfile();
      _userprofiles.value = profile;
      if (profile != null) mapDataFields(profile);
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Error',
          'Failed to Upload the Profiles $e',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSuggestionsProfile(String query) async {
    suggestionList.value = await _employeeProfilesql
        .fetchUsernameSuggestionsEmployeeProfile(query);
    suggestionList.refresh();
  }

  Future<void> fetchbyusersemployeeProfile(String name) async {
    isLoading.value = true;
    clearDataFields();

    try {
      final data = await _employeeProfilesql.fetchUserByEmployeeProfile(name);
      if (data != null) {
        mapDataFields(data);

        selectedUserId = data.user_id;
        adminEditing.value = true;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Error',
            'User Not Found',
            ContentType.failure,
          );
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Failed !',
          'Failed To Load User $e',
          ContentType.warning,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleSaveButtonPress() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final supabase = Supabase.instance.client;
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Error',
            'User Cannot Login',
            ContentType.failure,
          );
        });
        return;
      }

      final String targetUserId =
          adminEditing.value && selectedUserId != null
              ? selectedUserId!
              : currentUser.id;

      String imageUrl =
          adminEditing.value && selectedUserId != null
              ? otherUserProfileImageUrl.value
              : profileImageUrl.value;

      if (imageFile != null) {
        final uploadedUrl = await _employeeProfilesql.uploadImage(imageFile!);
        imageUrl = uploadedUrl;

        if (adminEditing.value && selectedUserId != null) {
          otherUserProfileImageUrl.value = uploadedUrl;
        } else {
          profileImageUrl.value = uploadedUrl;
        }
        imageFile = null;
      }

      final updates = {
        'name': nameText.value,
        'email': emailText.value,
        'department': departmentText.value,
        'position': positionText.value,
        'phone': phoneText.value,
        'id_card': idCardText.value,
        'address': addressText.value,
        'created_at':
            joinDateText.value.isNotEmpty
                ? DateTime.tryParse(joinDateText.value)?.toIso8601String()
                : null,
        'role': roleText.value,
        'photo_url': imageUrl,
      };

      updates.removeWhere(
        (key, value) => value == null || (value.trim().isEmpty),
      );

      await _employeeProfilesql.updateUserInfo(
        targetUserId: targetUserId,
        updates: updates,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Success',
          'Profile User Update Sucess',
          ContentType.success,
        );
      });
      isEnabled.value = false;
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Error',
          'Failed! The Profile cannot Update $e',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickerImageProfile() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Oops!!',
          'You are Not Select the Image',
          ContentType.failure,
        );
      });
      return;
    }

    imageFile = pickedFile;

    if (adminEditing.value) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        otherUserProfileImageUrl.value = base64Encode(bytes);
      } else {
        otherUserProfileImageUrl.value = pickedFile.path;
      }
    } else {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        profileImageUrl.value = base64Encode(bytes);
      } else {
        profileImageUrl.value = pickedFile.path;
      }
    }

    isEnabled.value = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx(
        'Yeahh...',
        'You are Selected Image , Please Press Save and Change!',
        ContentType.success,
      );
    });
  }

  void toggleEnable() => isEnabled.value = !isEnabled.value;

  void clearDataFields() {
    userIdController.clear();
    nameController.clear();
    emailController.clear();
    positionController.clear();
    addressController.clear();
    phoneController.clear();
    idCardController.clear();
    departmentController.clear();
    joinDateController.clear();
    RoleUserTextController.clear();

    useridText.value = '';
    nameText.value = '';
    emailText.value = '';
    positionText.value = '';
    addressText.value = '';
    phoneText.value = '';
    idCardText.value = '';
    departmentText.value = '';
    roleText.value = '';
    joinDateText.value = '';
    profileImageUrl.value = '';
  }

  void mapDataFields(EmployeeProfileModel data) {
    userIdController.text = data.user_id ?? '';
    nameController.text = data.name ?? '';
    emailController.text = data.email ?? '';
    positionController.text = data.position ?? '';
    addressController.text = data.address ?? '';
    phoneController.text = data.phone ?? '';
    idCardController.text = data.id_card ?? '';
    departmentController.text = data.department ?? '';
    joinDateController.text = data.join_date ?? '';
    RoleUserTextController.text = data.Role ?? '';
    profileImageUrl.value = data.photo_url ?? '';
    if (adminEditing.value) {
      otherUserProfileImageUrl.value = data.photo_url ?? '';
    }
    useridText.value = data.user_id ?? '';
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
}
