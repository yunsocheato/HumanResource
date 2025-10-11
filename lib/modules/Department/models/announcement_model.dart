class AnnouncementModel{
  String Name ;
  String  Positon ;
  String DateTimes;
  String Status;

  AnnouncementModel({
    required this.Name,
    required this.Positon,
    required this.DateTimes,
    required this.Status,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      Name: json['name'],
      Positon: json['position'],
      DateTimes: json['datetimes'],
      Status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = Name;
    data['position'] = Positon;
    data['datetimes'] = DateTimes;
    data['status'] = Status;
    return data;
  }
}