import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/InitScreen.dart';
import 'screens/ParentScreen/ParentScreen.dart';
import 'screens/HomeScreen/AddClinicScreen.dart';
import 'screens/MenuScreen/screens/WebViewScreen.dart';
import 'screens/MenuScreen/screens/EditProfileScreen.dart';
import 'screens/RegistrationScreens/screens/LoginScreen.dart';
import 'screens/ScheduleScreen/screens/AvailibiltyScreen.dart';
import 'screens/RegistrationScreens/screens/UserInfoScreen.dart';
import 'screens/MenuScreen/screens/AppointmentHistoryScreen.dart';
import 'screens/RegistrationScreens/screens/PasswordResetScreen.dart';
import 'screens/RegistrationScreens/screens/EmailVerificationScreen.dart';
import 'screens/RegistrationScreens/screens/VerificationPendingScreen.dart';

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
          '/webview' : (ctx) => WebViewScreen(),
          '/availibility' : (ctx) => AvailibiltyScreen(),
          '/passwordreset' : (ctx) => PasswordResetScreen(),
          '/emailverification' : (ctx) => EmailVerificationScreen(),
          '/verificationpending' : (ctx) => VerificationPendingScreen(),
          '/addclinic' : (ctx) => AddClinicScreen(),
          '/history' : (ctx) => AppointmentHistoryScreen(),
          '/editprofile' : (ctx) => EditProfileScreen(),
        },
      ),
    );
  }
}