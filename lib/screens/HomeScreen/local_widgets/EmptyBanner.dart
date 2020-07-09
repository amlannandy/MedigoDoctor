import 'package:flutter/material.dart';

import '../../../widgets/PrimaryButton.dart';

Widget emptyBanner(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/images/empty.png'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Add your clinic now to get offline appointments here',
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Varela',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        PrimaryButton(
          text: 'ADD CLINIC', 
          press: () => Navigator.of(context).pushNamed('/addclinic'), 
          color: Theme.of(context).primaryColor,
        )
      ],
    ),
  );
}