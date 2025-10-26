import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Provider/attendance_provider.dart';
import '../Model/attendance_record_model.dart';

class Attendancecontroller extends GetxController {
  final AttendanceProvider service = AttendanceProvider();

  var attendance = <AttendanceRecordModel>[].obs;
  var isLoading = false.obs;
  var currentUser = Rxn<User>();
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        fetchAttendanceForLoggedInUser();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        attendance.clear();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      fetchAttendanceForLoggedInUser();
    }
  }

  void setStartDate(DateTime date) {
    startDate.value = date;
  }

  void setEndDate(DateTime date) {
    endDate.value = date;
    if (startDate.value != null) fetchAttendanceByDateRange();
  }

  Future<void> fetchAttendanceByDateRange() async {
    final user = currentUser.value;
    if (user == null || startDate.value == null || endDate.value == null) {
      attendance.clear();
      return;
    }

    try {
      isLoading.value = true;

      final fingerprintID = await getFingerprintIDForUser(user.id);
      if (fingerprintID == null) {
        attendance.clear();
        return;
      }

      final data = await service.getAttendanceDatabydate(
        fingerprintID,
        startDate.value!,
        endDate.value!,
      );

      attendance.value =
          data.map((e) => AttendanceRecordModel.fromMap(e)).toList();
    } catch (e) {
      attendance.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAttendanceForLoggedInUser() async {
    final user = currentUser.value;
    if (user == null) {
      attendance.clear();
      return;
    }

    try {
      isLoading.value = true;

      final fingerprintID = await getFingerprintIDForUser(user.id);
      if (fingerprintID == null) {
        attendance.clear();
        return;
      }

      final data = await service.getAttendancedata(fingerprintID);

      attendance.value =
          data.map((e) => AttendanceRecordModel.fromMap(e)).toList();
    } catch (e) {
      attendance.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<int?> getFingerprintIDForUser(String userId) async {
    final response =
        await Supabase.instance.client
            .from('signupuser')
            .select('fingerprints_id')
            .eq('user_id', userId)
            .maybeSingle();

    if (response == null) return null;
    return response['fingerprints_id'] as int?;
  }

  String formatDate(dynamic date) {
    if (date == null) return 'No date';
    try {
      final parsedDate =
          date is DateTime ? date : DateTime.tryParse(date.toString());
      if (parsedDate == null) return 'No Date';
      return DateFormat('MMM d, yyyy hh:mm a').format(parsedDate);
    } catch (_) {
      return '-';
    }
  }
}
