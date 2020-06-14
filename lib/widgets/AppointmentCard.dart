import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:medigo_doctor/models/MedigoUser.dart';

import '../widgets/CustomText.dart';
import '../models/Appointment.dart';
import '../screens/ChatScreen.dart';
import '../services/UserDatabaseService.dart';

class AppointmentCard extends StatelessWidget {

  final Appointment appointment;

  AppointmentCard(this.appointment);

  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: 15,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
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
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          profileRow(appointment),
          buttonsRow(context, appointment),
        ],
      ),
    );
  }

  Widget profileRow(Appointment appointment) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: StreamBuilder<MedigoUser>(
        stream: userDatabaseService.streamUser(appointment.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            return Container();
          }
          final user = snapshot.data;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 0.4,
                    color: Colors.grey
                  )
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(user.imageUrl),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    FittedBox(
                      child: Text(
                        user.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Varela',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      user.city,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Varela',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        DateFormat('dd-MM-yyyy').format(appointment.time.toDate()),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(0.7),
                          fontFamily: 'Lato',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('kk:mm').format(appointment.time.toDate()),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'Lato',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Status - Active',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Lato',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          );
        }
      ),
    );
  }

  Widget buttonsRow(BuildContext context, Appointment appointment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        lightButton(context, appointment),
        darkButton(context, appointment),
      ],
    );
  }

  Widget lightButton(BuildContext context, Appointment appointment) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15)
          ),
          color: Theme.of(context).accentColor.withOpacity(0.2),
        ),
        child: CustomText(
          text: "Documents",
          size: 18,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget darkButton(BuildContext context, Appointment appointment) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ChatScreen(appointment))),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15)
          ),
          color: Theme.of(context).primaryColor.withOpacity(0.9),
        ),
        child: CustomText(
          text: "Chat",
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }

}