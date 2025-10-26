import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/leave_record_model.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Provider/leave_provider.dart';

class LeaveRecordController extends GetxController {
  final leaveprovider service = leaveprovider();

  var leaves = <LeaveRecordModel>[].obs;
  var isLoading = false.obs;
  var leaveRecord = <Map<String, dynamic>>[].obs;
  var currentUser = Rxn<User>();
  final dateFormat = DateFormat('dd/MM/yyyy');

  var selectedDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        getLeaves();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        leaves.clear();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      getLeaves();
    }
  }

  @override
  void onClose() {
    super.onClose();
    leaves.clear();
  }

  Future<void> getLeaves() async {
    try {
      isLoading.value = true;
      final data = await service.getPendingLeaveRequests();
      print(data);
      leaves.value = data.map((e) => LeaveRecordModel.fromMap(e)).toList();
    } catch (e) {
      leaves.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLeavesByDate(DateTime start, DateTime end) async {
    try {
      isLoading.value = true;
      final userId = Supabase.instance.client.auth.currentUser!.id;
      leaves.value = await service.getLeaveDatabydate(userId, start, end);
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(dynamic date) {
    if (date == null || date.toString().isEmpty || date == 'null') {
      return '-';
    }

    try {
      final parsedDate =
          date is DateTime ? date : DateTime.tryParse(date.toString());

      if (parsedDate == null) return '-';

      return DateFormat('MMM d, yyyy').format(parsedDate);
    } catch (e) {
      return '-';
    }
  }

  void showLeaveDialog(LeaveRecordModel request) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade900, Colors.blue.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Text(
                  'Leave Record',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailRow('Name', request.name),
                      DetailRow('Department', request.department),
                      DetailRow('Position', request.position),
                      DetailRow('Your Status', request.status),
                      DetailRow('You have been Submit to ', request.submitrole),
                      // DetailRow('Your Leave Type', request.leavetype),
                      DetailRow('Your Reason', request.leavereason),
                      DetailRow(
                        'Start Date',
                        request.fromDate != null
                            ? DateFormat(
                              'MMM d, yyyy',
                            ).format(request.fromDate!)
                            : 'No date',
                      ),
                      DetailRow(
                        'End Date',
                        request.toDate != null
                            ? DateFormat('MMM d, yyyy').format(request.toDate!)
                            : 'No date',
                      ),
                      DetailRow('Create At', request.CreatAt),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Close')),
        ],
      ),
    );
  }

  static DetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void setStartDate(DateTime date) {
    selectedDate.value = date;
  }

  void setEndDate(DateTime date) {
    selectedEndDate.value = date;
    if (selectedEndDate.value != null) {
      fetchLeavesByDate(selectedDate.value!, selectedEndDate.value!);
    }
  }

  List<Map<String, dynamic>> get filteredRequests {
    var list = leaveRecord.toList();

    list =
        list.where((request) {
          final fromDate =
              request['from_date'] != null
                  ? DateTime.parse(request['from_date'])
                  : null;
          return fromDate != null && !fromDate.isBefore(selectedDate.value!);
        }).toList();

    list =
        list.where((request) {
          final toDate =
              request['to_date'] != null
                  ? DateTime.parse(request['to_date'])
                  : null;
          return toDate != null && !toDate.isAfter(selectedEndDate.value!);
        }).toList();

    return list;
  }
}
