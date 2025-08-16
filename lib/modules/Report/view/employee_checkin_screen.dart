import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../controller/employee_checkin_controller.dart';

class EmployeeScreenCheckIN extends GetView<EmployeeCheckinController>{
  const EmployeeScreenCheckIN({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveContent();
  }


  Widget _buildResponsiveContent() {
    final context = Get.context;
    final isMobile = MediaQuery.of(context!).size.width < 600;
    return isMobile ?  _buildEmployeeCheckINOther() : _buildEmployeeCheckINMobile() ;
  }

  Widget _buildEmployeeCheckINOther() {
    final controller = Get.find<EmployeeCheckinController>();
    final ScrollController _horizontalController = ScrollController();

    final context = Get.context! ;
    return Obx(() {
      return SizedBox(
        height: MediaQuery.of(context).size.width * 0.3,
        width: double.infinity,
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: const Text(
                          'Checkin Record',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _horizontalController,
                  child: SingleChildScrollView(
                    controller: _horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: DataTable(
                          headingTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          dataTextStyle: const TextStyle(fontSize: 12),
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Fingerprint')),
                            DataColumn(label: Text('Username')),
                            DataColumn(label: Text('Check_type')),
                          ],
                          rows: controller.user.map((user) {
                            return DataRow(
                              cells: [
                                DataCell(Text(user.id.toInt() as String ?? '-')),
                                DataCell(Text(user.fingerprint_id.toInt() as String ?? '-')),
                                DataCell(Text(user.username ?? '-')),
                                DataCell(Text(user.check_type ?? '-')),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildEmployeeCheckINMobile() {
    final controller = Get.find<EmployeeCheckinController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: LoadingScreen());
      }
      if (controller.user.isEmpty) {
        return Center(child: Text('No data available'));
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.user.length,
        itemBuilder: (context, index) {
          final record = controller.user[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
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
                            record.id.toInt() as String,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                       ),
                      const SizedBox(height: 5),
                      Text(record.username ?? '-'),
                      const SizedBox(height: 6),
                      Text(record.fingerprint_id.toInt() as String),
                      const SizedBox(height: 6),
                      Text(record.check_type ?? '-'),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

}