import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/LoadingSpinner.dart';
import '../../../models/Appointment.dart';
import '../local_widgets/EmptyBanner.dart';
import '../local_widgets/AppointmentCard.dart';

Widget appointmentsList(BuildContext context, String userId) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('appointments').where('doctorId', isEqualTo: userId).where('isBooked', isEqualTo: true).snapshots(),
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
          itemBuilder: (ctx, index) => AppointmentCard(appointments[index]),
          itemCount: appointments.length,
        );
      },
    ),
  );
}