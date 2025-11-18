import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../Utils/SnackBar/snack_bar.dart';
import '../API/OT_SQL.dart';
import '../Model/OT_Model.dart';

class OTPolicyController extends GetxController {
  final OTPolicySql _sql = OTPolicySql();
  var suggestionList = <String>[].obs;

  final StartFrom = DateTime.now();
  final EndDate = DateTime.now().add(Duration(days: 7));

  final isLoading = false.obs;
  final isSwitched1 = false.obs;
  final isSwitched2 = false.obs;
  final isSwitched3 = false.obs;

  final Username = ''.obs;
  final userID = ''.obs;
  final IconData icon = Icons.search;
  final Color color = Colors.orange.shade900;

  final usercannotchange = false.obs;
  final usercanchange = false.obs;

  final ifTechnical = false.obs;
  final ifNonTechnical = false.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(Username, (value) {
      fetchSuggestionsOTPolicy(value);
    }, time: Duration(milliseconds: 300));
  }

  Future<void> fetchUserByOTPolicy(String name) async {
    try {
      isLoading.value = true;
      final user = await OTPolicySql().fetchUserByOTPolicy(name);
      if (user != null) {
        Username.value = user.username ?? '';
        ifTechnical.value = user.ifTechnical ?? false;
        ifNonTechnical.value = user.ifNonTechnical ?? false;
        usercannotchange.value = user.usercannotchange ?? false;
        usercanchange.value = user.usercannotchange ?? false;
        userID.value = user.userID ?? '';
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          'Error !!',
          'Failed to Fetch $e',
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSuggestionsOTPolicy(String query) async {
    suggestionList.value = await _sql.fetchUsernameSuggestionsOTPolicy(query);
  }

  Future<void> InsertData() async {
    try {
      isLoading.value = true;
      final response =
          await Supabase.instance.client.from('ot_policy').insert({
            'user_id': userID.value,
            'name': Username.value,
            'technical': ifTechnical.value,
            'nontechnical': ifNonTechnical.value,
            'usercannotchange': usercannotchange.value,
            'usercanchange': usercanchange.value,
            'created_at': DateTime.now().toIso8601String(),
          }).select();
      if (response.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            "Database!",
            "Data Insert Successful",
            ContentType.success,
          );
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            "Data Error",
            "Failed To Insert Data",
            ContentType.failure,
          );
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          "Database Error!",
          "Failed to Insert Data $e",
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          "Database ",
          "Insert Data Successfully",
          ContentType.success,
        );
      });
    }
  }

  void ClearDataFields() {
    userID.value = '';
    Username.value = '';
    ifTechnical.value = false;
    ifNonTechnical.value = false;
    usercannotchange.value = false;
    usercanchange.value = false;
  }

  void MapDataFields(OTModel data) {
    userID.value = data.userID ?? '';
    Username.value = data.username ?? '';
    ifTechnical.value = data.ifTechnical ?? false;
    ifNonTechnical.value = data.ifNonTechnical ?? false;
    usercannotchange.value = data.usercannotchange ?? false;
    usercanchange.value = !usercannotchange.value;
  }
}
