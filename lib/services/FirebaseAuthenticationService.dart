import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class FirebaseAuthenticationService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<void> registerWithEmail(BuildContext context, String email, String password, String confirmPassword, Function switchLoading) async {
    switchLoading();
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill up all the fields");
      switchLoading();
      return;
    }
    if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email address");
      switchLoading();
      return;
    }
    if (password != confirmPassword) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      switchLoading();
      return;
    }
    if (password.length < 6) {
      Fluttertoast.showToast(msg: "Password must be atleast 6 characters long");
      switchLoading();
      return;
    }
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      user.sendEmailVerification();
      print(user.uid);
      Navigator.of(context).pushReplacementNamed('/init');
    } on PlatformException catch (e) {
      switchLoading();
      switchLoading();
      print(e.code);
      switch (e.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          Fluttertoast.showToast(msg: "This email is linked to an existing account");
          break;
        default:
          switchLoading();
          Fluttertoast.showToast(msg: "Error completing Registration");
      }
    } catch (e) {
      print(e);
      switchLoading();
    }
    switchLoading();
  }

  Future<void> loginWithEmail(BuildContext context, String email, String password, Function switchLoading) async {
    switchLoading();
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill up all the fields.");
      switchLoading();
      return;
    }
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result.user.email);
      switchLoading();
      Navigator.of(context).pushReplacementNamed('/init');
    } on PlatformException catch (e) {
      print(e.code);
      switchLoading();
      switch (e.code) {
        case 'ERROR_WRONG_PASSWORD':
          Fluttertoast.showToast(msg: "Wrong Password");
          break;
        case 'ERROR_USER_NOT_FOUND':
          Fluttertoast.showToast(msg: "This email is not linked to any account");
          break;
        default:
          Fluttertoast.showToast(msg: "Authentication Problem");
      }
    } catch (e) {
      print(e);
      switchLoading();
    }
  }

  void sendVerificationMail() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      user.sendEmailVerification();
      Fluttertoast.showToast(msg: "Email sent!");
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error sending email! Try later!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
  
  void sendPasswordResetEmail(BuildContext context, String email, Function successTrigger) {
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your email address");
      return;
    }
    if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email address.");
      return;
    }
    try {
      _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Mail sent",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG
      );
      successTrigger();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error sending mail. Please try later",
        backgroundColor: Colors.red,
        textColor: Colors.white
      );
    }
  }

  void refreshAndCheck(BuildContext context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await user.reload();
    if (user.isEmailVerified) {
      Fluttertoast.showToast(
        msg: "Email verifed!",
        backgroundColor: Colors.green,
        textColor: Colors.white
      );
      Navigator.of(context).pushReplacementNamed('/init');
    } else {
      Fluttertoast.showToast(
        msg: "Email not verified!",
        backgroundColor: Colors.red,
        textColor: Colors.white
      );
    }
  }

  Future<void> logOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/init', (_) => false);
  }

}
