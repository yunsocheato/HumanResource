class EmployeeCheckinModel {
  final int id ;
  final int fingerprint_id ;
  final String username ;
  final String? check_type ;

  EmployeeCheckinModel({
    required this.id,
    required this.fingerprint_id,
    required this.username,
    required this.check_type,
});

  factory EmployeeCheckinModel.fromJson(Map<String, dynamic> json) =>
      EmployeeCheckinModel(
        id: json["id"],
        check_type: json["check_type"],
        fingerprint_id: json["fingerprint_id"] as int,
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": check_type,
    "fingerprint_id": fingerprint_id,
    "check_type": check_type,
  };

}

class EmployeeCheckinCountModel {
  final int checkin_count;
  final int id ;

  EmployeeCheckinCountModel({
    required this.checkin_count,
    required this.id,
  });
  factory EmployeeCheckinCountModel.fromJson(Map<String, dynamic> json) =>
      EmployeeCheckinCountModel(
        checkin_count: json["checkin_count"],
        id: json["id"],
      );
  Map<String, dynamic> toJson() => {
    "checkin_count": checkin_count,
    "id": id,
  };

}