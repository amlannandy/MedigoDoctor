import 'package:flutter/material.dart';

Widget customAppBar(BuildContext context, String title, { Function popCall }) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black.withOpacity(0.7),
      ),
      onPressed: () {
        if (popCall != null) {
          popCall();
        }
        Navigator.of(context).pop();
      }
    ),
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontFamily: 'Lato',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),    
    ),
  );
}