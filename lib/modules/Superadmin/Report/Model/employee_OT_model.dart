class EmployeeOTModel {
  final String user_id ;
  final String staff_id ;
  final String staff_name ;
  final DateTime start_date ;
  final String time_start ;
  final DateTime end_date ;
  final String end_time ;
  final String reason ;
  final DateTime created_at ;

  EmployeeOTModel({
    required this.user_id,
    required this.staff_id,
    required this.staff_name,
    required this.start_date,
    required this.time_start,
    required this.end_date,
    required this.end_time,
    required this.reason,
    required this.created_at,
});
  factory EmployeeOTModel.fromJson(Map<String , dynamic> json){
    return EmployeeOTModel(
      user_id: json['user_id'],
      staff_id: json['staff_id'],
      staff_name: json['staff_name'],
      start_date: DateTime.parse(json['start_date']),
      time_start: json['time_start'],
      end_date: DateTime.parse(json['end_date']),
      end_time: json['end_time'],
      reason: json['reason'],
      created_at: DateTime.parse(json['created_at']),
    );
  }
  Map<String , dynamic> toJson(){
    final Map<String , dynamic> data = new Map<String , dynamic>();
    data['user_id'] = this.user_id;
    data['staff_id'] = this.staff_id;
    data['staff_name'] = this.staff_name;
    data['start_date'] = this.start_date.toIso8601String();
    data['time_start'] = this.time_start;
    data['end_date'] = this.end_date.toIso8601String();
    data['end_time'] = this.end_time;
    data['reason'] = this.reason;
    data['created_at'] = this.created_at.toIso8601String();
    return data;
  }
}