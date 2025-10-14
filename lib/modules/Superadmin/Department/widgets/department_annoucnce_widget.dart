import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controllers/department_controller.dart';

class DepartmentAnnounce extends GetView<DepartmentScreenController>{
  const DepartmentAnnounce({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      // child: const DepartmentCard(),
    );
  }
}