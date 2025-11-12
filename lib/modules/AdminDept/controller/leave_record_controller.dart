import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/leave_record_model.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/request_leave_model.dart';
import '../Provider/leave_provider.dart';
import '../widget/retailrowhelper.dart';

class LeaveRecordController extends GetxController {
  final leaveprovider service = leaveprovider();
  var currentUserId = ''.obs;
  final photo = ''.obs;
  final safeUrl = ''.obs;
  final radius = 16.0.obs;
  final RxList<Approver> approvedBy = <Approver>[].obs;

  RxString currentUserRole = ''.obs;
  var leaves = <LeaveRecordModel>[].obs;
  var leavesDepartments = <LeaveRecordModel>[].obs;
  var isLoading = false.obs;
  var userProfile = Rxn<Map<String, dynamic>>();
  var leaveRecord = <Map<String, dynamic>>[].obs;
  var currentUser = Rxn<User>();
  var currentUserNames = ''.obs;
  var currentUserDepartment = ''.obs;
  final dateFormat = DateFormat('dd/MM/yyyy');
  final selectedApprover = ''.obs;

  var selectedDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();

  var selectedDateLeaveTeams = Rxn<DateTime>();
  var selectedEndDateLeaveTeams = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        getLeaves();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        leaves.clear();
        leavesDepartments.clear();
        currentUserRole.value = '';
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      loadCurrentUser();
      getLeaves();
    }
  }

  @override
  void onClose() {
    super.onClose();
    leaves.clear();
    leavesDepartments.clear();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final profile =
          await Supabase.instance.client
              .from('signupuser')
              .select('user_id, name, role, photo_url')
              .eq('user_id', user.id)
              .single();

      userProfile.value = profile;
      currentUserNames.value = profile['name'];
      currentUserId.value = profile['user_id'];
      currentUserRole.value = profile['role'];

      if (profile['role'] == 'admindept' || profile['role'] == 'admin') {
        fetchLeavesForAdmin();
      }
    }
  }

  Future<void> fetchLeavesForAdmin() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    isLoading.value = true;

    try {
      final leaves = await Supabase.instance.client
          .from('leave_requests')
          .select('*')
          .eq('reviewed_by', user.id)
          .or('status.eq.pending,status.eq.in_progress')
          .order('created_at', ascending: true);

      leavesDepartments.value =
          (leaves as List).map((e) => LeaveRecordModel.fromMap(e)).toList();
    } catch (e) {
      print('Failed to fetch leaves: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLeavesForAdminByDate({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    isLoading.value = true;

    try {
      final leaves = await Supabase.instance.client
          .from('leave_requests')
          .select('*')
          .eq('reviewed_by', user.id)
          .or('status.eq.pending,status.eq.in_progress')
          .gte('start_date', startDate.toIso8601String())
          .lte('end_date', endDate.toIso8601String())
          .order('created_at', ascending: true);

      leavesDepartments.value =
          (leaves as List).map((e) => LeaveRecordModel.fromMap(e)).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchApprovers() async {
    final client = Supabase.instance.client;

    final data = await client
        .from('signupuser')
        .select('user_id, name, role')
        .or('role.eq.admin,role.eq.admindept,role.eq.superadmin');
    return List<Map<String, dynamic>>.from(data);
  }

  void showApproveDialog(BuildContext context, String leaveId) async {
    final approvers = await fetchApprovers();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Approve Leave Request"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Choose the next approver for this request"),
              const SizedBox(height: 12),
              Obx(
                () => DropdownButtonFormField<String>(
                  value:
                      selectedApprover.value.isEmpty
                          ? null
                          : selectedApprover.value,
                  decoration: const InputDecoration(labelText: "Next Approver"),
                  items:
                      approvers.map((user) {
                        return DropdownMenuItem<String>(
                          value: user['user_id'],
                          child: Text("${user['name']} (${user['role']})"),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) selectedApprover.value = value;
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                if (selectedApprover.value.isNotEmpty) {
                  approveLeave(leaveId, selectedApprover.value);
                  Get.back();
                }
              },
              child: const Text(
                "Approve",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void showRejectDialog(BuildContext context, String leaveId) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Reject Leave Request"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tell the requester why this leave request is rejected."),
              SizedBox(height: 12),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Reason",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                if (reasonController.text.trim().isEmpty) return;
                rejectLeave(leaveId, reasonController.text.trim());
                Navigator.pop(context);
              },
              child: Text("Reject"),
            ),
          ],
        );
      },
    );
  }

  Future<void> approveLeave(String leaveId, String? nextUserId) async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) return;

    try {
      final profile =
          await client
              .from('signupuser')
              .select('name, photo_url, role')
              .eq('user_id', user.id)
              .single();
      final approverName = profile['name'] ?? 'Unknown';
      final approverPhoto = profile['photo_url'];
      final approverRole = (profile['role'] ?? '').toString().toLowerCase();
      final leave =
          await client
              .from('leave_requests')
              .select('approved_by, next_user_id')
              .eq('id', leaveId)
              .single();

      List<dynamic> approvedBy = [];
      if (leave['approved_by'] != null) {
        approvedBy = List.from(leave['approved_by']);
      }
      approvedBy.add({
        'id': user.id,
        'name': approverName,
        'photo_url': approverPhoto,
        'role': profile['role'],
        'date': DateTime.now().toUtc().toIso8601String(),
      });

      if (nextUserId != null && nextUserId.isNotEmpty) {
        final nextUserData =
            await client
                .from('signupuser')
                .select('name, role')
                .eq('user_id', nextUserId)
                .single();

        final nextUserName = nextUserData['name'];
        final nextUserRole =
            (nextUserData['role'] ?? '').toString().toLowerCase();

        if (nextUserRole == 'superadmin') {
          await client
              .from('leave_requests')
              .update({
                'approved_by': approvedBy,
                'status': 'approved',
                'approved_at': DateTime.now().toUtc().toIso8601String(),
                'current_stage': null,
                'reviewed_by': null,
              })
              .eq('id', leaveId);
        } else {
          await client
              .from('leave_requests')
              .update({
                'approved_by': approvedBy,
                'status': 'in_progress',
                'current_stage': nextUserName,
                'reviewed_by': nextUserId,
              })
              .eq('id', leaveId);
        }
      } else {
        if (approverRole != 'superadmin') {
          final superAdmin =
              await client
                  .from('signupuser')
                  .select('user_id, name')
                  .eq('role', 'superadmin')
                  .single();

          await client
              .from('leave_requests')
              .update({
                'approved_by': approvedBy,
                'status': 'in_progress',
                'current_stage': superAdmin['name'],
                'reviewed_by': superAdmin['user_id'],
              })
              .eq('id', leaveId);
        } else {
          await client
              .from('leave_requests')
              .update({
                'approved_by': approvedBy,
                'status': 'approved',
                'approved_at': DateTime.now().toUtc().toIso8601String(),
                'current_stage': null,
                'reviewed_by': null,
              })
              .eq('id', leaveId);
        }
      }

      selectedApprover.value = '';
      fetchLeavesForAdmin();
    } catch (e) {
      Get.snackbar('Error', 'Failed to approve leave. $e');
    }
  }

  Future<void> rejectLeave(String leaveId, String reason) async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) return;

    await client
        .from('leave_requests')
        .update({
          'status': 'rejected',
          'rejected_reason': reason,
          'next_user_id': [],
          'action_by': user.id,
        })
        .eq('id', leaveId);

    fetchLeavesForAdmin();
  }

  String formatDate(dynamic date) {
    if (date == null || date.toString().isEmpty || date == 'null') {
      return '-';
    }

    try {
      final parsedDate =
          date is DateTime ? date : DateTime.tryParse(date.toString());

      if (parsedDate == null) return '-';

      return DateFormat('MMM d, yyyy').format(parsedDate);
    } catch (e) {
      return '-';
    }
  }

  void showLeaveDialog(LeaveRecordModel request) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Container(
          width: Get.width < 500 ? Get.width * 0.9 : 400,
          constraints: BoxConstraints(maxHeight: Get.height * 0.7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade900, Colors.blue.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Leave Record',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage:
                                request.photo_url != null &&
                                        request.photo_url!.isNotEmpty
                                    ? NetworkImage(request.photo_url!)
                                    : null,
                            child:
                                request.photo_url == null ||
                                        request.photo_url!.isEmpty
                                    ? const Icon(Icons.person, size: 22)
                                    : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            request.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DetailRow('Req.Number', request.requestNumber),
                      DetailRow(
                        'Req.Date',
                        request.requestDate != null
                            ? dateFormat.format(request.requestDate!)
                            : '-',
                      ),
                      DetailRow('Req.Type', request.requestType),
                      DetailRow('Department', request.department),
                      DetailRow('Position', request.position),
                      DetailRow('Status', request.status),
                      DetailRow('Submit To', request.currentStage),
                      DetailRows(
                        'Approved By',
                        Row(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 120,
                                maxHeight: 32,
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children:
                                    request.approvedBy.asMap().entries.map((
                                      entry,
                                    ) {
                                      int index = entry.key;
                                      Approver approver = entry.value;
                                      return Positioned(
                                        left: index * 24.0,
                                        child: CircleAvatar(
                                          radius: radius.value,
                                          backgroundColor: Colors.grey[200],
                                          child: ClipOval(
                                            child:
                                                safeUrl.isNotEmpty
                                                    ? Image.network(
                                                      safeUrl.value,
                                                      width: radius * 2,
                                                      height: radius * 2,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        return Icon(
                                                          Icons.person,
                                                          size: radius.value,
                                                        );
                                                      },
                                                      loadingBuilder: (
                                                        context,
                                                        child,
                                                        progress,
                                                      ) {
                                                        if (progress == null)
                                                          return child;
                                                        return SizedBox(
                                                          width: radius * 2,
                                                          height: radius * 2,
                                                          child: const Center(
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation(
                                                                    Colors.blue,
                                                                  ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                    : Icon(
                                                      Icons.person,
                                                      size: radius.value,
                                                    ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                showApproversDialog(request.approvedBy);
                              },
                            ),
                          ],
                        ),
                      ),
                      DetailRow('Reason', request.reason),
                      DetailRow(
                        'Start Date',
                        request.startDate != null
                            ? DateFormat(
                              'MMM d, yyyy',
                            ).format(request.startDate!)
                            : '-',
                      ),
                      DetailRow(
                        'End Date',
                        request.endDate != null
                            ? DateFormat('MMM d, yyyy').format(request.endDate!)
                            : '-',
                      ),
                      DetailRow('Total Days', request.leaveCount.toString()),
                    ],
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue.shade700,
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setApprovedBy(List<dynamic> data) {
    approvedBy.value = data.map((e) => Approver.fromMap(e)).toList();
  }

  void showApproversDialog(List<Approver> approvers) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.7,
            maxWidth: Get.width < 500 ? Get.width * 0.9 : 400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  gradient: LinearGradient(
                    colors: [Colors.redAccent, Colors.red],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Approved By',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: DetailRowsColumn(title: '', approvers: approvers),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Close',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static DetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void setStartDate(DateTime date) {
    selectedDate.value = date;
  }

  void setEndDate(DateTime date) {
    selectedEndDate.value = date;
    if (selectedEndDate.value != null) {
      fetchLeavesByDate(selectedDate.value!, selectedEndDate.value!);
    }
  }

  void setStartDateLeaveTeam(DateTime date) {
    selectedDateLeaveTeams.value = date;
  }

  void setEndDateLeaveTeam(DateTime date) {
    selectedEndDateLeaveTeams.value = date;
    if (selectedEndDateLeaveTeams.value != null) {
      fetchLeavesForAdminByDate(
        startDate: selectedDateLeaveTeams.value!,
        endDate: selectedEndDateLeaveTeams.value!,
      );
    }
  }

  List<Map<String, dynamic>> get filteredRequests {
    var list = leaveRecord.toList();

    list =
        list.where((request) {
          final fromDate =
              request['start_date'] != null
                  ? DateTime.parse(request['start_date'])
                  : null;
          return fromDate != null && !fromDate.isBefore(selectedDate.value!);
        }).toList();

    list =
        list.where((request) {
          final toDate =
              request['end_date'] != null
                  ? DateTime.parse(request['end_date'])
                  : null;
          return toDate != null && !toDate.isAfter(selectedEndDate.value!);
        }).toList();

    return list;
  }

  Future<void> getLeaves() async {
    try {
      isLoading.value = true;
      final data = await service.getPendingLeaveRequests();
      leaves.value = data.map((e) => LeaveRecordModel.fromMap(e)).toList();
    } catch (e) {
      leaves.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLeavesByDate(DateTime start, DateTime end) async {
    try {
      isLoading.value = true;
      final userId = Supabase.instance.client.auth.currentUser!.id;
      leaves.value = await service.getLeaveDatabydate(userId, start, end);
    } finally {
      isLoading.value = false;
    }
  }
}
