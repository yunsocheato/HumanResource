import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/attendance_model.dart';
import '../widgets/attendance_datasource.dart';


class ExportPDF extends StatefulWidget {
  const ExportPDF({super.key, required RxList<Map<String, dynamic>> attendaData});

  @override
  State<ExportPDF> createState() => _ExportPDFState();
}

class _ExportPDFState extends State<ExportPDF> {
  List<AttendanceModel> allData = [];
  List<AttendanceModel> filteredData = [];

  DateTime? startDate;
  DateTime? endDate;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    startDate = DateTime(now.year, now.month, now.day);
    endDate = DateTime(now.year, now.month, now.day);
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    final res = await Supabase.instance.client
        .from('attendance')
        .select()
        .order('timestamp');

    final List<AttendanceModel> data =
        (res as List).map((json) => AttendanceModel.fromJson(json)).toList();

    setState(() {
      allData = data;
      filterData();
      isLoading = false;
    });
  }

  void filterData() {
    filteredData =
        allData.where((e) {
          return e.clockIn.isAfter(
                startDate!.subtract(const Duration(seconds: 1)),
              ) &&
              e.clockIn.isBefore(endDate!.add(const Duration(days: 1)));
        }).toList();
  }

  Future<void> pickDateRange() async {
    final pickedStart = await showDatePicker(
      context: context,
      initialDate: startDate!,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedStart == null) return;

    final pickedEnd = await showDatePicker(
      context: context,
      initialDate: pickedStart,
      firstDate: pickedStart,
      lastDate: DateTime(2030),
    );
    if (pickedEnd == null) return;

    setState(() {
      startDate = pickedStart;
      endDate = pickedEnd;
      filterData();
    });
  }


  Future<void> exportToPdf() async {
    final pdf = pw.Document();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    final rows = <List<String>>[
      ['Username', 'Clock In', 'Check Type'],
      ...filteredData.map(
        (e) => [e.username, formatter.format(e.clockIn), e.checkType],
      ),
    ];

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Table.fromTextArray(data: rows),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final dataSource = MyDataSource(filteredData);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.red,
        title: Text("PDF Preview", style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.grey[50],
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade900,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: (){
                                    setState(() {

                                    });
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "From: ${DateFormat('yyyy-MM-dd').format(startDate!)}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 16,),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade900,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: (){
                                    setState(() {

                                    });
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "To: ${DateFormat('yyyy-MM-dd').format(endDate!)}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurpleAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: pickDateRange,
                                  icon: const Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Pick Date: ${DateFormat('yyyy-MM-dd')
                                        .format(endDate!)}",
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                )

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade900,
                            Colors.red.shade300,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Attendance Records Export",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () => fetchData(),
                                  icon: const Icon(Icons.refresh, color: Colors.white),
                                  label: const Text(
                                    'REFRESH',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: exportToPdf,
                                  icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                                  label: const Text(
                                    'Export',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: PaginatedDataTable(
                            dataRowMinHeight: 25,
                            columns: const [
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    "Username",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    "Clock IN",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    "Checkin-Type",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                            source: dataSource,
                            rowsPerPage: 500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
