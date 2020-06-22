import 'package:flutter/material.dart';

import '../../../models/Appointment.dart';

Widget timeSlotCard(BuildContext context, Appointment appointment) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(
      top: 10,
      left: 10,
      right: 10,
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
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.black.withOpacity(0.8),
        width: 0.4,
      )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                appointment.date,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20,
                ),
              ),
              Text(
                appointment.time,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        statusSection(appointment.userId != null),
      ],
    ),
  );
}

Widget  statusSection(bool isBooked) {
  return Container(
    width: 140,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: isBooked ? Colors.green : Colors.amber[700],
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Column(
      children: <Widget>[
        Text(
          'Status',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Varela',
            fontSize: 16,
          ),
        ),
        Text(
          isBooked ? 'Booked' : 'Empty',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Varela',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}