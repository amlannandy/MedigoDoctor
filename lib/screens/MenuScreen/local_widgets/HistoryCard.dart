import 'package:flutter/material.dart';

import '../../../models/MedigoUser.dart';
import '../../../models/Appointment.dart';
import '../../../services/UserDatabaseService.dart';

class HistoryCard extends StatelessWidget {

  final UserDatabaseService userDatabaseService = UserDatabaseService();

  final Appointment appointment;

  HistoryCard(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[350],
            blurRadius: 20.0,
            spreadRadius: 0.02,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          detailsContainer(context, appointment.date, appointment.time),
          patientDetails(appointment.userId),
        ],
      ),
    );
  }

  Widget detailsContainer(BuildContext context, String date, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          date,
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 22,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget patientDetails(String userId) {
    return StreamBuilder<MedigoUser>(
      stream: userDatabaseService.streamUser(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
          return Container();
        }
        final user = snapshot.data;
        return Column(
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              user.name,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 13,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }
    );
  }
}