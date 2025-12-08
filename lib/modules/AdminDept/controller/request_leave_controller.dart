import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../Utils/SnackBar/snack_bar.dart';
import '../../Admin/LeaveRequest/Model/apply_leave_model.dart';
import '../Model/request_leave_model.dart';
import '../Provider/request_leave_provider.dart';

class RequestLeaveScreenController extends GetxController {
  final RequestLeaveProvider _employeeLeave = RequestLeaveProvider();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var RequestLeaveModels = <RequestLeaveModel>[].obs;
  var userProfile = Rxn<ApplyLeaveModel>();

  RxBool isLoading = false.obs;
  RxBool isEnabled = false.obs;

  RxString profileImageUrl = ''.obs;
  XFile? imageFile;
  Rxn<Map<String, dynamic>> selectedSubmit = Rxn<Map<String, dynamic>>();
  var currentUser = Rxn<User>();

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

  final nameText = ''.obs;
  final emailText = ''.obs;
  final positionText = ''.obs;
  final addressText = ''.obs;
  final phoneText = ''.obs;
  final idCardText = ''.obs;
  final departmentText = ''.obs;
  final fingerprintidText = ''.obs;
  final roleText = ''.obs;
  final joinDateText = ''.obs;
  final reasonText = ''.obs;
  final startDateText = ''.obs;
  final endDateText = ''.obs;
  final requestNumberText = ''.obs;
  final requestDateText = ''.obs;
  final locationText = ''.obs;

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
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        loadUserProfile();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        clearUserProfile();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      loadUserProfile();
    }
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null || user.email == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Cannot Laod Profile',
            'Please Try again Later',
            ContentType.failure,
          );
        });
        return;
      }

      final profile = await _employeeLeave.getEmployeeProfile();
      userProfile.value = profile;

      if (profile != null) {
        nameController.text = profile.name ?? '';
        emailController.text = profile.email ?? '';
        positionController.text = profile.position ?? '';
        addressController.text = profile.address ?? '';
        phoneController.text = profile.phone ?? '';
        idCardController.text = profile.id_card ?? '';
        departmentController.text = profile.department ?? '';
        roleController.text = profile.Role ?? '';
        profileImageUrl.value = profile.photo_url ?? '';
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Failed',
          'Failed to Load Profile $e',
          ContentType.help,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitLeave() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    if (!(formKey.currentState?.validate() ?? false)) return;
    if (selectedSubmit.value == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Try again',
          'Please Select the Reviewer first',
          ContentType.help,
        );
      });
      return;
    }

    isLoading.value = true;

    try {
      await Supabase.instance.client
          .from('leave_requests')
          .insert({
            'photo_url': userProfile.value!.photo_url,
            'user_id': user.id,
            'name': nameController.text,
            'department': departmentController.text,
            'reason': reasonController.text,
            'id_card': idCardController.text,
            'position': positionController.text,
            'location': locationController.text,
            'request_number': requestNumberController.text,
            'request_date': DateTime.now().toIso8601String(),
            'request_type': selectedRequestType.value,
            'start_date':
                DateTime.parse(startDateController.text).toIso8601String(),
            'end_date':
                DateTime.parse(endDateController.text).toIso8601String(),
            'status': 'pending',
            'current_stage': selectedSubmit.value!['name'],
            'reviewed_by': selectedSubmit.value!['user_id'],
            'action_by_role': selectedSubmit.value!['role'],
            'leave_count': int.tryParse(leaveCountController.text) ?? 0,
          })
          .select()
          .single();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Successfully',
          'Your Leave Request has been submitted to ${selectedSubmit.value!['name']}',
          ContentType.success,
        );
      });
      clearDataFields();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'ERROR',
          'Failed to Submit $e',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectedSubmits() async {
    try {
      final response = await Supabase.instance.client
          .from('signupuser')
          .select('user_id, name , role , photo_url')
          .or('role.eq.admin,role.eq.admindept');
      if (response.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Reviewer Failed',
            'No available reviewers',
            ContentType.help,
          );
        });
        return;
      }

      final reviewer = await Get.dialog<Map<String, dynamic>>(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: Get.width > 900 ? Get.width * 0.25 : 15,
            vertical: 20,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
              maxHeight: Get.height * 0.5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade700],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Selected Approver",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      final user = response[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              user['photo_url'] != null
                                  ? NetworkImage(user['photo_url'])
                                  : null,
                          child:
                              user['photo_url'] == null
                                  ? const Icon(Icons.person)
                                  : null,
                        ),
                        title: Text(user['name']),
                        subtitle: Text(user['role']),
                        onTap: () {
                          selectedSubmit.value = {
                            'user_id': user['user_id'],
                            'name': user['name'],
                            'role': user['role'],
                          };
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      if (reviewer != null) {
        selectedSubmit.value = reviewer;
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'FAILED',
          'Cannot Load User For Reviewer',
          ContentType.failure,
        );
      });
    }
  }

  void clearUserProfile() {
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
    profileImageUrl.value = '';
    userProfile.value = null;
  }

  void clearDataFields() {
    phoneController.clear();
    addressController.clear();
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
