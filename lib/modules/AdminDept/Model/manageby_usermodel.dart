class ManageByUsersModels {
  final String Name;
  final String ManageByname;
  final String HeadName;
  final String HeadPosition;

  ManageByUsersModels({
    required this.Name,
    required this.ManageByname,
    required this.HeadName,
    required this.HeadPosition,
  });

  factory ManageByUsersModels.fromMap(Map<String, dynamic> map) {
    return ManageByUsersModels(
      Name: map['name'],
      ManageByname: map['mangebyname'],
      HeadName: map['headname'],
      HeadPosition: map['headposition'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': Name,
      'mangebyname': ManageByname,
      'headname': HeadName,
      'headposition': HeadPosition,
    };
  }
}
