import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './local_widgets/TimeSlotSheet.dart';
import '../../models/Clinic.dart';
import './local_widgets/ClinicDetails.dart';
import '../../widgets/LoadingSpinner.dart';
import '../../widgets/PrimaryButton.dart';
import '../../services/UserDatabaseService.dart';
import './local_widgets/EmptyBanner.dart';

class HomeScreen extends StatelessWidget {

  final String clinicId;

  HomeScreen(this.clinicId);

  final UserDatabaseService userDatabaseService = UserDatabaseService();

  void openSheet(BuildContext context, Timestamp timestamp) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) =>   TimeSlotSheet(timestamp),
    );
  }

  @override
  Widget build(BuildContext context) {

    return clinicId == null ? emptyBanner(context) : StreamBuilder<Clinic>(
      stream: userDatabaseService.streamClinic(clinicId),
      builder: (context, snapshot) {
        final clinic = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
          return loadingSpinner(context);
        }
        return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                clinicDetails(context, clinic),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Weekly Stats',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(0.8),
                          fontSize: 22,
                          fontFamily: 'Varela',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          pocketData('Appointments', 15.toString()),
                          pocketData('Patients', 7.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  text: 'VIEW APPOINTMENTS', 
                  press: () => Navigator.of(context).pushNamed('/availibility', arguments: Timestamp.now()), 
                  color: Theme.of(context).primaryColor,
                ),
                PrimaryButton(
                  text: 'ADD TIME SLOT', 
                  press: () => openSheet(context, Timestamp.now()), 
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}