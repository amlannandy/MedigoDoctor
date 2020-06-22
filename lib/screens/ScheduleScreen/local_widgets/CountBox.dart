import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../local_widgets/SmallIconButton.dart';
import '../../../services/ScheduleProvider.dart';

Widget countBox(BuildContext context, Timestamp timestamp) {
  return Column(
    children: <Widget>[
      Text(
        'No. of\nAppointments',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'Lato',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('appointments').where('date', isEqualTo: ScheduleProvider.getFormattedDate(timestamp)).snapshots(),
        builder: (context, snapshot) {
          int count = 0;
          int total = 0;
          if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
            final docs = snapshot.data.documents;
            docs.forEach((doc) {
              if (doc['userId'] != null) {
                count++;
              }
              total++;
            });
          }
          return Text(
            count.toString() + " / " + total.toString(),
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontFamily: 'Lato',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      ),
      SizedBox(height: 15),
      smallIconButton(
        context,
        text: 'Check',
        icon: LineIcons.play_circle,
        onPress: () => Navigator.of(context).pushNamed('/availibility', arguments: timestamp)
      ),
    ],
  );
}