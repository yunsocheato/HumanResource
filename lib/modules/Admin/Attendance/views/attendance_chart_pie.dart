import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../controllers/attendance_chart_pie_controller.dart';
import '../models/attendance_chart_pie_model.dart';

class AttendanceChartPie extends GetView<ChartPieController> {
  const AttendanceChartPie({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isLaptop = width >= 1024 && width < 1440;
        final isDesktop = width >= 1440 && width < 2560;
        final isLargeDesktop = width >= 2560;

        double cardHeight;
        double cardWidth;
        double titleFontSize;

        if (isMobile) {
          cardHeight = 200;
          cardWidth = double.infinity;
          titleFontSize = 14;
        } else if (isTablet) {
          cardHeight = 260;
          cardWidth = width * 0.2;
          titleFontSize = 16;
        } else if (isLaptop) {
          cardHeight = 500;
          cardWidth = width * 0.2;
          titleFontSize = 18;
        } else if (isDesktop) {
          cardHeight = 450;
          cardWidth = width * 0.4;
          titleFontSize = 20;
        } else if (isLargeDesktop) {
          cardHeight = 500;
          cardWidth = width * 0.2;
          titleFontSize = 22;
        } else {
          cardHeight = 600;
          cardWidth = width * 0.3;
          titleFontSize = 18;
        }
        final HoverMouseController controller1 = Get.put(
          HoverMouseController(),
        );

        return MouseHover(
          keyId: 2,
          controller: controller1,
          child: SizedBox(
            height: cardHeight,
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(8),
              child: SizedBox(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Attendance Leave",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Obx(() {
                        final chartData = controller.Chartpie.toList();
                        if (chartData.isEmpty) {
                          return const Center(child: Text("No data available"));
                        }

                        return SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                          ),
                          series: <CircularSeries>[
                            PieSeries<ShowData, String>(
                              dataSource: chartData,
                              xValueMapper: (ShowData data, _) => data.category,
                              yValueMapper: (ShowData data, _) => data.value,
                              dataLabelMapper:
                                  (ShowData data, _) =>
                                      '${data.category}: ${data.value.toStringAsFixed(0)}',
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside,
                                textStyle: TextStyle(fontSize: 12),
                              ),
                              pointColorMapper:
                                  (ShowData data, _) => data.color,
                              enableTooltip: true,
                              legendIconType: LegendIconType.circle,
                              radius: '70%',
                              explode: true,
                              explodeAll: true,
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
