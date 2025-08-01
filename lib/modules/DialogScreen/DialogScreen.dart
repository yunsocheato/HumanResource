import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void DialogScreen(BuildContext context, Widget content) {
  final isMobile = MediaQuery.of(context).size.width < 600;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.all(16), // dialog margin
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 500,
          constraints: BoxConstraints(maxHeight: 350),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header row
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'EDIT DETAILS',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.blue.shade900),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              // Content scrollable area
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: content,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
