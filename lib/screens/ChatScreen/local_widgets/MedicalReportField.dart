import 'package:flutter/material.dart';

class MedicalReportField extends StatelessWidget {

  final TextEditingController controller;

  MedicalReportField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        enabled: false,
        controller: controller,
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontFamily: 'Lato',
          fontSize: 18,
        ),
        maxLines: null,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none
        ),
      ),
    );
  }
}