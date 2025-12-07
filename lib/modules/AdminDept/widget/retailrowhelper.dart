import 'package:flutter/material.dart';

import '../Model/leave_record_model.dart';

class DetailRows extends StatelessWidget {
  final String title;
  final Widget value;

  const DetailRows(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 5, child: value),
        ],
      ),
    );
  }
}

class DetailRowsColumn extends StatelessWidget {
  final String title;
  final List<Approver> approvers;
  final String? photo;
  final double radius;

  const DetailRowsColumn({
    required this.title,
    required this.approvers,
    this.photo,
    this.radius = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final safeUrl = photo?.trim();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Column(
            children:
                approvers.map((approver) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: radius,
                          backgroundColor: Colors.grey[200],
                          child: ClipOval(
                            child:
                                safeUrl != null && safeUrl.isNotEmpty
                                    ? Image.network(
                                      safeUrl,
                                      width: radius * 2,
                                      height: radius * 2,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Icon(Icons.person, size: radius);
                                      },
                                      loadingBuilder: (
                                        context,
                                        child,
                                        progress,
                                      ) {
                                        if (progress == null) return child;
                                        return SizedBox(
                                          width: radius * 2,
                                          height: radius * 2,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                    Colors.blue,
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                    : Icon(Icons.person, size: radius),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              approver.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              approver.role ?? '-',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
