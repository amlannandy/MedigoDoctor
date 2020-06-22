import 'package:flutter/material.dart';

import '../../../models/Message.dart';
import '../../../models/Appointment.dart';
import '../../../services/ScheduleProvider.dart';

Widget messageBubble(BuildContext context, Message message, String userId, Appointment appointment) {
  return Container(
    margin: EdgeInsets.only(
      top: 10,
      left: userId == message.senderId ? 0 : 10,
      right: userId == message.senderId ? 10 : 0,
    ),
    width: MediaQuery.of(context).size.width,
    alignment: userId == message.senderId ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: userId == message.senderId ? Theme.of(context).primaryColor.withOpacity(0.6) : Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(25)
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: <Widget>[
          Container(
            alignment: userId == message.senderId ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              message.message,
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 16,
                color: Colors.white
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            alignment: userId == message.senderId ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: userId == message.senderId ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  ScheduleProvider.getFormattedTime(message.timestamp),
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                userId != message.senderId ? Container() : SizedBox(width: 10),
                userId != message.senderId ? Container() : Text(
                  message.timestamp.toDate().compareTo(appointment.doctorLastSeen.toDate()) < 0 ? 'R' : '',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}