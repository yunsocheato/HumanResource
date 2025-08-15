class LeavePolicyModel {
  final String UserID ;
  final String Name ;

  LeavePolicyModel({
    required this.UserID,
    required this.Name,
  });

  factory LeavePolicyModel.fromJson(Map<String, dynamic> json) {
    return LeavePolicyModel(
      UserID: json['user_id']?.toString() ?? '',
      Name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': UserID,
      'name': Name,
    };
  }

}