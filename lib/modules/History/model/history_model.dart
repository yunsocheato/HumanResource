class HistoryModel {
  final String Name;
  final String Department;
  final String Positon;
  final String Status;

  HistoryModel({
    required this.Name,
    required this.Department,
    required this.Positon,
    required this.Status,
  });

  factory HistoryModel.fromjson(Map<String, dynamic> json) {
    return HistoryModel(
      Name: json['Name'],
      Department: json['Department'],
      Positon: json['Positon'],
      Status: json['Status'],
    );
  }
}