class AttendanceStats {
  final int presentCount;
  final int totalCount;
  final double percentage;

  AttendanceStats({
    required this.presentCount,
    required this.totalCount,
    required double percentage,
  }) : percentage = totalCount == 0 ? 0 : (presentCount / totalCount) * 100;
}
