import 'package:flutter/material.dart';

import '../widgets/PrimaryButton.dart';
import '../services/FirebaseAuthenticationService.dart';

class EmailVerificationScreen extends StatelessWidget {

  final FirebaseAuthenticationService _auth = FirebaseAuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Verification Email Sent',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Please check your email',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Image.asset('assets/images/waiting.png'),
              PrimaryButton(
                text: 'REFRESH',
                press: () => _auth.refreshAndCheck(context),
                color: Theme.of(context).primaryColor,
              ),
              PrimaryButton(
                text: 'RESEND MAIL',
                press: () => _auth.sendVerificationMail(),
                color: Theme.of(context).primaryColor,
              ),
              PrimaryButton(
                text: 'LOG OUT',
                press: () => _auth.logOut(context),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

}