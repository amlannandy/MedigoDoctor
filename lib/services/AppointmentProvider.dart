import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/ChatScreen/screens/VideoCallScreen.dart';

class AppointmentProvider {

  static Firestore _firestore = Firestore.instance;
  static final uuid = Uuid();

  static void sendMessage(String appointmentId, String userId, String patientId, String message) {
    if (message.isEmpty) {
      return;
    }
    _firestore.collection('appointments').document(appointmentId).collection('messages').document(Timestamp.now().toString()).setData({
      'senderId' : userId,
      'receiverId' : patientId,
      'message' : message,
      'timestamp' : Timestamp.now(),
    });
    _firestore.collection('appointments').document(appointmentId).updateData({
      'lastMessage' : message,
      'lastTimestamp' : Timestamp.now(),
      'doctorLastSeen' : Timestamp.now(),
    });
  }

  static void updateLastSeen(String appointmentId) {
    Firestore.instance.collection('appointments').document(appointmentId).updateData({
      'doctorLastSeen' : Timestamp.now(),
    });
  }

  static void createAudioVideoChannel(BuildContext context, String appointmentId, bool audioOnly) {
    Firestore.instance.collection('appointments').document(appointmentId).get().then((data) {
      String channelId = data['channelId'];
      if (channelId == null) {
        channelId = uuid.v4();
        Firestore.instance.collection('appointments').document(appointmentId).updateData({
          'channelId': channelId,
        });
      }
      if (audioOnly) {
        Firestore.instance.collection('appointments').document(appointmentId).updateData({
          'audioCallActive': true,
        });
      } else {
        Firestore.instance.collection('appointments').document(appointmentId).updateData({
          'videoCallActive': true,
        });
      }
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => VideoCallScreen(
              channelName: channelId,
              appointmentId: appointmentId,
              audioOnly: audioOnly,
            ),
          ),
        );
      },
    );
  }

  static void endVideoChannel(BuildContext context, String appointmentId) {
    Firestore.instance.collection('appointments').document(appointmentId).updateData({
      'videoCallActive': false,
    });
    Navigator.of(context).pop(true);
  }

  static void endAudioChannel(BuildContext context, String appointmentId) {
    Firestore.instance.collection('appointments').document(appointmentId).updateData({
      'audioCallActive': false,
    });
    Navigator.of(context).pop(true);
  }

  static void startVideoCall(BuildContext context, String appointmentId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Confirmation",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        content: Text(
          "Are you sure you start a Video Session?",
          style: TextStyle(color: Colors.grey, fontFamily: 'Lato')
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Yes",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              createAudioVideoChannel(context, appointmentId, false);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              "No",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static void startAudioCall(BuildContext context, String appointmentId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Confirmation",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        content: Text(
          "Are you sure you start an Audio Call?",
          style: TextStyle(color: Colors.grey, fontFamily: 'Lato')
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Yes",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              createAudioVideoChannel(context, appointmentId, true);
              Navigator.of(context).pop();
            }
          ),
          FlatButton(
            child: Text(
              "No",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () =>Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

}