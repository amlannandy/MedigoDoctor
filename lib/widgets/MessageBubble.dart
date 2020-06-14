import 'package:flutter/material.dart';

import '../models/Message.dart';

Widget messageBubble(BuildContext context, Message message, String userId) {
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
      child: Text(
        message.message,
        style: TextStyle(
          fontFamily: 'Varela',
          fontSize: 14,
          color: Colors.white
        ),
      ),
    ),
  );
}