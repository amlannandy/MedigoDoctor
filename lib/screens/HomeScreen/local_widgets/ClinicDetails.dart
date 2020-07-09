import 'package:flutter/material.dart';

import '../../../models/Clinic.dart';

Widget clinicDetails(BuildContext context, Clinic clinic) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 15,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(clinic.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              clinic.name,
              style: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                fontSize: 22,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              child: Text(
                clinic.address,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget pocketData(String upperText, String lowerText) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        Text(
          upperText,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontFamily: 'Varela',
          ),
        ),
        Text(
          lowerText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Varela',
          ),
        ),
      ],
    ),
  );
}