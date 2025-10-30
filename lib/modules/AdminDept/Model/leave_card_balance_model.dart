class LeaveCardModel {
  final String AnnualLeave;
  final String SickLeave;
  final String MaternityLeave;
  final String UnpaidLeave;

  LeaveCardModel({
    required this.AnnualLeave,
    required this.SickLeave,
    required this.MaternityLeave,
    required this.UnpaidLeave,
  });

  factory LeaveCardModel.fromMap(Map<String, dynamic> map) {
    return LeaveCardModel(
      AnnualLeave: map['annualleave']?.toString() ?? '0',
      SickLeave: map['sickleave']?.toString() ?? '0',
      MaternityLeave: map['maternityleave']?.toString() ?? '0',
      UnpaidLeave: map['unpaidleave']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'annualleave': AnnualLeave,
      'sickleave': SickLeave,
      'maternityleave': MaternityLeave,
      'unpaidleave': UnpaidLeave,
    };
  }
}
