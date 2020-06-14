import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Appointment.dart';
import '../widgets/AppointmentCard.dart';
import '../widgets/CustomText.dart';

class AppointmentsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: user == null ? loadingBanner() : Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.025,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Text(
              'Your Sessions',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.78,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('appointments').where('doctorId', isEqualTo: user.uid).snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingBanner();
                }
                if (!snapshot.hasData) {
                  return emptyBanner(context);
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
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (ctx, index) => AppointmentCard(appointments[index]),
                  itemCount: appointments.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingBanner() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
      ),
    );
  }

  Widget emptyBanner(BuildContext context) {
    return Center(
      child: CustomText(
        text: "No Appointments",
        size: 16,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
  
}