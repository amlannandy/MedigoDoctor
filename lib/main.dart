import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/InitScreen.dart';
import './screens/LoginScreen.dart';
import './screens/ParentScreen.dart';
import './screens/ProfileScreen.dart';
import './screens/UserInfoScreen.dart';
import './screens/PasswordResetScreen.dart';
import './screens/EmailVerificationScreen.dart';
import './screens/VerificationPendingScreen.dart';

void main() => runApp(MedigoDoctorApp());

class MedigoDoctorApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff581b98),
          accentColor: Colors.purple[200],
          textTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        initialRoute: '/init',
        routes: {
          '/init' : (ctx) => InitScreen(),
          '/login' : (ctx) => LoginScreen(),
          '/userinfo' : (ctx) => UserInfoScreen(),
          '/parent' : (ctx) => ParentScreen(),
          '/profile' : (ctx) => ProfileScreen(),
          '/emailverification' : (ctx) => EmailVerificationScreen(),
          '/passwordreset' : (ctx) => PasswordResetScreen(),
          '/verificationpending' : (ctx) => VerifiationPendingScreen(),
        },
      ),
    );
  }
}