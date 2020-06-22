import 'package:flutter/material.dart';

Widget emptyBanner(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/images/empty.png'),
        Text(
          'No Messages yet',
          style: TextStyle(
            color: Colors.black.withOpacity(0.4),
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