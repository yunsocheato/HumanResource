class AttendanceModel {
  final String username;
  final DateTime clockIn;
  final String checkType;

  AttendanceModel({
    required this.username,
    required this.clockIn,
    required this.checkType,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      username: json['username'] ?? '',
      clockIn: DateTime.parse(json['timestamp']),
      checkType: json['check_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': username,
      'timestamp': clockIn.toIso8601String(),
      'check_type': checkType,
    };
  }
}
