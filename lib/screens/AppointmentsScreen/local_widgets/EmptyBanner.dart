import 'package:flutter/material.dart';

Widget emptyBanner(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/images/empty.png'),
        Text(
          'No Active Appointments',
          style: TextStyle(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Varela',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}