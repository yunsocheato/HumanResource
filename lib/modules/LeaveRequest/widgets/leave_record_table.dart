import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../API/leave_stream_rpc_sql.dart';
import 'leave_detail_widget.dart';

class Leaverecord extends StatefulWidget {
  const Leaverecord({super.key});

  @override
  State<Leaverecord> createState() => _LeaverecordState();
}

class _LeaverecordState extends State<Leaverecord> {

  bool _isLoading = false;
  List<Map<String, dynamic>> leaveRequests = [];

  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests();
  }

  Future<void> _fetchLeaveRequests() async {
    final data = await getPendingLeaveRequests();
    setState(() => leaveRequests = data);
  }
  @override
  Widget build(BuildContext context) {
    return _buildLeaveRequestsTable();
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
            child: Text('No pending leave requests found',style: TextStyle(color: Colors.red),),
          );
        }

        final requests = snapshot.data!;

        return SizedBox(
          height : double.infinity,
          child: Card(
            color: Colors.white,
            borderOnForeground: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: DataTable2(
                  dataRowHeight: 60,
                  columnSpacing: 12,
                  horizontalMargin: 15,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Text('Employee'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('Department'),
                    ),
                    DataColumn(
                      label: Text('Position'),
                    ),
                    DataColumn(
                      label: Text('Status'),
                    ),
                    DataColumn(
                      label: Text('Start Date'),
                    ),
                    DataColumn(
                      label: Text('End Date'),
                    ),
                    DataColumn2(
                      label: Text('Actions'),
                      size: ColumnSize.L,
                    ),
                  ],
                  rows: requests.map<DataRow>((request) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                request['name'] ?? '-',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                request['user_email'] ?? '-',
                                // corrected to match RPC
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(request['department'] ?? '-')),
                        DataCell(Text(request['position'] ?? '-')),
                        DataCell(Text(request['status'] ?? '-')),
                        DataCell(Text(
                          request['from_date'] != null
                              ? DateFormat('MMM d, yyyy').format(
                              DateTime.parse(request['from_date']))
                              : '-',)),
                        DataCell(Text(
                          request['to_date'] != null
                              ? DateFormat('MMM d, yyyy').format(
                              DateTime.parse(request['to_date']))
                              : '-',)),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check_circle_outline),
                              color: Colors.green,
                              onPressed: () =>
                                  _handleStatusUpdate(
                                    requestId: request['request_id'],
                                    status: 'approved',
                                  ),
                              tooltip: 'Approve',
                            ),
                            IconButton(
                              icon: const Icon(Icons.cancel_outlined),
                              color: Colors.red,
                              onPressed: () =>
                                  _handleStatusUpdate(
                                    requestId: request['request_id'],
                                    status: 'rejected',
                                  ),
                              tooltip: 'Reject',
                            ),
                            IconButton(
                              icon: const Icon(Icons.info_outline),
                              onPressed: () => showDetailsDialog(context , request),
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
          ),
        );
      },
    );
  }

  Future<void> _handleStatusUpdate({
    required String requestId,
    required String status,
  }) async {
    try {
      setState(() => _isLoading = true);

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
      setState(() => _isLoading = false);
    }
  }

}