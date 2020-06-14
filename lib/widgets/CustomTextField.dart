import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final bool numeric;

  CustomTextField({
    @required this.controller,
    @required this.icon,
    @required this.labelText,
    this.numeric = false,
  });

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
        controller: controller,
        keyboardType: numeric ? TextInputType.number : TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: labelText,
          icon: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}