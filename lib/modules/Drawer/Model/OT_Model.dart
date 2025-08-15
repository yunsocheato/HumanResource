
class OTModel {
  String? username;
  String? userID;
  bool? ifTechnical;
  bool? ifNonTechnical;
  bool? usercannotchange;
  bool? usercanchange;

  OTModel(
      {this.username, this.ifTechnical, this.ifNonTechnical, this.usercannotchange, this.userID, this.usercanchange});

  factory OTModel.fromJson(Map<String, dynamic> json) {
    return OTModel(
      userID: json['user_id'],
      username: json['name'],
      ifTechnical: json['technical'],
      ifNonTechnical: json['nontechnical'],
      usercannotchange: json['usercannotchange'],
      usercanchange: json['usercanchange'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userID;
    data['name'] = username;
    data['technical'] = ifTechnical;
    data['nontechnical'] = ifNonTechnical;
    data['usercannotchange'] = usercannotchange;
    data['usercanchange'] = usercanchange;
    return data;
  }
}