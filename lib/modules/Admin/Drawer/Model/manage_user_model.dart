class ManageUserModel {
  final String UserID;
  final String name;
  final String managebyname;
  final String headname;
  final String headposition;

  ManageUserModel({
    required this.UserID,
    required this.name,
    required this.managebyname,
    required this.headname,
    required this.headposition,
  });

  factory ManageUserModel.fromMap(Map<String, dynamic> map) {
    return ManageUserModel(
      UserID: map['UserID'],
      name: map['name'],
      managebyname: map['mangebyname'],
      headname: map['headname'],
      headposition: map['headposition'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UserID': UserID,
      'name': name,
      'mangebyname': managebyname,
      'headname': headname,
      'headposition': headposition,
    };
  }
}
