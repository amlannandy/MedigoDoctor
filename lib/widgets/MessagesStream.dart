import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Message.dart';
import '../widgets/MessageBubble.dart';

class MessagesStream extends StatelessWidget {

  final String appointmentId;

  MessagesStream(this.appointmentId);

  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return user == null ? Container() : StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('appointments').document(appointmentId).collection('messages').snapshots(),
      builder: (context, snapshot) {
        var messageDocuments;
        List<Message> messages = [];
        if (snapshot.hasData) {
          messageDocuments = snapshot.data.documents;
          if (messageDocuments != null) {
            messageDocuments.forEach((message) {
              messages.add(Message.fromFirestore(message));
            });
          }
        }
        if (messages.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                'No Messages',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 32,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          );
        } 
        messages = [...messages.reversed];
        return Expanded(
          child: ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) => messageBubble(context, messages[index], user.uid),
            itemCount: messages.length,
          ),
        );
      }
    );
  }
}