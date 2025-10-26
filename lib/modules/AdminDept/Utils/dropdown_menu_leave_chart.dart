import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/leave_chart_controller.dart';

class DropDownMenuLeaveChart extends GetView<LeaveChartController> {
  const DropDownMenuLeaveChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => _buildDropdown<int>(
            label: 'Year',
            value: controller.selectedYear.value,
            items:
                controller.availableYears
                    .map(
                      (year) => DropdownMenuItem<int>(
                        value: year,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.blue.shade700,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              year.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              if (value != null) controller.setYear(value);
            },
          ),
        ),
        const SizedBox(width: 15),
        Obx(
          () => _buildDropdown<String>(
            label: 'Month',
            value: controller.selectedMonth.value,
            items:
                controller.availableMonths
                    .map(
                      (month) => DropdownMenuItem<String>(
                        value: month,
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range_rounded,
                              color: Colors.teal.shade700,
                              size: 22,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              month,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              if (value != null) controller.setMonth(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.blueAccent,
            size: 28,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
