import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Admin/LeaveRequest/API/leave_stream_rpc_sql.dart';
import '../Model/request_leave_model.dart';
import '../Provider/request_leave_provider.dart';

class RequestLeaveScreenController extends GetxController {
  final RequestLeaveProvider _employeeLeave = RequestLeaveProvider();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var RequestLeaveModels = <RequestLeaveModel>[].obs;
  var userProfile = Rxn<RequestLeaveModel>();

  RxBool isLoading = false.obs;
  RxBool isEnabled = false.obs;

  RxString profileImageUrl = ''.obs;
  XFile? imageFile;
  Rxn<Map<String, dynamic>> selectedReviewer = Rxn<Map<String, dynamic>>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final positionController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final idCardController = TextEditingController();
  final departmentController = TextEditingController();
  final fingerprintidController = TextEditingController();
  final roleController = TextEditingController();
  final joinDateController = TextEditingController();

  final requestNumberController = TextEditingController();
  final requestDateController = TextEditingController();
  final locationController = TextEditingController();
  final reasonController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final leaveCountController = TextEditingController();
  final selectedRequestType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    fetchLeaveRequests();
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
      if (profile != null) {
        nameController.text = profile.name ?? '';
        emailController.text = profile.email ?? '';
        positionController.text = profile.position ?? '';
        addressController.text = profile.address ?? '';
        phoneController.text = profile.phone ?? '';
        idCardController.text = profile.id_card ?? '';
        departmentController.text = profile.department ?? '';
        fingerprintidController.text = profile.fingerprint_id?.toString() ?? '';
        roleController.text = profile.Role ?? '';
        profileImageUrl.value = profile.photo_url ?? '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLeaveRequests() async {
    try {
      isLoading.value = true;
      final response = await Supabase.instance.client
          .from('leave_requests')
          .select()
          .order('created_at', ascending: false);

      RequestLeaveModels.value =
          (response as List).map((e) => RequestLeaveModel.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch leave requests: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approveLeave(String requestId, String reviewerId, String role) async {
    try {
      await Supabase.instance.client.rpc('approve_leave_request', params: {
        'p_request_id': requestId,
        'p_reviewer': reviewerId,
        'p_role': role,
      });
      fetchLeaveRequests();
    } catch (e) {
      Get.snackbar('Error', 'Cannot approve leave: $e');
    }
  }

  Future<void> rejectLeave(String requestId, String reviewerId, String role) async {
    try {
      await Supabase.instance.client.rpc('reject_leave_request', params: {
        'p_request_id': requestId,
        'p_reviewer': reviewerId,
        'p_role': role,
      });
      fetchLeaveRequests();
    } catch (e) {
      Get.snackbar('Error', 'Cannot reject leave: $e');
    }
  }

  Future<void> submitLeave() async {
    try {
      if (userProfile.value == null) {
        Get.snackbar('Error', 'User profile not loaded');
        return;
      }

      if (!(formKey.currentState?.validate() ?? false)) return;

      if (selectedReviewer.value == null) {
        Get.snackbar('Error', 'Please select a reviewer first');
        return;
      }

      isLoading.value = true;

      final insertResponse = await Supabase.instance.client
          .from('leave_requests')
          .insert({
        'user_id': Supabase.instance.client.auth.currentUser!.id,
        'name': nameController.text,
        'department': departmentController.text,
        'reason': reasonController.text,
        'location': locationController.text,
        'request_type': selectedRequestType.value,
        'start_date': DateTime.parse(startDateController.text).toIso8601String(),
        'end_date': DateTime.parse(endDateController.text).toIso8601String(),
        'status': 'pending',
        'current_stage': 'admindept',
        'reviewed_by': selectedReviewer.value!['id'],
        'action_by_role': selectedReviewer.value!['role'],
        'leave_count': int.tryParse(leaveCountController.text) ?? 0,
      });

      if (insertResponse.error != null) {
        Get.snackbar('Error', 'Failed to submit leave: ${insertResponse.error!.message}');
        return;
      }

      Get.snackbar('Success', 'Leave request submitted to ${selectedReviewer.value!['name']}');
      fetchLeaveRequests();
      clearDataFields();
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit leave: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectReviewer() async {
    final response = await Supabase.instance.client
        .from('signupuser')
        .select('id, name, role');

    if (response.error != null) {
      Get.snackbar('Error', 'Failed to fetch users: ${response.error!.message}');
      return;
    }

    final List users = ((response.data ?? []) as List)
        .where((u) => ['admindept', 'admin',].contains(u['role']))
        .toList();

    if (users.isEmpty) {
      Get.snackbar('Info', 'No users available to assign');
      return;
    }

    final Map<String, dynamic>? reviewer = await Get.dialog<Map<String, dynamic>>(
      AlertDialog(
        title: const Text('Select Reviewer'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user['name'] ?? 'Unknown'),
                subtitle: Text(user['role'] ?? ''),
                onTap: () {
                  Get.back(result: user);
                },
              );
            },
          ),
        ),
      ),
    );

    if (reviewer != null) selectedReviewer.value = reviewer;
  }
  void clearDataFields() {
    nameController.clear();
    emailController.clear();
    positionController.clear();
    addressController.clear();
    phoneController.clear();
    idCardController.clear();
    departmentController.clear();
    fingerprintidController.clear();
    roleController.clear();
    joinDateController.clear();

    requestNumberController.clear();
    requestDateController.clear();
    locationController.clear();
    reasonController.clear();
    startDateController.clear();
    endDateController.clear();
    leaveCountController.clear();
    selectedRequestType.value = '';
  }

  void toggleEnable() => isEnabled.value = !isEnabled.value;
}

extension on PostgrestList {
  get error => null;

  get data => null;
}
