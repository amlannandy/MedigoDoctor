import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../local_widgets/DateBox.dart';
import '../local_widgets/CountBox.dart';

Widget scheduleCard(BuildContext context, Timestamp timestamp) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(
      top: 10,
      left: 10,
      right: 10,
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey[350],
          blurRadius: 20.0,
          spreadRadius: 0.02,
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Colors.black.withOpacity(0.2),
        width: 0.4,
      )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        dateBox(context, timestamp),
        Container(
          height: 110,
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.8,
              color: Colors.grey.withOpacity(0.4),
            )
          ),
        ),
        countBox(context, timestamp),
      ],
    ),
  );
}