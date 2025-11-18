import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:hrms/modules/Admin/Drawer/API/manage_user_sql.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/employee_policy_model.dart';

class ManageUsersController extends GetxController {
  final ManageUserSQL _services = ManageUserSQL();
  final _supabase = Supabase.instance.client;

  final NameController = TextEditingController();
  final UserIDController = TextEditingController();
  final Managebyname = TextEditingController();
  final headname = TextEditingController();
  final headposition = TextEditingController();

  final Color color = Colors.deepOrange;

  var suggestionList1 = <String>[].obs;
  var suggestionList2 = <String>[].obs;
  var suggestionList3 = <String>[].obs;
  var suggestionList4 = <String>[].obs;

  var Username1 = ''.obs;
  var Username2 = ''.obs;
  var Username3 = ''.obs;
  var Username4 = ''.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    debounce(
      Username1,
      (value) => fetchSuggestions(1, value),
      time: const Duration(milliseconds: 200),
    );
    debounce(
      Username2,
      (value) => fetchSuggestions(2, value),
      time: const Duration(milliseconds: 200),
    );
    debounce(
      Username3,
      (value) => fetchSuggestions(3, value),
      time: const Duration(milliseconds: 200),
    );
    debounce(
      Username4,
      (value) => fetchSuggestions(4, value),
      time: const Duration(milliseconds: 200),
    );
  }

  Future<void> fetchSuggestions(int fieldIndex, String query) async {
    if (query.isEmpty) return;

    final results = await _services.fetchUsernameSuggestionsManageuser(query);

    switch (fieldIndex) {
      case 1:
        suggestionList1.value = results;
        break;
      case 2:
        suggestionList2.value = results;
        break;
      case 3:
        suggestionList3.value = results;
        break;
      case 4:
        suggestionList4.value = results;
        break;
    }
  }

  Future<void> fetchbyusersemployee(String name, {int? fieldIndex}) async {
    if (name.isEmpty) return;
    isLoading.value = true;

    try {
      final data = await _services.fetchUserByManageuser(name);

      if (data != null) {
        mapDataFields(data, fieldIndex);
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
          'FAILED !!',
          'Failed! Data User Not Load $e',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createManageUser() async {
    isLoading.value = true;
    try {
      final userID = UserIDController.text.trim();
      final name = NameController.text.trim();
      final manageby = Managebyname.text.trim();
      final headnames = headname.text.trim();
      final headpositions = headposition.text.trim();

      if (name.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            'Error !!',
            'Name Cannot Empty',
            ContentType.failure,
          );
        });

        return;
      }

      await _supabase.from('manage_user').insert({
        'user_id': userID,
        'name': name,
        'mangebyname': manageby,
        'headname': headnames,
        'headposition': headpositions,
        'created_at': DateTime.now().toIso8601String(),
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'SUCCESSFULLY',
          'The user is Create Success',
          ContentType.success,
        );
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx("Error", e.toString(), ContentType.failure);
      });
    } finally {
      isLoading.value = false;
    }
  }

  void clearDataFields() {
    Username1.value = '';
    Username2.value = '';
    Username3.value = '';
    Username4.value = '';

    NameController.clear();
    Managebyname.clear();
    headname.clear();
    headposition.clear();
    UserIDController.clear();

    suggestionList1.clear();
    suggestionList2.clear();
    suggestionList3.clear();
    suggestionList4.clear();
  }

  void mapDataFields(employeepolicymodel data, int? fieldIndex) {
    final name = data.name ?? '';

    switch (fieldIndex) {
      case 1:
        Username1.value = name;
        NameController.text = name;
        UserIDController.text = data.userId ?? '';
        break;
      case 2:
        Username2.value = name;
        Managebyname.text = name;
        break;
      case 3:
        Username3.value = name;
        headname.text = name;
        break;
      case 4:
        Username4.value = name;
        headposition.text = name;
        break;
      default:
        NameController.text = name;
        break;
    }
  }
}
