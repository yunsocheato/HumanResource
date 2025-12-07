class EmployeeAbsentModel {
  final String user_id;
  final String staff_name;
  final String position;
  final String department;
  final String staff_id;
  final DateTime absent_date;
  final String reason;
  final DateTime created_at;

  EmployeeAbsentModel({
    required this.user_id,
    required this.staff_name,
    required this.position,
    required this.department,
    required this.staff_id,
    required this.absent_date,
    required this.reason,
    required this.created_at,
  });

  factory EmployeeAbsentModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAbsentModel(
        user_id: json["user_id"],
        staff_name: json["staff_name"],
        position: json["position"],
        department: json["department"],
        staff_id: json["staff_id"],
        absent_date: DateTime.parse(json["absent_date"]),
        reason: json["reason"],
        created_at: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
    "user_id": user_id,
    "staff_name": staff_name,
    "position": position,
    "department": department,
    "staff_id": staff_id,
    "absent_date": absent_date.toLocal(),
    "reason": reason,
    "created_at": created_at.toLocal(),
  };
}
