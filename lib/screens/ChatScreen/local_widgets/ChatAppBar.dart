import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../models/MedigoUser.dart';
import '../../../services/UserDatabaseService.dart';
import '../../../services/AppointmentProvider.dart';

final UserDatabaseService userDatabaseService = UserDatabaseService();

Widget chatAppBar(BuildContext context, String appointmentId, String patientId) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black.withOpacity(0.7),
      ),
      onPressed: () => Navigator.of(context).pop()
    ),
    backgroundColor: Colors.white,
    title: Container(
      child: StreamBuilder<MedigoUser>(
        stream: userDatabaseService.streamUser(patientId),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return Container();
          }
          return Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.imageUrl),
                  ),
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                user.name,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontFamily: 'Lato',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          );
        }
      ),
    ),
    actions: <Widget>[
      PopupMenuButton(
        icon: Icon(
          LineIcons.gear,
          color: Colors.black.withOpacity(0.8),
        ),
        itemBuilder: (_) => [
          PopupMenuItem(
            child: InkWell(
              onTap: () => AppointmentProvider.startAudioCall(context, appointmentId),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Icon(
                      LineIcons.phone,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Audio Call",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: 'Lato',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PopupMenuItem(
            child: InkWell(
              onTap: () => AppointmentProvider.startVideoCall(context, appointmentId),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Icon(
                      LineIcons.video_camera,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Video Call",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: 'Lato',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PopupMenuItem(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Icon(
                      LineIcons.warning,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Report Patient",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: 'Lato',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ],
    bottom: PreferredSize(child: Container(color: Colors.black.withOpacity(0.8), height: 0.4,), preferredSize: Size.fromHeight(4.0)),
  );
}