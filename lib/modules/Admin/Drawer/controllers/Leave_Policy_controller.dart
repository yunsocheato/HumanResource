import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../API/leave_policy_sql.dart';
import '../Model/leave_policy_model.dart';

class LeavePolicyController extends GetxController {
  final LeavePolicySQL _sql = LeavePolicySQL();
  final suggestionList = <String>[].obs;

  final Username = ''.obs;
  final userID = ''.obs;

  final inMinute = 0.0.obs;
  final RxInt monthly = 0.obs;
  final daily = 0.0.obs;

  final blockAnualLeave = false.obs;
  final blockSickLeave = false.obs;
  final blockUnpaidLeave = false.obs;

  final limitLeave = false.obs;
  final notLeaveProbation = false.obs;
  final unpaidLeaveAvailable = false.obs;
  final sickLeaveCertif = false.obs;

  final isDeduction = false.obs;
  final isBlockLeave = false.obs;
  final isAgreement = false.obs;

  final isLoading = false.obs;

  final IconData icon = Icons.search;
  final Color color = Colors.blue.shade900;

  @override
  void onInit() {
    super.onInit();
    fetchSuggestionsLeavePolicy('');
    debounce(Username, (value) {
      fetchSuggestionsLeavePolicy(value);
    }, time: const Duration(milliseconds: 300));
  }

  Future<void> fetchSuggestionsLeavePolicy(String query) async {
    suggestionList.value = await _sql.fetchUsernameSuggestionsLeavePolicy(
      query,
    );
  }

  Future<void> fetchUserByLeavePolicy(String name) async {
    isLoading.value = true;
    try {
      var data = await _sql.fetchUserByLeavePolicy(name);
      if (data != null) {
        userMapDataFields(data);
        Username.value = data.name ?? '';
      } else {
        clearData();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            "Error!!",
            "User not found",
            ContentType.failure,
          );
        });
      }
    } catch (e) {
      clearData();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          "Error!!",
          "Failed to fetch user data: $e",
          ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> InsertData() async {
    try {
      final response =
          await Supabase.instance.client.from('leave_policy').upsert({
            'user_id': userID.value,
            'name': Username.value,
            'monthly_salary': monthly.value,
            'daily_salary': daily.value,
            'minute_salary': inMinute.value,
            'block_anual_leave': blockAnualLeave.value,
            'block_sick_leave': blockSickLeave.value,
            'block_unpaid_leave': blockUnpaidLeave.value,
            'limit_leave': limitLeave.value,
            'notleaveprobation': notLeaveProbation.value,
            'unpaidleaveavailable': unpaidLeaveAvailable.value,
            'sickleavecertificate': sickLeaveCertif.value,
            'deduct_leave': isDeduction.value,
            'agreement': isAgreement.value,
            'block_leave': isBlockLeave.value,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          }).select();

      if (response.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            "Success!!",
            'Leave Policy for ${Username.value} has been saved successfully.',
            ContentType.success,
          );
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          "Error!!",
          'Failed to save leave policy: $e',
          ContentType.failure,
        );
      });
      clearData();
    } finally {
      clearData();
    }
  }

  void clearData() {
    Username.value = '';
    userID.value = '';
    monthly.value = 0;
    daily.value = 0;
    inMinute.value = 0;
    blockAnualLeave.value = false;
    blockSickLeave.value = false;
    blockUnpaidLeave.value = false;
    limitLeave.value = false;
    notLeaveProbation.value = false;
    unpaidLeaveAvailable.value = false;
    sickLeaveCertif.value = false;
    isDeduction.value = false;
    isBlockLeave.value = false;
    isAgreement.value = false;
  }

  void userMapDataFields(LeavePolicyModel data) {
    Username.value = data.name ?? '';
    userID.value = data.userID ?? '';

    monthly.value = data.monthly ?? 0;
    daily.value = data.daily.toDouble();
    inMinute.value = data.inMinute.toDouble();

    blockAnualLeave.value = data.blockAnualLeave ?? false;
    blockSickLeave.value = data.blockSickLeave ?? false;
    blockUnpaidLeave.value = data.blockUnpaidLeave ?? false;

    limitLeave.value = data.limitLeave ?? false;
    notLeaveProbation.value = data.notLeaveProbation ?? false;
    unpaidLeaveAvailable.value = data.unpaidLeaveAvailable ?? false;
    sickLeaveCertif.value = data.sickLeaveCertif ?? false;

    isDeduction.value = data.deductLeave ?? false;
    isBlockLeave.value = data.blockLeave ?? false;
    isAgreement.value = data.agreement ?? false;
  }
}
