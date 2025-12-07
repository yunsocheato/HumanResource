import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Dashboard/controllers/dashboard_recently_screen_controller.dart';
import '../views/employee_screen.dart';

class EmployeeTalbeController extends GetxController {
  final controller = Get.find<RecentlyControllerScreen>();

  var isLoading = false.obs;
  var employees = <Map<String, dynamic>>[].obs;
  var selectedEmployee = EmployeeScreen().obs;
  var selectedDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedStatus = ''.obs;
  var selectedDepartment = ''.obs;
  var selectedPosition = ''.obs;

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
                    colors: [
                      Colors.green.shade900,
                      Colors.greenAccent.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: const Text(
                  'Staff Detail',
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
                      detailRow('Email', request['email'] ?? 'No email'),
                      detailRow('Name', request['name'] ?? 'No name'),
                      detailRow(
                        'Department',
                        request['department'] ?? 'No Department',
                      ),
                      detailRow('Position', request['position'] ?? 'None'),
                      detailRow('ID', request['id_card'] ?? 'No ID'),
                      detailRow(
                        'Join Date',
                        request['to_date'] != null
                            ? DateFormat(
                              'MMM d, yyyy',
                            ).format(DateTime.parse(request['to_date']))
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
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
