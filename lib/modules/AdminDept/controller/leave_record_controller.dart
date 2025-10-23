import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/leave_record_model.dart';
import 'package:intl/intl.dart';

import '../Provider/leave_provider.dart';

class LeaveRecordController extends GetxController {
  final leaveprovider service = leaveprovider();

  var leaves = <LeaveRequestModel>[].obs;
  var isLoading = false.obs;
  var leaveRecord = <Map<String, dynamic>>[].obs;

  var selectedDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    getLeaves();
  }

  Future<void> getLeaves() async {
    try {
      isLoading.value = true;
      final data = await service.getleavebyuser();

      leaves.value = data.map((e) => LeaveRequestModel.fromMap(e)).toList();
    } catch (e) {
      leaves.clear();
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
                      DetailRow('Name', request['name'] ?? 'No name'),
                      DetailRow('Email', request['user_email'] ?? 'No email'),
                      DetailRow(
                        'Department',
                        request['department'] ?? 'No Department',
                      ),
                      DetailRow('Position', request['position'] ?? 'None'),
                      DetailRow(
                        'Start Date',
                        request['from_date'] != null
                            ? DateFormat(
                              'MMM d, yyyy',
                            ).format(DateTime.parse(request['from_date']))
                            : 'No date',
                      ),
                      DetailRow(
                        'End Date',
                        request['to_date'] != null
                            ? DateFormat(
                              'MMM d, yyyy',
                            ).format(DateTime.parse(request['to_date']))
                            : 'No date',
                      ),
                      DetailRow('Reason', request['reason'] ?? 'None'),
                      DetailRow(
                        'Created At',
                        request['created_at'] != null
                            ? DateFormat(
                              'MMM d, yyyy HH:mm',
                            ).format(DateTime.parse(request['created_at']))
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

  void setStartDate(DateTime? date) {
    selectedDate.value = date!;
  }

  void setEndDate(DateTime? date) {
    selectedEndDate.value = date!;
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
