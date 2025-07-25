import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showDetailsDialog(BuildContext context , Map<String, dynamic> request) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gradient Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [Colors.red.shade900, Colors.red.shade300],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Text(
                'Leave Request Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailRow('Employee', request['name'] ?? 'No name'),
                    _detailRow('Email', request['user_email'] ?? 'No email'),
                    _detailRow('Department', request['department'] ?? 'No Department'),
                    _detailRow('Position', request['position'] ?? 'None'),
                    _detailRow(
                      'Start Date',
                      request['from_date'] != null
                          ? DateFormat('MMM d, yyyy').format(DateTime.parse(request['from_date']))
                          : 'No date',
                    ),
                    _detailRow(
                      'End Date',
                      request['to_date'] != null
                          ? DateFormat('MMM d, yyyy').format(DateTime.parse(request['to_date']))
                          : 'No date',
                    ),
                    _detailRow('Reason', request['reason'] ?? 'None'),
                    _detailRow(
                      'Created At',
                      request['created_at'] != null
                          ? DateFormat('MMM d, yyyy HH:mm').format(DateTime.parse(request['created_at']))
                          : 'No date',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
Widget _detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    ),
  );
}
