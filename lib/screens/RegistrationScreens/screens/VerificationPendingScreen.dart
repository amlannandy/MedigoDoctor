import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/Doctor.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../services/UserDatabaseService.dart';
import '../../../services/FirebaseAuthenticationService.dart';

class VerificationPendingScreen extends StatelessWidget {

  final FirebaseAuthenticationService _auth = FirebaseAuthenticationService();
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: user == null ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
            ),
          ) : StreamBuilder<Doctor>(
            stream: userDatabaseService.streamDoctor(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                return Container();
              }
              final doctor = snapshot.data;
              if (doctor.isVerified) {
                new Future.delayed(Duration(milliseconds: 300), () {
                  Navigator.of(context).pushReplacementNamed('/init');
                });
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Verification Pending',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 26,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      'You will be logged in and notified as soon as we have verified your Registation',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Image.asset('assets/images/verification.png'),
                  ),
                  SizedBox(height: 20),
                  PrimaryButton(
                    text: 'LOG OUT',
                    press: () => _auth.logOut(context),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}