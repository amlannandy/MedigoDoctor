import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/ScheduleProvider.dart';

Widget availibilityAppBar(BuildContext context, Timestamp timestamp, Function addAvailibilty) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black.withOpacity(0.7),
      ),
      onPressed: () => Navigator.of(context).pop()
    ),
    backgroundColor: Colors.white,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ScheduleProvider.getFormattedDate(timestamp),
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),    
        ),
        Text(
          ScheduleProvider.getDayOfTheWeek(timestamp),
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontFamily: 'Lato',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),    
        ),
      ],
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          LineIcons.plus_circle,
          color: Colors.black.withOpacity(0.8),
        ),
        onPressed: addAvailibilty,
      ),
    ],
    bottom: PreferredSize(child: Container(color: Colors.black.withOpacity(0.8), height: 0.4,), preferredSize: Size.fromHeight(4.0)),
  );
}