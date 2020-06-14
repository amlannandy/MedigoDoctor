import 'package:flutter/material.dart';

import '../widgets/PrimaryButton.dart';
import '../widgets/CustomTextField.dart';
import '../services/FirebaseAuthenticationService.dart';

class PasswordResetScreen extends StatefulWidget {

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {

  bool _mailSent = false;

  final FirebaseAuthenticationService _auth = FirebaseAuthenticationService();
  final _emailController = TextEditingController();

  void _successTrigger() => setState(() => _mailSent = true);

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
                _mailSent ? 'Password Reset Link Sent' : 'Password Reset',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Text(
                _mailSent ? 'Please check your mail' : 'Enter your email to get the reset link',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Image.asset('assets/images/reset.png'),
              CustomTextField(
                labelText: 'Your Email',
                icon: Icons.mail,
                controller: _emailController,
              ),
              PrimaryButton(
                text: 'SEND MAIL',
                press: () => _auth.sendPasswordResetEmail(context, _emailController.text, _successTrigger),
                color: Theme.of(context).primaryColor,
              ),
              PrimaryButton(
                text: 'GO BACK',
                press: () => Navigator.of(context).pop(),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}