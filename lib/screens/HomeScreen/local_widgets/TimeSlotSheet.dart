import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgets/PrimaryButton.dart';
import '../../../services/ScheduleProvider.dart';

class TimeSlotSheet extends StatefulWidget {

  final Timestamp timestamp;

  TimeSlotSheet(this.timestamp);

  @override
  _TimeSlotSheetState createState() => _TimeSlotSheetState();
}

class _TimeSlotSheetState extends State<TimeSlotSheet> {

  TimeOfDay startTime;
  TimeOfDay endTime;
  String timeSlotInString;

  void formatTimeSlot(TimeOfDay timeOfDay) {
    startTime = timeOfDay;
    int hours = startTime.hour;
    int minutes = startTime.minute;
    endTime = startTime.replacing(
      hour: minutes >= 30 ? ( hours == 23 ? 0 : hours + 1) : hours,
      minute: minutes >= 30 ? 30 - (60-minutes) : minutes+30,
    );
    print('Start Time - $startTime');
    print('End Time - $endTime');
    setState(() {
      timeSlotInString = "${startTime.format(context)} to ${endTime.format(context)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.8),
                  width: 0.5,
                ),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    'Add Time Slot',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(
                color: Colors.black.withOpacity(0.8),
                width: 0.7,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              timeSlotInString ?? 'Select a Time Slot (30 minutes)',
              style: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                fontFamily: 'Varela',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          PrimaryButton(
            text: 'Select Time'.toUpperCase(),
            press: () => ScheduleProvider.showTimeChooser(context, widget.timestamp, formatTimeSlot),
            color: Theme.of(context).accentColor,
          ),
          PrimaryButton(
            text: 'Save'.toUpperCase(),
            press: () => ScheduleProvider.createAppointment(
              context: context,
              timeSlot: timeSlotInString,
              timestamp: widget.timestamp,
              startTime: startTime,
              endTime: endTime,
            ),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}