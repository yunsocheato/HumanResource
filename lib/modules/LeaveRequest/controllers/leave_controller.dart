  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:intl/intl.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';
  import '../API/leave_stream_rpc_sql.dart';
  import '../views/leave_request_screen.dart';

  class LeaveController extends GetxController {
    var isLoading = false.obs;
    var leaveRequests = <Map<String, dynamic>>[].obs;
    var selectedLeaveRequest = LeaveRequest().obs;
    var selectedDate =  Rxn<DateTime>();
    var selectedEndDate =  Rxn<DateTime>();
    var selectedStatus = ''.obs;
    var selectedDepartment = ''.obs;
    var selectedPosition = ''.obs;

    @override
    void onInit() {
      super.onInit();
      fetchLeaveRequests();
    }

    Future<void> fetchLeaveRequests() async {
      try {
        isLoading.value = true;
        final data = await getPendingLeaveRequests();
        leaveRequests.value = data;
      } finally {
        isLoading.value = false;
      }
    }

    void showLeaveDialog(Map<String, dynamic> request) {
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
                      colors: [Colors.red.shade900, Colors.red.shade300],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Text(
                    'Leave Request Details',
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
                        DetailRow('Employee', request['name'] ?? 'No name'),
                        DetailRow('Email', request['user_email'] ?? 'No email'),
                        DetailRow('Department', request['department'] ?? 'No Department'),
                        DetailRow('Position', request['position'] ?? 'None'),
                        DetailRow('Start Date', request['from_date'] != null ? DateFormat('MMM d, yyyy').format(DateTime.parse(request['from_date'])) : 'No date',),
                        DetailRow('End Date', request['to_date'] != null ? DateFormat('MMM d, yyyy').format(DateTime.parse(request['to_date'])) : 'No date',
                        ),
                        DetailRow('Reason', request['reason'] ?? 'None'),
                        DetailRow(
                          'Created At',
                          request['created_at'] != null
                              ? DateFormat('MMM d, yyyy HH:mm').format(DateTime.parse(request['created_at']))
                              : 'No date',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child:  Text('Close'),
            ),
          ],
        ),
      );
    }

    static DetailRow(String label, String value){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(value),
            ),
          ],
        ),
      );

    }

    void setStartDate(DateTime? date) {
      selectedDate.value = date!;
    }

    void setEndDate(DateTime? date) {
      selectedEndDate.value = date!;
    }

    List<Map<String, dynamic>> get filteredRequests {
      var list = leaveRequests.toList();

      if (selectedDate.value != null) {
        list = list.where((request) {
          final fromDate = request['from_date'] != null ? DateTime.parse(request['from_date']) : null;
          return fromDate != null && !fromDate.isBefore(selectedDate.value!);
        }).toList();
      }

      if (selectedEndDate.value != null) {
        list = list.where((request) {
          final toDate = request['to_date'] != null ? DateTime.parse(request['to_date']) : null;
          return toDate != null && !toDate.isAfter(selectedEndDate.value!);
        }).toList();
      }

      return list;
    }

    Future<void> updateStatus(String requestId, String newStatus) async {
      try {
        isLoading.value = true;
        final supabase = Supabase.instance.client;
        final adminId = supabase.auth.currentUser?.id;
        if (adminId == null) throw 'No admin user';

        final success = await updateLeaveRequestStatus(
          requestId: requestId,
          newStatus: newStatus,
          adminId: adminId,
        );

        if (success) {
          int index = leaveRequests.indexWhere((r) => r['request_id'] == requestId);
          if (index != -1) {
            leaveRequests[index]['status'] = newStatus;
            leaveRequests.refresh();
          }
        }
      } finally {
        isLoading.value = false;
      }
    }
  }