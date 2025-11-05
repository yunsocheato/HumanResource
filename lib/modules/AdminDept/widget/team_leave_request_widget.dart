import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/request_leave_controller.dart';

class TeamRequestLeaveWidget extends GetView<RequestLeaveScreenController> {
  const TeamRequestLeaveWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.RequestLeaveModels.isEmpty) {
        return Center(child: Text('No leave requests'));
      }

      return ListView.builder(
        itemCount: controller.RequestLeaveModels.length,
        itemBuilder: (context, index) {
          final leave = controller.RequestLeaveModels[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text('${leave.name} - ${leave.status}'),
              subtitle: Text(
                'Stage: ${leave.currentStage}\nReason: ${leave.reason}\nDates: ${leave.startDate?.toIso8601String()} - ${leave.endDate?.toIso8601String()}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leave.status != 'approved' && leave.status != 'rejected')
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        controller.approveLeave(
                            leave.id, 'reviewer-uuid', 'admin');
                      },
                    ),
                  if (leave.status != 'approved' && leave.status != 'rejected')
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        controller.rejectLeave(
                            leave.id, 'reviewer-uuid', 'admin');
                      },
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
