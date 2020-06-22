import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../../models/Appointment.dart';
import '../local_widgets/TimeSlotCard.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../../../services/ScheduleProvider.dart';
import '../local_widgets/TimeSlotModalSheet.dart';
import '../local_widgets/AvailibilityAppBar.dart';
import '../local_widgets/EmptyBanner.dart';

class AvailibiltyScreen extends StatelessWidget {

  void openSheet(BuildContext context, Timestamp timestamp) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) =>   TimeSlot(timestamp),
    );
  }

  @override
  Widget build(BuildContext context) {

    final Timestamp date = ModalRoute.of(context).settings.arguments;
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: availibilityAppBar(context, date, () => openSheet(context, date)),
      body: user == null ? loadingSpinner(context) : StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('appointments')
          .where('doctorId', isEqualTo: user.uid)
          .where('date', isEqualTo: ScheduleProvider.getFormattedDate(date))
          .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingSpinner(context);
          }
          print(snapshot.data.documents);
          final docs = snapshot.data.documents;
          List<Appointment> appointments = [];
          docs.forEach((doc) => appointments.add(Appointment.fromFirestore(doc)));
          if (appointments.isEmpty) {
            return emptyBanner(context);
          }
          return ListView.builder(
            itemBuilder: (ctx, index) => timeSlotCard(context, appointments[index]),
            itemCount: appointments.length,
          );
        }
      ),
    );
  }
}