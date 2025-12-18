import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../API/employee_policy_sql.dart';
import '../Model/employee_policy_model.dart';

class EmployeePolicyController extends GetxController {
  final employeepolicysql _sql = employeepolicysql();
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
  final createAtController = TextEditingController();
  final usernameSearchController = TextEditingController();
  final IconData icon = Icons.search;
  final Color color = Colors.green.shade900;
  final UserId = ''.obs;

  var isLoading = false.obs;
  var suggestionList = <String>[].obs;
  var Username = ''.obs;

  var usercannotchange = false.obs;
  var usercanchange = false.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(Username, (value) {
      fetchSuggestions(value);
    }, time: Duration(milliseconds: 300));
  }

  Future<void> fetchSuggestions(String Query) async {
    suggestionList.value = await _sql.fetchUsernameSuggestionsEmployee(Query);
    suggestionList.refresh();
  }

  Future<void> fetchbyusersemployee(String name) async {
    isLoading.value = true;
    try {
      var data = await _sql.fetchUserByEmployee(name);
      if (data != null) {
        mapDataFields(data);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Try Again !! ',
            'Try to load user: $name',
            ContentType.warning,
          );
        });
        clearDataFields();
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'FAILED !! ',
          'User Cannot Load : $e',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> UpdateChange() async {
    try {
      final response = await Supabase.instance.client
          .from('signupuser')
          .update({
            'user_id': UserIDController.text,
            'name': NameController.text,
            'email': EmailController.text,
            'department': DepartmentController.text,
            'position': poisitionController.text,
            'id_card': id_cardController.text,
            'fingerprints_id': int.tryParse(fingerprint_idController.text) ?? 0,
            'phone': PhoneController.text,
            'role': RoleController.text,
            'created_at': createAtController.text,
          })
          .eq('name', NameController.text);
      if (NameController.text.isEmpty || NameController.text == '*') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Try Again',
            'Invalid or missing user ID or Name',
            ContentType.warning,
          );
        });
        return;
      }
      if (response.error != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Try Again !! ',
            'Try Again to update Access feature policy: ${response.error}',
            ContentType.failure,
          );
        });
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Success',
          'Access Feature Policy for ${NameController.text} has been saved successfully.',
          ContentType.failure,
        );
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'FAILED !! ',
          'Failed to save access feature policy: $e',
          ContentType.failure,
        );
      });
    }
  }

  void clearDataFields() {
    Username.value = '';
    UserIDController.clear();
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

  void mapDataFields(employeepolicymodel data) {
    UserIDController.text = data.userId ?? " ";
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
