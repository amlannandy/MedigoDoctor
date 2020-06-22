import 'package:flutter/material.dart';

Widget ongoingCallCover(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    child: Center(
      child: Icon(
        Icons.call,
        color: Colors.green,
        size: 90,
      ),
    ),
  );
}
