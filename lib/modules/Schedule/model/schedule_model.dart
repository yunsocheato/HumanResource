class ScheduleModel {
  String Email ;
  String Name ;
  String Status;

  ScheduleModel({
    required this.Email,
    required this.Name,
    required this.Status,
});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    Email: json["Email"],
    Name: json["Name"],
    Status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Email": Email,
    "Name": Name,
    "Status": Status,
  };


}