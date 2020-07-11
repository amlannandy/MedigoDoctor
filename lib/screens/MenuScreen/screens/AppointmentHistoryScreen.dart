import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../local_widgets/HistoryCard.dart';
import '../../../models/Appointment.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../../HomeScreen/local_widgets/CustomAppBar.dart';
import '../../AppointmentsScreen/local_widgets/EmptyBanner.dart';

class AppointmentHistoryScreen extends StatelessWidget {

  final _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: customAppBar(context, 'Appointment History'),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('appointments').where('doctorId', isEqualTo: user.uid).where('isBooked', isEqualTo: true).snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingSpinner(context);
          }
          if (!snapshot.hasData) {
            return Container();
          }
          final appointmentDocuments = snapshot.data.documents;
          print(appointmentDocuments);
          List<Appointment> appointments = [];
          appointmentDocuments.forEach((doctor) {
            appointments.add(Appointment.fromFirestore(doctor));
          });
          if (appointments.isEmpty) {
            return emptyBanner(context);
          }
          appointments.sort((a, b) => a.lastTimestamp.toDate().compareTo(b.lastTimestamp.toDate()));
          appointments.reversed;
          appointments = new List.from(appointments.reversed);
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (ctx, index) => HistoryCard(appointments[index]),
            itemCount: appointments.length,
          );
        },
      ),
    );
  }
}