import 'package:flutter/material.dart';

DateTime? startDate;
DateTime? endDate;
String _selectedValue = 'PDF';
String searchText = '';
List<Map<String, dynamic>> filteredData = [];
List<Map<String, dynamic>> allData = [];

Future<void> selectDate(BuildContext context, bool isStart) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    setState(() {
      if (isStart) {
        startDate = picked;
      } else {
        endDate = picked;
      }
    });
    applyFilter();
  }
}

void setState(Null Function() param0) {}
void applyFilter() {
  setState(() {
    filteredData =
        allData.where((item) {
          final username = item['username'].toString().toLowerCase();
          final checkType = item['check_type'].toString().toLowerCase();
          final clockIn = DateTime.parse(item['clockin']);

          final matchDate =
              (startDate == null || !clockIn.isBefore(startDate!)) &&
              (endDate == null || !clockIn.isAfter(endDate!));

          final matchSearch =
              searchText.isEmpty ||
              (_selectedValue == 'Username' &&
                  username.contains(searchText.toLowerCase())) ||
              (_selectedValue == 'Check Type' &&
                  checkType.contains(searchText.toLowerCase())) ||
              (_selectedValue == 'Clock IN' &&
                  item['clockin'].contains(searchText));

          return matchDate && matchSearch;
        }).toList();
  });
}
