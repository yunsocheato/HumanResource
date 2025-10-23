import 'package:flutter/material.dart';

class errormessage extends StatelessWidget {
  final String tittle;
  const errormessage({super.key, required this.tittle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 250,
          width: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/nodata.png', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          tittle,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
