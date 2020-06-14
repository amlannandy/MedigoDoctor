import 'package:flutter/material.dart';

import '../widgets/CustomTextField.dart';
import '../widgets/PasswordField.dart';
import '../widgets/PrimaryButton.dart';
import '../services/FirebaseAuthenticationService.dart';

enum AuthMode {
  Login,
  Register,
}

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FirebaseAuthenticationService _auth = FirebaseAuthenticationService();

  void _switchLoading() => setState(() => _isLoading = !_isLoading);

  void _switchAuthMode() {
    setState(() {
      if (_authMode == AuthMode.Login)
        _authMode = AuthMode.Register;
      else
        _authMode = AuthMode.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          getBackground(context),
          getLoginCard(context),
        ],
      ),
    );
  }

  Widget getBackground(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget getLoginCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50)
        )
      ),
      child: _isLoading ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
        ),
      ) : Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            _authMode == AuthMode.Login ? 'Login' : 'Register',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          CustomTextField(
            icon: Icons.account_circle,
            controller: _emailController,
            labelText: 'Email',
          ),
          PasswordField(
            labelText: 'Password',
            controller: _passwordController,
          ),
          _authMode == AuthMode.Login ? Container() : PasswordField(
            labelText: 'Confirm Password',
            controller: _confirmPasswordController,
          ),
          PrimaryButton(
            text: _authMode == AuthMode.Login ? 'LOGIN' : 'REGISTER',
            press: () {
              if (_authMode == AuthMode.Login) {
                _auth.loginWithEmail(
                  context,
                  _emailController.text,
                  _passwordController.text, 
                  _switchLoading
                );
              } else {
                _auth.registerWithEmail(
                  context,
                  _emailController.text,
                  _passwordController.text,
                  _confirmPasswordController.text,
                  _switchLoading
                );
              }
            },
            color: Theme.of(context).primaryColor
          ),
          PrimaryButton(
            text: _authMode == AuthMode.Login ? 'REGISTER INSTEAD' : 'LOGIN INSTEAD',
            press: _switchAuthMode,
            color: Theme.of(context).primaryColor
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/passwordreset'),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5
              ),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}