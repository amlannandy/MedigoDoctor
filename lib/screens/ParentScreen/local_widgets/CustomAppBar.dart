import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../models/Doctor.dart';
import '../../../services/UserDatabaseService.dart';

final UserDatabaseService userDatabaseService = UserDatabaseService();

Widget customAppBar(BuildContext context, String userId) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).primaryColor,
    title: Container(
      child: FutureBuilder<Doctor>(
        future: userDatabaseService.getDoctor(userId),
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
                width: 9,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'Lato',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.field,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'Lato',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          );
        }
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          LineIcons.bell,
          color: Colors.white.withOpacity(0.8),
        ),
        onPressed: () {},
      ),
    ],
    bottom: PreferredSize(child: Container(color: Colors.white.withOpacity(0.8), height: 0.4,), preferredSize: Size.fromHeight(4.0)),
  );
}