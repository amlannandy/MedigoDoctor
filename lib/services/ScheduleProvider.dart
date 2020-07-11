import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScheduleProvider {

  static String getFormattedDate(Timestamp timestamp) {
    return DateFormat('dd-MM-yyyy').format(timestamp.toDate()).toString();
  }

  static String getFormattedTime(Timestamp timestamp) {
    return DateFormat('kk:mm').format(timestamp.toDate());
  }

  static String getDayOfTheWeek(Timestamp timestamp) {
    int dayNumber = timestamp.toDate().weekday;
    String day;
    switch(dayNumber) {
      case 1:
        day = "Monday";
        break;
      case 2:
        day = "Tuesday";
        break;
      case 3:
        day = "Wednesday";
        break;
      case 4:
        day = "Thursday";
        break;
      case 5:
        day = "Friday";
        break;
      case 6:
        day = "Saturday";
        break;
      case 7:
        day = "Sunday";
        break;
      default:
        day = "Default";
    }
    return day;
  }

  static List<Timestamp> getNext7Days() {
    Timestamp today = Timestamp.now();
    List<Timestamp> dates = [];
    for (int i=0; i<7; i++) {
      dates.add(Timestamp.fromDate(today.toDate().add(Duration(days: i))));
    }
    return dates;
  }

  static showTimeChooser(BuildContext context, Timestamp timestamp, Function getValues) async {
    TimeOfDay timeSlot = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.fromDateTime(timestamp.toDate()),
    );
    if (timeSlot != null) {
      getValues(timeSlot);
    }
  }

  static createAppointment({ BuildContext context, Timestamp timestamp, String timeSlot, TimeOfDay startTime, TimeOfDay endTime }) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DateTime date = timestamp.toDate();
    DateTime startDate = new DateTime(
      date.year,
      date.month,
      date.day,
      startTime.hour,
      startTime.minute,
    );
    Timestamp start = Timestamp.fromDate(startDate);
    DateTime endDate = new DateTime(
      date.year,
      date.month,
      date.day,
      endTime.hour,
      endTime.minute,
    );
    Timestamp end = Timestamp.fromDate(endDate);
    String appointmentId = Firestore.instance.collection('appointments').document().documentID;
    Firestore.instance.collection('appointments').document(appointmentId).setData({
      'time' : timeSlot,
      'startTime' : start,
      'endTime' : end,
      'doctorId' : user.uid,
      'date' : getFormattedDate(timestamp),
      'doctorLastSeen' : Timestamp.now(),
      'userLastSeen' : Timestamp.now(),
    });
    Firestore.instance.collection('prescriptions').document(appointmentId).setData({
      'doctorId' : user.uid,
      'date' : getFormattedDate(timestamp),
    });
    Firestore.instance.collection('medicalreports').document(appointmentId).setData({
      'doctorId' : user.uid,
      'date' : getFormattedDate(timestamp),
    });
    Fluttertoast.showToast(
      msg: 'Time slot created!',
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
    Navigator.of(context).pop();
  }

}