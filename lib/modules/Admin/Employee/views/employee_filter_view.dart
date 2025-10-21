import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/employeefiltercontroller.dart';

class EmployeefilterView extends GetView<EmployeeFilterController> {
  const EmployeefilterView({super.key});


  @override
  Widget build(BuildContext context) {
    return EmploeeFilterViewResponsive();
  }

  Widget EmploeeFilterViewResponsive() {
    final isMobile = Get.width < 600;
    return isMobile ? EmploeeFilterViewMobile() : EmploeeFilterViewOther();
  }

  Widget EmploeeFilterViewMobile() {
    var selectedValue = 'PDF';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Employee Records',
            style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                icon: const Icon(
                  Icons.import_export,
                  color: Colors.white,
                ),
                style: TextStyle(color: Colors.white),
                items:
                ['PDF', 'EXCEL', 'Image']
                    .map(
                        (String value) =>
                        DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                            child: Text(value),
                          ),
                        )).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    selectedValue = newValue;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget EmploeeFilterViewOther() {
    var selectedValue = 'PDF';
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: const Icon(
            Icons.import_export,
            color: Colors.white,
          ),
          style: TextStyle(color: Colors.white),
          items:
          ['PDF', 'EXCEL', 'Image']
              .map(
                  (String value) =>
                  DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                        BorderRadius.circular(8),
                      ),
                      child: Text(value),
                    ),
                  )).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              selectedValue = newValue;
            }
          },
        ),
      ),
    );
  }

}