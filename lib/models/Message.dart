import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {

  final String message;
  final String senderId;
  final Timestamp timestamp;

  const Message({
    @required this.message,
    @required this.senderId,
    @required this.timestamp,
  });

  factory Message.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null)
      return null;
    Message message = Message(
      senderId: data['senderId'] ?? null,
      message: data['message'] ?? null,
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
    return message;
  }

}