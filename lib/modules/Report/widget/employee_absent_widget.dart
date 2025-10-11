import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../controller/employee_report_controller3.dart';

class EmployeeAbsentWidget extends GetView<EmployeeReportController3> {
  const EmployeeAbsentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveContent();
  }

  Widget _buildResponsiveContent() {
    final context = Get.context;
    final isMobile = MediaQuery.of(context!).size.width < 600;
    return isMobile ? _buildEmployeeAbsentMobile() : _buildEmployeeAbsentOther();
  }

  Widget _buildEmployeeAbsentMobile() {
    final controller = Get.find<EmployeeReportController3>();
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: LoadingScreen());
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.data.length,
        itemBuilder: (context, index) {
          final record = controller.data[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'StaffID: ${record.staff_id.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('Username: ${record.staff_name ?? '-'}'),
                      const SizedBox(height: 5),
                      Text('Position: ${record.position.toString()}'),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text('Department: ${record.department ?? '-'}'),
                          const SizedBox(width: 5),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text('Reason: ${record.reason ?? '-'}'),
                          Text('Absent date ${controller.formatDateTime(record.absent_date)}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildEmployeeAbsentOther() {
    final controller = Get.find<EmployeeReportController3>();
    final HoverMouseController controller1 = Get.put(HoverMouseController());

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: LoadingScreen());
      }
      if (controller.Imageasset.isEmpty) {
        return Center(
          child: Image.asset(
            controller.Imageasset.value,
            height: 150,
            width: 150,
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.data.length,
        itemBuilder: (context, index) {
          final record = controller.data[index];
          return MouseHover(
            keyId: 13,
            controller: controller1,
            child: Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade900,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Staff_ID: ${record.staff_id ?? '-'}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text('Username: ${record.staff_name ?? '-'}'),
                        const SizedBox(height: 5),
                        Text('Position: ${record.position ?? '-'}'),
                        const SizedBox(height: 5),
                        Text('Department: ${record.department ?? '-'}'),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text('AbsentDate: ${record.absent_date ?? '-'}'),
                            const SizedBox(width: 5),
                            Text(' Reason ${record.reason ?? '-'}'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text('Created At: ${record.created_at ?? '-'}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
