import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/API/employee_policy_sql.dart';
import 'package:hrms/modules/Drawer/Model/employee_policy_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class EmployeePolicyController extends GetxController{
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

  Future<void>fetchSuggestions(String Query) async {
    suggestionList.value = await _sql.fetchUsernameSuggestionsEmployee(Query);
  }

  Future<void>fetchbyusersemployee(String name ) async {
    isLoading.value = true ;
    try{
      var data = await _sql.fetchUserByEmployee(name);
      if(data != null){
        mapDataFields(data);
      }else {
        Get.snackbar('Error', 'User Not Found');
        clearDataFields();

      }
    }catch (e){
      Get.snackbar("Error", "Failed to load user: $e");
    }finally{
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
        Get.snackbar('Error', 'Invalid or missing user ID or Name');
        return;
      }

      Get.snackbar(
        'Success',
        'Access Feature Policy for ${NameController.text} has been saved successfully.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withOpacity(0.3),
        colorText: Colors.black,
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to insert data: $e");
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
    Username.value = data.name ?? '';
    UserIDController.text = data.userId ?? " ";
    NameController.text = data.name  ?? " " ;
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