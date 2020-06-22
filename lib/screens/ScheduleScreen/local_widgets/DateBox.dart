import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/ScheduleProvider.dart';

Widget dateBox(BuildContext context, Timestamp day) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        ScheduleProvider.getFormattedDate(day),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'Lato',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        ScheduleProvider.getDayOfTheWeek(day),
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontFamily: 'Lato',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}