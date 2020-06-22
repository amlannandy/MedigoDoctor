import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './EmptyBanner.dart';
import '../../../models/Message.dart';
import '../../../models/Appointment.dart';
import '../local_widgets/MessageBubble.dart';
import '../../../widgets/LoadingSpinner.dart';

class MessagesStream extends StatelessWidget {

  final Appointment appointment;

  MessagesStream(this.appointment);

  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return user == null ? Container() : StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('appointments').document(appointment.id).collection('messages').snapshots(),
      builder: (context, snapshot) {
        var messageDocuments;
        List<Message> messages = [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(child: loadingSpinner(context));
        }
        if (snapshot.hasData) {
          messageDocuments = snapshot.data.documents;
          if (messageDocuments != null) {
            messageDocuments.forEach((message) {
              messages.add(Message.fromFirestore(message));
            });
          }
        }
        if (messages.isEmpty) {
          return Expanded(child: emptyBanner(context));
        }
        messages = [...messages.reversed];
        return Expanded(
          child: ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) => messageBubble(context, messages[index], user.uid, appointment),
            itemCount: messages.length,
          ),
        );
      }
    );
  }
}