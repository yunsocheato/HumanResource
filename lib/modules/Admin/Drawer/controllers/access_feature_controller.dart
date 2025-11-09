// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../API/access_feature_sql.dart';
// import '../Model/access_feature_model.dart';
//
// class AccessFeatureController extends GetxController {
//   final AccessFeatureSQL _sql = AccessFeatureSQL();
//
//   var isLoading = false.obs;
//   var suggestionList = <String>[].obs;
//   var user = Rx<AccessFeatureModel?>(null);
//
//   int? selectedIndex;
//   var selectedUser = <String, dynamic>{}.obs;
//   var searchResults = [].obs;
//   var searchText = "".obs;
//
//   var featureSelectionMap = <UserRole, Map<String, RxBool>>{}.obs;
//   var permissionSelectionMap = <UserRole, Map<String, RxBool>>{}.obs;
//   final Rx<UserRole?> selectedRole = Rx<UserRole?>(null);
//
//   final Map<UserRole, List<String>> UserRoleMap = {
//     UserRole.user: ['user'],
//     UserRole.adminDept: ['adminDept'],
//     UserRole.admin: ['admin'],
//   };
//   final Map<UserRole, List<String>> permissionMap = {
//     UserRole.admin: ['Full Access'],
//     UserRole.user: ['Update', 'Read', 'Request'],
//     UserRole.adminDept: ['Read', 'Update', 'Approve', 'Reject'],
//   };
//   final Map<UserRole, List<String>> featureaccessMap = {
//     UserRole.adminDept: [
//       'Dashboard',
//       'Manage Users',
//       'Leave Requests',
//       'Reports',
//       'Settings',
//     ],
//     UserRole.user: ['Dashboard', 'Submit Leave', 'View Attendance'],
//     UserRole.admin: ['Dashboard', 'Employee Records', 'Recruitment', 'Payroll'],
//   };
//
//   final IconData icon = Icons.search;
//   final Color color = Colors.yellow;
//
//   var OwnData = [].obs;
//   var AllData = [].obs;
//   var UserAllData = [].obs;
//
//   var Username = "".obs;
//   RxBool usercannotchange = false.obs;
//   RxBool usercanchange = false.obs;
//
//   var name = "".obs;
//   var Email = "".obs;
//   var Department = "".obs;
//   var Role = "".obs;
//   var feature = "".obs;
//   var policy = "".obs;
//   var create_at = "".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     selectedRole.value = UserRole.user;
//     initializeSelections(UserRole.user);
//     debounce(Username, (value) {
//       fetchSuggestionsAccessFeatures(value);
//     }, time: Duration(milliseconds: 300));
//   }
//
//   void initializeSelections(UserRole role) {
//     final permissions = permissionMap[role] ?? [];
//     final features = featureaccessMap[role] ?? [];
//     permissionSelectionMap[role] = {
//       for (var perm in permissions) perm: false.obs,
//     };
//     featureSelectionMap[role] = {for (var feat in features) feat: false.obs};
//   }
//
//   Future<void> InsertData() async {
//     final role = selectedRole.value;
//     if (role == null) {
//       Get.snackbar("Error", "Please select a role");
//       return;
//     }
//
//     final selectedPermissions =
//         permissionSelectionMap[role]!.entries
//             .where((e) => e.value.value)
//             .map((e) => e.key)
//             .toList();
//
//     final selectedFeatures =
//         featureSelectionMap[role]!.entries
//             .where((e) => e.value.value)
//             .map((e) => e.key)
//             .toList();
//
//     final policyString = selectedPermissions.join(', ');
//     final featureString = selectedFeatures.join(', ');
//
//     final userId = selectedUser.value['user_id'];
//     final email = selectedUser.value['email'];
//     final name = selectedUser.value['name'];
//     final department = selectedUser.value['department'];
//     final userRole = selectedUser.value['role'];
//
//     if (userId == null ||
//         email == null ||
//         name == null ||
//         department == null ||
//         userRole == null) {
//       Get.snackbar("Error", "User data incomplete.");
//       return;
//     }
//
//     if (selectedFeatures.isEmpty || selectedPermissions.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Please select at least one feature and permission.",
//       );
//       return;
//     }
//
//     try {
//       for (var feature in selectedFeatures) {
//         final response = await Supabase.instance.client
//             .from('access_feature')
//             .upsert({
//               'user_id': userId,
//               'name': name,
//               'email': email,
//               'role': userRole,
//               'department': department,
//               'feature': featureString,
//               'policy': policyString,
//               'created_at': DateTime.now().toIso8601String(),
//             });
//         print('Insert response: $response');
//       }
//
//       Get.snackbar(
//         'Success',
//         'Access Feature Policy for $name has been saved successfully.',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.white.withOpacity(0.3),
//         colorText: Colors.black,
//       );
//     } catch (e) {
//       Get.snackbar("Error", "Failed to insert data: $e");
//     }
//   }
//
//   Future<void> fetchSuggestionsAccessFeatures(String Query) async {
//     suggestionList.value = await _sql.fetchUsernameSuggestionsAccessFeature(
//       Query,
//     );
//   }
//
//   Future<void> fetchbyusersAccessFeatures(String name) async {
//     isLoading.value = true;
//     try {
//       var data = await _sql.fetchUserByAccessFeature(name);
//       if (data != null) {
//         mapDataFields(data);
//       } else {
//         Get.snackbar('Error', 'User Not Found');
//         ClearDataFields();
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Failed to load user: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void mapDataFields(AccessFeatureModel data) {
//     Username.value = data.name;
//     selectedUser.value = {
//       'user_id': data.userId,
//       'email': data.email,
//       'name': data.name,
//       'department': data.department,
//       'role': data.role,
//       'feature': data.feature,
//       'policy': data.policy,
//     };
//   }
//
//   void ClearDataFields() {
//     Username.value = '';
//     name.value = '';
//     Email.value = '';
//     Department.value = '';
//     Role.value = '';
//     feature.value = '';
//     policy.value = '';
//     create_at.value = '';
//   }
// }
//
