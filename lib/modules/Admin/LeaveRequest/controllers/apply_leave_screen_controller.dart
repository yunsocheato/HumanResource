import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../API/leave_screen_sql.dart';
import '../Model/apply_leave_model.dart';

class ApplyLeaveScreenController extends GetxController {
  final LeaveSql _employeeLeave = LeaveSql();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rxn<ApplyLeaveModel> userprofiles = Rxn<ApplyLeaveModel>();
  var userProfile = Rxn<ApplyLeaveModel>();
  final RxBool isSelectingSuggestion = false.obs;
  Rxn<Map<String, dynamic>> selectedSubmit = Rxn<Map<String, dynamic>>();

  final profileHCtrl = ScrollController();

  RxBool isLoading = true.obs;
  RxBool isEnabled = false.obs;

  final IconData icon = Icons.search;
  final Color color = Colors.green.shade900;
  final RxString Username = ''.obs;
  final isNotEmpty = false.obs;
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
  var fingerprintidText = ''.obs;
  var RoleUserText = ''.obs;

  var requestNumberText = ''.obs;
  var requestDateText = ''.obs;
  var locationText = ''.obs;
  var reasonText = ''.obs;
  var startDateText = ''.obs;
  var endDateText = ''.obs;
  var leaveCountText = ''.obs;
  final usernameSearchController = TextEditingController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final positionController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final idCardController = TextEditingController();
  final departmentController = TextEditingController();
  final fingerprintidController = TextEditingController();
  final RoleUserTextController = TextEditingController();
  final joinDateController = TextEditingController();

  final requestNumberController = TextEditingController();
  final requestDateController = TextEditingController();
  final locationController = TextEditingController();
  var selectedRequestType = ''.obs;
  final reasonController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final leaveCountController = TextEditingController();

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
    fingerprintidController.addListener(
      () => fingerprintidText.value = fingerprintidController.text,
    );
    departmentController.addListener(
      () => departmentText.value = departmentController.text,
    );
    RoleUserTextController.addListener(
      () => roleText.value = RoleUserTextController.text,
    );

