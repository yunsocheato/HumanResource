import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/LeaveRequest/API/leave_screen_sql.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/apply_leave_model.dart';

class ApplyLeaveScreenController extends GetxController{

  final LeaveSql _employeeLeave = LeaveSql();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rxn<ApplyLeaveModel> userprofiles = Rxn<ApplyLeaveModel>();

  RxList<ApplyLeaveModel> users = <ApplyLeaveModel>[].obs;

  ApplyLeaveModel? get userProfile => userprofiles.value;

  final profileHCtrl = ScrollController();

  RxBool isLoading = true.obs;
  RxBool isEnabled = false.obs;

  final IconData icon = Icons.search;
  final Color color = Colors.green.shade900;
  final RxString Username = ''.obs;
  final RxList<String> suggestionList = <String>[].obs;
  RxString profileImageUrl = ''.obs;
  XFile? imageFile;

  var showlogincard1 = true.obs;
  var nameText = ''.obs;
  var emailText = ''.obs;
  var positionText = ''.obs;
  var addressText = ''.obs;
  var phoneText = ''.obs;
  var idCardText = ''.obs;
  var departmentText = ''.obs;
  var roleText = ''.obs;
  var joinDateText = ''.obs;

  var requestNumberText = ''.obs;
  var requestDateText = ''.obs;
  var locationText = ''.obs;
  var reasonText = ''.obs;
  var startDateText = ''.obs;
  var endDateText = ''.obs;
  var leaveCountText = ''.obs;
  var fingerprintidText = ''.obs;
  var RoleUserText = ''.obs;


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final positionController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final idCardController = TextEditingController();
  final departmentController = TextEditingController();
  final fingerprintidController = TextEditingController();
  final RoleUserTextController = TextEditingController();

  final requestNumberController = TextEditingController();
  final requestDateController = TextEditingController();
  final locationController = TextEditingController();
  final selectedRequestType = RxnString();
  // final selectedRequestType = ''.obs;
  final reasonController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final leaveCountController = TextEditingController();

  final joinDateController = TextEditingController();
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();

    debounce(
      Username,
          (value) => fetchSuggestionsLeave(value),
      time: const Duration(milliseconds: 300),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
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

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null || user.email == null) {
        Get.snackbar('Error', 'User not logged in!');
        return;
      }

      final profile = await _employeeLeave.getEmployeeProfile();

      userprofiles.value = profile;

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
        profileImageUrl.value = profile.photo_url ?? '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchSuggestionsLeave(String query) async {
    suggestionList.value =
    await _employeeLeave.fetchUsernameSuggestionsLeave(query);
  }

  Future<void> fetchbyusersLeave(String name) async {
    isLoading.value = true;
    clearDataFields();

    try {
      final data = await _employeeLeave.fetchUserByLeave(name);
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

  void mapDataFields(ApplyLeaveModel data){
    Username.value = data.name ?? '';
    nameController.text = data.name ?? '';
    emailController.text = data.email ?? '';
    positionController.text = data.position ?? '';
    addressController.text = data.address ?? '';
    phoneController.text = data.phone ?? '';
    idCardController.text = data.id_card ?? '';
    departmentController.text = data.department ?? '';
    fingerprintidController.text = data.fingerprint_id?.toString() ?? '';
    RoleUserTextController.text = data.Role ?? '';
    profileImageUrl.value = data.photo_url ?? '';
  }
  void clearDataFields(){
    nameController.clear();
    emailController.clear();
    positionController.clear();
    addressController.clear();
    phoneController.clear();
    idCardController.clear();
    departmentController.clear();
    fingerprintidController.clear();
    RoleUserTextController.clear();

    requestNumberController.clear();
    requestDateController.clear();
    locationController.clear();
    reasonController.clear();
    startDateController.clear();
    endDateController.clear();
    leaveCountController.clear();

  }
  void refreshdata(){
    loadUserProfile();
    fetchSuggestionsLeave('');
  }

  void toggleEnable() => isEnabled.value = !isEnabled.value;
}