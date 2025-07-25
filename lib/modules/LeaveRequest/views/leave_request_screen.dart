import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Attendance/utils/ExportExcel.dart';
import '../../Attendance/utils/ExportPDF.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../API/leave_stream_rpc_sql.dart';


class LeaveRequest extends StatefulWidget {
  static const String routeName = '/LeaveRequest';

  const LeaveRequest({super.key});
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  bool isLoading = false;
  String ? selectedValue = 'EXCEL';
  String selectedValue1 = 'Filter';
  List<Map<String, dynamic>> leaveRequests = [];
  bool _showLoginCard = false;
  bool _showLoginCard1 = false;

  String? _error;
  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showLoginCard = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showLoginCard1 = true;
      });
    });
    // fetchLeaveRequests();
  }
  @override
  Widget build(BuildContext context) {
    return Drawerscreen(
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Cardinfo()),
            const SizedBox(height: 20),
            Expanded(child: _buildLeaveRequestsTable()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedOpacity(
      duration: const Duration(seconds: 2),
      opacity: _showLoginCard1 ? 1.0 : 0.0,
      child: AnimatedPadding(
        duration: const Duration(seconds: 2),
        padding: EdgeInsets.only(top: _showLoginCard1 ? 0 : 100),
        child: SizedBox(
          height: 70,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
            shadowColor: Colors.grey.withOpacity(0.2),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'LEAVE DASHBOARD',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text(
                          'Refresh',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildLeaveRequestsTable() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getPendingLeaveRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No pending leave requests found'),
          );
        }

        final requests = snapshot.data!;

        return SizedBox(
          height: 800,
          width: double.infinity,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    gradient: LinearGradient(
                      colors: [Colors.red.shade900, Colors.red.shade300],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Leave Records',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedValue1,
                            icon: const Icon(Icons.filter_alt_off, color: Colors.white),
                            style: const TextStyle(color: Colors.white),
                            dropdownColor: Colors.blue.shade900,
                            items: ['Filter', 'Username', 'Clock IN', 'Check Type']
                                .map((value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.white)),
                            ))
                                .toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() => selectedValue1 = newValue);
                              }
                            },
                          ),
                        ),
                      ),

                      // 🔹 Start Date Button
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
                        label: const Text('Start Date', style: TextStyle(color: Colors.white)),
                      ),

                      // 🔹 End Date Button
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
                        label: const Text('End Date', style: TextStyle(color: Colors.white)),
                      ),

                      // 🔹 Export Dropdown
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
                            icon: const Icon(Icons.import_export, color: Colors.white),
                            style: const TextStyle(color: Colors.white),
                            dropdownColor: Colors.blue,
                            items: ['PDF', 'EXCEL', 'Image']
                                .map((value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.white)),
                            ))
                                .toList(),
                            onChanged: (newValue) async {
                              if (newValue != null) {
                                setState(() => selectedValue = newValue);
                                if (newValue == 'PDF') {
                                  await Navigator.push(context, MaterialPageRoute(builder: (_) => ExportPDF()));
                                  setState(() => selectedValue = 'EXCEL');
                                } else if (newValue == 'EXCEL') {
                                  await exportToExcel();
                                } else if (newValue == 'Image') {
                                  // Image export logic
                                }
                              }
                            },
                          ),
                        ),
                      ),

                      // 🔹 Search Button
                      _buildsearchbutton(),
                    ],
                  ),
                ),

                // 🟢 Table Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DataTable2(
                      dataRowHeight: 60,
                      columnSpacing: 12,
                      horizontalMargin: 15,
                      minWidth: 600,
                      columns: const [
                        DataColumn2(label: Text('Employee'), size: ColumnSize.L),
                        DataColumn(label: Text('Department')),
                        DataColumn(label: Text('Position')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Start Date')),
                        DataColumn(label: Text('End Date')),
                        DataColumn2(label: Text('Actions'), size: ColumnSize.L),
                      ],
                      rows: requests.map<DataRow>((request) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(request['name'] ?? '-', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(request['user_email'] ?? '-', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                ],
                              ),
                            ),
                            DataCell(Text(request['department'] ?? '-')),
                            DataCell(Text(request['position'] ?? '-')),
                            DataCell(Text(request['status'] ?? '-')),
                            DataCell(Text(request['from_date'] != null
                                ? DateFormat('MMM d, yyyy').format(DateTime.parse(request['from_date']))
                                : '-')),
                            DataCell(Text(request['to_date'] != null
                                ? DateFormat('MMM d, yyyy').format(DateTime.parse(request['to_date']))
                                : '-')),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check_circle_outline),
                                  color: Colors.green,
                                  onPressed: () => _handleStatusUpdate(
                                    requestId: request['request_id'],
                                    status: 'approved',
                                  ),
                                  tooltip: 'Approve',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.cancel_outlined),
                                  color: Colors.red,
                                  onPressed: () => _handleStatusUpdate(
                                    requestId: request['request_id'],
                                    status: 'rejected',
                                  ),
                                  tooltip: 'Reject',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.info_outline),
                                  onPressed: () => _showDetailsDialog(request),
                                  tooltip: 'View Details',
                                ),
                              ],
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Future<void> _handleStatusUpdate({
    required String requestId,
    required String status,
  }) async {
    try {
      setState(() => isLoading = true);

      final adminId = Supabase.instance.client.auth.currentUser?.id;
      if (adminId == null) throw 'No admin ID found';

      final success = await updateLeaveRequestStatus(
        requestId: requestId,
        newStatus: status,
        adminId: adminId,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request $status successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          leaveRequests.removeWhere((request) => request['id'] == requestId);
        }); // Refresh the list
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showDetailsDialog(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Gradient Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Colors.red.shade900, Colors.red.shade300],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Text(
                  'Leave Request Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Scrollable content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _detailRow('Employee', request['name'] ?? 'No name'),
                      _detailRow('Email', request['user_email'] ?? 'No email'),
                      _detailRow('Department', request['department'] ?? 'No Department'),
                      _detailRow('Position', request['position'] ?? 'None'),
                      _detailRow(
                        'Start Date',
                        request['from_date'] != null
                            ? DateFormat('MMM d, yyyy').format(DateTime.parse(request['from_date']))
                            : 'No date',
                      ),
                      _detailRow(
                        'End Date',
                        request['to_date'] != null
                            ? DateFormat('MMM d, yyyy').format(DateTime.parse(request['to_date']))
                            : 'No date',
                      ),
                      _detailRow('Reason', request['reason'] ?? 'None'),
                      _detailRow(
                        'Created At',
                        request['created_at'] != null
                            ? DateFormat('MMM d, yyyy HH:mm').format(DateTime.parse(request['created_at']))
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
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
  Widget _buildsearchbutton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: 250,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                  onChanged: (value) {
                    // Implement search functionality
                  },
                ),
              ),
            ]
        )
    );
  }

}