    reasonController.addListener(
      () => reasonText.value = reasonController.text,
    );
    startDateController.addListener(
      () => startDateText.value = startDateController.text,
    );
    endDateController.addListener(
      () => endDateText.value = endDateController.text,
    );
  }

  @override
  void onClose() {
    usernameSearchController.dispose();
    nameController.dispose();
    emailController.dispose();
    positionController.dispose();
    addressController.dispose();
    phoneController.dispose();
    idCardController.dispose();
    departmentController.dispose();
    fingerprintidController.dispose();
    RoleUserTextController.dispose();
    joinDateController.dispose();
    requestNumberController.dispose();
    requestDateController.dispose();
    locationController.dispose();
    reasonController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    leaveCountController.dispose();
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    profileHCtrl.dispose();
    super.onClose();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null || user.email == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Required',
            'Please Login User Account',
            ContentType.help,
          );
        });
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
        // joinDateController.text = profile.join_date ?? '';
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Failed',
          'Failed to Load Profile $e',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchSuggestionsLeave(String query) async {
  //   suggestionList.value = await _employeeLeave.fetchUsernameSuggestionsLeave(
  //     query,
  //   );
  //   suggestionList.refresh();
  // }

  // Future<void> submitLeave() async {
  //   final user = Supabase.instance.client.auth.currentUser;
  //   if (user == null) return;

  //   if (!(formKey.currentState?.validate() ?? false)) return;

  //   final profile = userProfile.value;
  //   final submit = selectedSubmit.value;

  //   if (profile == null) {
  //     showAwesomeSnackBarGetx(
  //       'Try again',
  //       'Please load user profile first',
  //       ContentType.help,
  //     );
  //     return;
  //   }

  //   if (submit == null) {
  //     showAwesomeSnackBarGetx(
  //       'Try again',
  //       'Please Select the Reviewer first',
  //       ContentType.help,
  //     );
  //     return;
  //   }
  //   final reviewerName = submit['name'] ?? '';
  //   final reviewerId = submit['user_id'] ?? '';
  //   final reviewerRole = submit['role'] ?? '';

  //   if (reviewerName.isEmpty || reviewerId.isEmpty || reviewerRole.isEmpty) {
  //     showAwesomeSnackBarGetx(
  //       'Error',
  //       'Reviewer information is incomplete',
  //       ContentType.failure,
  //     );
  //     return;
  //   }

  //   isLoading.value = true;

  //   try {
  //     await Supabase.instance.client
  //         .from('leave_requests')
  //         .insert({
  //           'photo_url': profile.photo_url ?? '',
  //           'user_id': user.id,
  //           'name': nameController.text,
  //           'department': departmentController.text,
  //           'reason': reasonController.text,
  //           'id_card': idCardController.text,
  //           'position': positionController.text,
  //           'location': locationController.text,
  //           'request_number': requestNumberController.text,
  //           'request_date': DateTime.now().toIso8601String(),
  //           'request_type': selectedRequestType.value,
  //           'start_date':
  //               DateTime.parse(startDateController.text).toIso8601String(),
  //           'end_date':
  //               DateTime.parse(endDateController.text).toIso8601String(),
  //           'status': 'pending',
  //           'current_stage': reviewerName,
  //           'reviewed_by': reviewerId,
  //           'action_by_role': reviewerRole,
  //           'leave_count': int.tryParse(leaveCountController.text) ?? 0,
  //         })
  //         .select()
  //         .single();
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       showAwesomeSnackBarGetx(
  //         'Submitted to $reviewerName',
  //         'You are create\nleave rquest for  ${nameController.text}\nSuccessfully',
  //         ContentType.success,
  //       );
  //     });
  //     clearDataFields();
  //   } catch (e) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       showAwesomeSnackBarGetx(
  //         'ERROR',
  //         'Failed to Submit $e',
  //         ContentType.failure,
  //       );
  //     });
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> submitLeave() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    if (!(formKey.currentState?.validate() ?? false)) return;

    final profile = userProfile.value;
    final submit = selectedSubmit.value;

    if (profile == null) {
      showAwesomeSnackBarGetx(
        'Error',
        'User profile not loaded',
        ContentType.help,
      );
      return;
    }

    if (submit == null) {
      showAwesomeSnackBarGetx(
        'Error',
        'Please select a reviewer',
        ContentType.help,
      );
      return;
    }

    final reviewerName = submit['name'] ?? '';
    final reviewerId = submit['user_id'] ?? '';
    final reviewerRole = submit['role'] ?? '';

    if (reviewerName.isEmpty || reviewerId.isEmpty || reviewerRole.isEmpty) {
      showAwesomeSnackBarGetx(
        'Error',
        'Reviewer data is incomplete',
        ContentType.failure,
      );
      return;
    }

    isLoading.value = true;

    try {
      await Supabase.instance.client
          .from('leave_requests')
          .insert({
            'photo_url': profile.photo_url ?? '',
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
                DateTime.tryParse(
                  startDateController.text,
                )?.toIso8601String() ??
                '',
            'end_date':
                DateTime.tryParse(endDateController.text)?.toIso8601String() ??
                '',
            'status': 'pending',
            'current_stage': reviewerName,
            'reviewed_by': reviewerId,
            'action_by_role': reviewerRole,
            'leave_count': int.tryParse(leaveCountController.text) ?? 0,
          })
          .select()
          .single();

      showAwesomeSnackBarGetx(
        'Submitted to $reviewerName',
        'Leave request created for ${nameController.text} successfully',
        ContentType.success,
      );

      clearDataFields();
    } catch (e) {
      showAwesomeSnackBarGetx(
        'ERROR',
        'Failed to Submit: $e',
        ContentType.failure,
      );
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

  Future<void> fetchSuggestionsLeave(String query) async {
    if (query.isEmpty) {
      suggestionList.clear();
      return;
    }

    final list = await _employeeLeave.fetchUsernameSuggestionsLeave(query);
    suggestionList.assignAll(list);
  }

  Future<void> fetchbyusersLeave(String name) async {
    isLoading.value = true;
    clearDataFields();

    try {
      final data = await _employeeLeave.fetchUserByLeave(name);
      if (data != null) {
        userProfile.value = data;
        mapDataFields(data);
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
          'Failed',
          'Failed to Load Profile $e',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  void mapDataFields(ApplyLeaveModel data) {
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

    selectedRequestType.value = '';
    requestNumberController.clear();
    requestDateController.clear();
    locationController.clear();
    reasonController.clear();
    startDateController.clear();
    endDateController.clear();
    leaveCountController.clear();
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
    RoleUserTextController.clear();
    joinDateController.clear();

    selectedRequestType.value = '';
    requestNumberController.clear();
    requestDateController.clear();
    locationController.clear();
    reasonController.clear();
    startDateController.clear();
    endDateController.clear();
    leaveCountController.clear();
  }

  void refreshdata() {
    loadUserProfile();
    fetchSuggestionsLeave('');
  }

  void toggleEnable() => isEnabled.value = !isEnabled.value;
}
