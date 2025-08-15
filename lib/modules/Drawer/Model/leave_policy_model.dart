class LeavePolicyModel {
  final String userID;
  final String name;
  final bool deductLeave;
  final bool blockLeave;
  final bool agreement;
  final int monthly;
  final int daily;
  final int inMinute;
  final bool blockAnualLeave;
  final bool blockSickLeave;
  final bool blockUnpaidLeave;
  final bool limitLeave;
  final bool notLeaveProbation;
  final bool unpaidLeaveAvailable;
  final bool sickLeaveCertif;
  final String createdAt;
  final String updatedAt;

  LeavePolicyModel({
    required this.userID,
    required this.name,
    required this.deductLeave,
    required this.blockLeave,
    required this.agreement,
    required this.monthly,
    required this.daily,
    required this.inMinute,
    required this.blockAnualLeave,
    required this.blockSickLeave,
    required this.blockUnpaidLeave,
    required this.limitLeave,
    required this.notLeaveProbation,
    required this.unpaidLeaveAvailable,
    required this.sickLeaveCertif,
    required this.createdAt,
    required this.updatedAt,
});

  factory LeavePolicyModel.fromJson(Map<String, dynamic> json) {
    return LeavePolicyModel(
      userID: json['user_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      deductLeave: json['deduct_leave'] ?? false,
      blockLeave: json['block_leave'] ?? false,
      agreement: json['agreement'] ?? false,
      monthly: json['monthly_salary'] ?? 0,
      daily: json['daily_salary'] ?? 0,
      inMinute: json['minute_salary'] ?? 0,
      blockAnualLeave: json['block_anual_leave'] ?? false,
      blockSickLeave: json['block_sick_leave'] ?? false,
      blockUnpaidLeave: json['block_unpaid_leave'] ?? false,
      limitLeave: json['limit_leave'] ?? false,
      notLeaveProbation: json['notleaveprobation'] ?? false,
      unpaidLeaveAvailable: json['unpaidleaveavailable'] ?? false,
      sickLeaveCertif: json['sickleavecertificate'] ?? false,
      createdAt: json['created_at']?.toString() ?? DateTime.now().toIso8601String(),
      updatedAt: json['updated_at']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': userID,
      'name': name,
      'deduct_leave': deductLeave,
      'block_leave': blockLeave,
      'agreement': agreement,
      'monthly_salary': monthly,
      'daily_salary': daily,
      'minute_salary': inMinute,
      'block_anual_leave': blockAnualLeave,
      'block_sick_leave': blockSickLeave,
      'block_unpaid_leave': blockUnpaidLeave,
      'limit_leave': limitLeave,
      'notleaveprobation': notLeaveProbation,
      'unpaidleaveavailable': unpaidLeaveAvailable,
      'sickleavecertificate': sickLeaveCertif,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }



}