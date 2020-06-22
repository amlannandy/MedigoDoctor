import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './Message.dart';

class Appointment {

  final String id;
  final String doctorId;
  final String userId;
  final List<Message> messages;
  final String time;
  final String date;
  final String channelId;
  final bool videoCallActive;
  final bool audioCallActive;
  final String lastMessage;
  final Timestamp lastTimestamp;
  final bool unread;
  final Timestamp userLastSeen;
  final Timestamp doctorLastSeen;

  const Appointment({
    @required this.id,
    @required this.doctorId,
    @required this.userId,
    this.messages,
    this.time,
    this.channelId,
    this.videoCallActive,
    this.audioCallActive,
    this.lastMessage,
    this.lastTimestamp,
    this.unread,
    this.userLastSeen,
    this.doctorLastSeen,
    this.date,
  });

  factory Appointment.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null)
      return null;
    Appointment appointment = Appointment(
      id: snapshot.documentID ?? null,
      doctorId: data['doctorId'] ?? null,
      userId: data['userId'] ?? null,
      messages: data['messages'] ?? null,
      time: data['time'] ?? null,
      channelId: data['channelId'] ?? null,
      videoCallActive: data['videoCallActive'] ?? false,
      audioCallActive: data['audioCallActive'] ?? false,
      lastMessage: data['lastMessage'] ?? 'Send a message...',
      lastTimestamp: data['lastTimestamp'] ?? data['startTime'],
      unread: data['unread'] ?? false,
      userLastSeen: data['userLastSeen'] ?? Timestamp.now(),
      doctorLastSeen: data['doctorLastSeen'] ?? Timestamp.now(),
      date: data['date'] ?? null,
    );
    return appointment;
  }

}