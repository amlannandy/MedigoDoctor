import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {

  final TextEditingController controller;
  final String labelText;

  PasswordField({
    @required this.controller,
    @required this.labelText,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: widget.labelText,
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}